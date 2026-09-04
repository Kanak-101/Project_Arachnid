/*
 * ============================================================================
 *  MG996R 360-Degree Servo Zero / Neutral Calibration Tool
 * ============================================================================
 *  Hardware: ESP32 + PCA9685 + SSD1306 (U8g2) + 5 Buttons
 *  Target Output: Servo on PCA9685 Channel 0
 * ============================================================================
 */

#include <Wire.h>
#include <U8g2lib.h>
#include <Adafruit_PWMServoDriver.h>

// ---------------- I2C BUS & PCA9685 ----------------
#define I2C_SDA      21
#define I2C_SCL      22
#define PCA9685_ADDR 0x40
#define PCA9685_FREQ 50  // 50 Hz standard servo frequency

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(PCA9685_ADDR);
U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);

// ---------------- HARDWARE PINS ----------------
#define btn_up    32
#define btn_down  15
#define btn_left   4
#define btn_right 25
#define btn_ok    33

#define red_led   17
#define green_led 16

// ---------------- CALIBRATION VARIABLES ----------------
int neutralUs = 1500;       // Standard 90-degree stop pulse (1500us)
bool outputEnabled = true;  // Toggle PWM signal output

bool lastBtnState[5] = {HIGH, HIGH, HIGH, HIGH, HIGH};

// Converts microsecond pulse width to PCA9685 12-bit tick count (0-4095)
uint16_t usToTicks(int us) {
    float periodUs = 1000000.0f / PCA9685_FREQ; // 20000us @ 50Hz
    float ticks = (float)us / (periodUs / 4096.0f);
    return (uint16_t)constrain(ticks, 0, 4095);
}

void updateServoSignal() {
    if (outputEnabled) {
        uint16_t ticks = usToTicks(neutralUs);
        pwm.setPWM(0, 0, ticks); // Sending signal to Channel 0
    } else {
        pwm.setPWM(0, 0, 0);     // Fully disable signal to cut motor power
    }
}

bool isJustPressed(int pin, int idx) {
    bool current = digitalRead(pin);
    bool pressed = (current == LOW && lastBtnState[idx] == HIGH);
    lastBtnState[idx] = current;
    return pressed;
}

void setup() {
    Serial.begin(115200);

    pinMode(btn_up, INPUT_PULLUP);
    pinMode(btn_down, INPUT_PULLUP);
    pinMode(btn_left, INPUT_PULLUP);
    pinMode(btn_right, INPUT_PULLUP);
    pinMode(btn_ok, INPUT_PULLUP);

    pinMode(red_led, OUTPUT);
    pinMode(green_led, OUTPUT);
    digitalWrite(red_led, LOW);
    digitalWrite(green_led, HIGH);

    Wire.begin(I2C_SDA, I2C_SCL);
    Wire.setClock(400000);

    pwm.begin();
    pwm.setPWMFreq(PCA9685_FREQ);

    u8g2.begin();
    u8g2.setFont(u8g2_font_6x10_tf);

    // Initial signal output (1500us / 90 degrees)
    updateServoSignal();
}

void loop() {
    // ---------------- BUTTON CONTROLS ----------------
    if (isJustPressed(btn_up, 0)) {
        neutralUs += 5; // Course trim up
        updateServoSignal();
    }
    if (isJustPressed(btn_down, 1)) {
        neutralUs -= 5; // Course trim down
        updateServoSignal();
    }
    if (isJustPressed(btn_left, 2)) {
        neutralUs -= 1; // Fine trim down (1us step)
        updateServoSignal();
    }
    if (isJustPressed(btn_right, 3)) {
        neutralUs += 1; // Fine trim up (1us step)
        updateServoSignal();
    }
    if (isJustPressed(btn_ok, 4)) {
        neutralUs = 1500; // Reset pulse to standard 1500us
        outputEnabled = true;
        updateServoSignal();
    }

    // ---------------- UI DISPLAY ----------------
    u8g2.firstPage();
    do {
        uint16_t ticks = usToTicks(neutralUs);

        u8g2.drawStr(0, 10, "== 360 SERVO ZERO TRIM ==");
        
        // Neutral Pulse Us
        u8g2.setCursor(0, 26);
        u8g2.print("Signal Pulse: ");
        u8g2.print(neutralUs);
        u8g2.print(" us");

        // PCA9685 Ticks
        u8g2.setCursor(0, 38);
        u8g2.print("PCA9685 Ticks: ");
        u8g2.print(ticks);

        // Estimated Speed / Motion Status
        u8g2.setCursor(0, 50);
        if (neutralUs == 1500) {
            u8g2.print("State: Standard Neutral");
        } else if (neutralUs > 1500) {
            u8g2.print("State: CW Rotation");
        } else {
            u8g2.print("State: CCW Rotation");
        }

        // Control Hints
        u8g2.setCursor(0, 62);
        u8g2.print("[U/D]+-5us [L/R]+-1us");

    } while (u8g2.nextPage());

    delay(20);
}