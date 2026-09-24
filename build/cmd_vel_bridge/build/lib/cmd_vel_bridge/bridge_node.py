#!/usr/bin/env python3
import asyncio
import json
import threading

import rclpy
from geometry_msgs.msg import Twist
from rclpy.node import Node
import websockets


class CmdVelBridge(Node):
    def __init__(self):
        super().__init__('cmd_vel_bridge')
        self.declare_parameter('websocket_url', 'ws://127.0.0.1:8000/ws')
        self.declare_parameter('max_linear_mps', 0.05)
        self.declare_parameter('max_angular_rps', 0.6)
        self.declare_parameter('command_timeout_s', 0.4)
        self.declare_parameter('publish_rate_hz', 20.0)

        self.websocket_url = self.get_parameter('websocket_url').value
        self.max_linear_mps = max(float(self.get_parameter('max_linear_mps').value), 1e-6)
        self.max_angular_rps = max(float(self.get_parameter('max_angular_rps').value), 1e-6)
        self.command_timeout_s = max(float(self.get_parameter('command_timeout_s').value), 0.05)
        self.publish_rate_hz = max(float(self.get_parameter('publish_rate_hz').value), 1.0)

        self._lock = threading.Lock()
        self._latest = (0.0, 0.0, 0.0)
        self._last_cmd_time = self.get_clock().now()
        self._ws = None
        self._loop = asyncio.new_event_loop()
        self._thread = threading.Thread(target=self._run_asyncio, daemon=True)
        self._thread.start()

        self.create_subscription(Twist, '/cmd_vel', self._on_cmd_vel, 10)
        self.create_timer(1.0 / self.publish_rate_hz, self._send_latest)
        self.get_logger().info(f'Forwarding /cmd_vel to {self.websocket_url}')

    @staticmethod
    def _clamp(value):
        return max(-1.0, min(1.0, value))

    def _on_cmd_vel(self, msg):
        command = (
            self._clamp(msg.linear.x / self.max_linear_mps),
            self._clamp(msg.linear.y / self.max_linear_mps),
            self._clamp(msg.angular.z / self.max_angular_rps),
        )
        with self._lock:
            self._latest = command
            self._last_cmd_time = self.get_clock().now()

    def _current_command(self):
        with self._lock:
            age = (self.get_clock().now() - self._last_cmd_time).nanoseconds / 1e9
            return self._latest if age <= self.command_timeout_s else (0.0, 0.0, 0.0)

    def _send_latest(self):
        command = self._current_command()
        payload = json.dumps({'t': 'drive', 'vx': command[0], 'vy': command[1], 'wz': command[2]})
        if self._ws is not None:
            asyncio.run_coroutine_threadsafe(self._ws.send(payload), self._loop)

    def _run_asyncio(self):
        asyncio.set_event_loop(self._loop)
        self._loop.run_until_complete(self._connect_forever())

    async def _connect_forever(self):
        while rclpy.ok():
            try:
                async with websockets.connect(self.websocket_url, ping_interval=5, open_timeout=5) as ws:
                    self._ws = ws
                    self.get_logger().info('Connected to quadbot websocket')
                    await ws.wait_closed()
            except Exception as exc:
                self.get_logger().warning(f'Quadbot websocket unavailable: {exc}')
            finally:
                self._ws = None
            await asyncio.sleep(1.0)

    def destroy_node(self):
        self._loop.call_soon_threadsafe(self._loop.stop)
        super().destroy_node()


def main(args=None):
    rclpy.init(args=args)
    node = CmdVelBridge()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()
