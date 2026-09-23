"""
2S Battery Monitor with ADS1115 ADC & Voltage Divider
=====================================================
Reads battery voltage via ADS1115 16-bit I2C ADC.
Calculates accurate 2S LiPo battery percentage and health state.

Circuit Setup:
- 2S LiPo (6.6V - 8.4V) -> Voltage Sensor Module (5:1 divider) -> ADS1115 AIN0
- ADS1115 VDD powered at 5V
- I2C SDA/SCL through Logic Level Shifter (5V <-> 3.3V) to Pi 5 (/dev/i2c-1)
- ADS1115 Default Address: 0x48 (ADDR -> GND)
"""

import threading
import time
import logging
from .hal import get_i2c_lock

log = logging.getLogger("quadbot.battery")

# Standard LiPo discharge lookup table for 2S pack (voltage -> percentage)
LIPO_2S_TABLE = [
    (8.40, 100.0),
    (8.20, 90.0),
    (8.00, 80.0),
    (7.80, 70.0),
    (7.68, 60.0),
    (7.60, 50.0),
    (7.50, 40.0),
    (7.40, 30.0),
    (7.30, 20.0),
    (7.20, 10.0),
    (7.00, 5.0),
    (6.60, 0.0),
]


def voltage_to_percent_2s(voltage: float) -> float:
    """Interpolates 2S LiPo voltage to accurate state-of-charge percentage."""
    if voltage >= LIPO_2S_TABLE[0][0]:
        return 100.0
    if voltage <= LIPO_2S_TABLE[-1][0]:
        return 0.0

    for i in range(len(LIPO_2S_TABLE) - 1):
        v_high, p_high = LIPO_2S_TABLE[i]
        v_low, p_low = LIPO_2S_TABLE[i + 1]
        if v_low <= voltage <= v_high:
            ratio = (voltage - v_low) / (v_high - v_low)
            return p_low + ratio * (p_high - p_low)

    return 0.0


class ADS1115BatteryReader:
    """Reads 2S battery voltage using ADS1115 ADC via I2C."""

    # ADS1115 Registers
    REG_CONV = 0x00
    REG_CONFIG = 0x01

    def __init__(
        self,
        bus_num: int = 1,
        address: int = 0x48,
        channel: int = 0,
        divider_ratio: float = 5.0,
        v_min: float = 6.6,
        v_max: float = 8.4,
        v_warn: float = 7.0,
    ):
        self.bus_num = bus_num
        self.address = address
        self.channel = max(0, min(3, channel))
        self.divider_ratio = divider_ratio
        self.v_min = v_min
        self.v_max = v_max
        self.v_warn = v_warn

        self._bus = None
        self._filtered_v = None
        self._last_read_time = 0.0
        self._lock = get_i2c_lock(self.bus_num)
        self._running = True
        self._thread = None
        self._cached_state = {
            "voltage": 0.0,
            "percent": 0.0,
            "state": "initializing",
            "cells": 2,
            "present": False,
        }

        try:
            try:
                from smbus2 import SMBus
            except ImportError:
                from smbus import SMBus
            self._bus = SMBus(self.bus_num)
            log.info("ADS1115 battery monitor initialized on /dev/i2c-%d at 0x%02X (ch %d)",
                     self.bus_num, self.address, self.channel)
            self._thread = threading.Thread(target=self._worker, daemon=True)
            self._thread.start()
        except Exception as e:
            log.warning("Could not open I2C bus for ADS1115 (%s). Battery monitor disabled.", e)

    def _worker(self):
        """Background thread that updates battery state asynchronously without stalling servo ticks."""
        while self._running:
            try:
                self._update_state()
            except Exception as e:
                log.debug("Battery worker error: %s", e)
            for _ in range(15):
                if not self._running:
                    break
                time.sleep(0.1)

    def read_raw_voltage(self) -> float | None:
        """Triggers a single-shot conversion on ADS1115 and returns measured battery voltage."""
        if not self._bus:
            return None

        try:
            # Config: Single-shot, FSR = +-4.096V (PGA=001), 128 SPS
            mux = 0b100 + self.channel
            cfg_msb = 0x80 | (mux << 4) | (0b001 << 1) | 1  # 0xC3 for ch 0
            cfg_lsb = (0b100 << 5) | 0x03                  # 0x83

            # Write config register to start conversion under bus lock
            with self._lock:
                self._bus.write_i2c_block_data(self.address, self.REG_CONFIG, [cfg_msb, cfg_lsb])

            # Wait for conversion to complete without holding the bus lock
            time.sleep(0.010)

            # Read 2-byte conversion result under bus lock
            with self._lock:
                data = self._bus.read_i2c_block_data(self.address, self.REG_CONV, 2)
            raw = (data[0] << 8) | data[1]
            if raw > 32767:
                raw -= 65536

            # LSB for +-4.096V range is 4.096V / 32768 = 0.125 mV
            pin_voltage = max(0.0, raw * (4.096 / 32768.0))
            battery_voltage = pin_voltage * self.divider_ratio
            return battery_voltage

        except Exception as e:
            log.debug("ADS1115 read error: %s", e)
            return None

    def _update_state(self):
        raw_v = self.read_raw_voltage()
        now = time.monotonic()
        self._last_read_time = now

        if raw_v is None or raw_v < 1.0:
            self._cached_state = {
                "voltage": 0.0,
                "percent": 0.0,
                "state": "disconnected",
                "cells": 2,
                "present": False,
            }
            return self._cached_state

        if self._filtered_v is None:
            self._filtered_v = raw_v
        else:
            self._filtered_v = 0.75 * self._filtered_v + 0.25 * raw_v

        v = round(self._filtered_v, 2)
        pct = round(voltage_to_percent_2s(v), 1)

        if v <= self.v_min:
            health = "critical"
        elif v <= self.v_warn:
            health = "low"
        else:
            health = "ok"

        self._cached_state = {
            "voltage": v,
            "percent": pct,
            "state": health,
            "cells": 2,
            "present": True,
        }
        return self._cached_state

    def read(self) -> dict:
        """Returns cached battery telemetry immediately (non-blocking)."""
        if self._thread is None and self._bus:
            return self._update_state()
        return self._cached_state

    def close(self):
        self._running = False
        if self._bus:
            try:
                self._bus.close()
            except Exception:
                pass


class MockBatteryReader:
    """Simulated 2S battery reader for development without hardware."""

    def __init__(self, initial_voltage: float = 8.12):
        self.voltage = initial_voltage
        self.start_time = time.monotonic()

    def read(self) -> dict:
        # Slowly discharge ~0.01V every 30 seconds
        elapsed = time.monotonic() - self.start_time
        v = max(6.7, self.voltage - (elapsed / 300.0) * 0.1)
        pct = round(voltage_to_percent_2s(v), 1)
        health = "ok" if v > 7.1 else "low" if v > 6.6 else "critical"
        return {
            "voltage": round(v, 2),
            "percent": pct,
            "state": health,
            "cells": 2,
            "present": True,
            "mock": True,
        }

    def close(self):
        pass


def make_battery_reader(cfg: dict):
    """Factory to create real ADS1115 reader or mock based on configuration and hardware."""
    bcfg = cfg.get("battery", {})
    if not bcfg.get("enabled", True):
        return None

    driver_name = bcfg.get("driver", "ads1115")
    if driver_name == "mock":
        return MockBatteryReader()

    # Try hardware ADS1115
    reader = ADS1115BatteryReader(
        bus_num=bcfg.get("bus", 1),
        address=bcfg.get("address", 0x48),
        channel=bcfg.get("channel", 0),
        divider_ratio=bcfg.get("divider_ratio", 5.0),
        v_min=bcfg.get("v_min", 6.6),
        v_max=bcfg.get("v_max", 8.4),
        v_warn=bcfg.get("v_warn", 7.0),
    )

    # If I2C bus not available (e.g. running on laptop), fall back to Mock
    if not reader._bus:
        log.info("Falling back to MockBatteryReader")
        return MockBatteryReader()

    return reader
