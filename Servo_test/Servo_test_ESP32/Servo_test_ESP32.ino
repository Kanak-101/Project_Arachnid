/*
 * ============================================================================
 *  3-Servo UI Controller  ---  ESP32 + PCA9685 + SSD1306 (U8g2) + Buttons/LEDs
 * ============================================================================
 *  Ported from an Arduino Uno + Servo.h version to:
 *    - ESP32 (Arduino core)
 *    - Adafruit_PWMServoDriver (PCA9685, external 16-ch I2C PWM driver)
 *    - Shared I2C bus (SDA=21 / SCL=22) for BOTH the SSD1306 OLED and PCA9685
 *
 *  See the accompanying summary for a list of all changes.
 * ============================================================================
 */

#include <Wire.h>
#include <U8g2lib.h>
#include <Adafruit_PWMServoDriver.h>

// ---------------- I2C BUS (ESP32 default) ----------------
#define I2C_SDA 21
#define I2C_SCL 22

// ---------------- PCA9685 CONFIG ----------------
#define PCA9685_ADDR   0x40   // Default PCA9685 I2C address
#define PCA9685_FREQ   50     // 50 Hz -- standard analog servo update rate

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(PCA9685_ADDR);

// ---------------- HARDWARE PINS ----------------
#define NUM_SERVOS 3
// PCA9685 output channels (0-15) that the 3 servos are plugged into
const int servoChannels[NUM_SERVOS] = {0, 1, 2};

// Pulse-width range for the physical servos (in microseconds)
#define srv_min 620
#define srv_max 2380

unsigned long lastUIDraw = 0;
const int UI_INTERVAL = 50;

// Initialize u8g2 display for standard 128x64 I2C OLED.
// On ESP32 the HW I2C constructor uses the default Wire bus (SDA21/SCL22
// after Wire.begin(I2C_SDA, I2C_SCL) is called in setup()).
U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);

// ---------------- BUTTONS (ESP32-safe GPIOs) ----------------
// Avoided: strapping pins (0, 2, 5, 12, 15), input-only pins (34-39,
// which can't drive LEDs), and the flash-SPI pins (6-11).
#define btn_up     32
#define btn_down   15
#define btn_left   4
#define btn_right  25
#define btn_ok     33

// ---------------- LEDs (ESP32-safe GPIOs) ----------------
#define red_led    17
#define green_led  16

// ---------------- DATA STRUCTURES ----------------
struct MyServo {
    int channel;        // PCA9685 output channel (replaces Servo object)
    int minAngle;
    int maxAngle;
    int currentAngle;
    int speed;      // 1 (slow) to 50 (fast)
    int direction;  // 1 for increasing, -1 for decreasing
    unsigned long lastUpdate;
    bool enabled;
    char name[10];
};

MyServo servos[NUM_SERVOS];

// ---------------- UI VARIABLES ----------------
int TOTAL_ROWS = 2 + (NUM_SERVOS * 3); // StopAll, StartAll, + 3 rows per servo (Header, Angles, Speed)
int currentRow = 0;
int scrollY = 0;

// Edit mode: 0=Navigating, 1=Editing Min, 2=Editing Max, 3=Editing Speed
int editMode = 0;

// Button Debounce & Double-Click logic
unsigned long lastOkPress = 0;
bool waitSingleClick = false;
bool lastBtnState[5] = {HIGH, HIGH, HIGH, HIGH, HIGH};

// ============================================================================
//  SETUP
// ============================================================================
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
    digitalWrite(green_led, LOW);

    // ---- Bring up the shared I2C bus BEFORE touching either I2C device ----
    Wire.begin(I2C_SDA, I2C_SCL);
    Wire.setClock(400000); // 400kHz Fast Mode: safe for both SSD1306 & PCA9685

    // ---- Initialize PCA9685 PWM driver ----
    pwm.begin();
    pwm.setPWMFreq(PCA9685_FREQ); // 50 Hz for analog servos

    // Initialize Servos (struct no longer owns a Servo object -- the
    // PCA9685 channel is driven directly via pwm.setPWM())
    for (int i = 0; i < NUM_SERVOS; i++) {
        servos[i].channel = servoChannels[i];
        servos[i].minAngle = 0;
        servos[i].maxAngle = 135;
        servos[i].currentAngle = 90;
        servos[i].speed = 25; // Default medium speed
        servos[i].direction = 1;
        servos[i].enabled = false;
        servos[i].lastUpdate = 0;
        sprintf(servos[i].name, "Servo %d", i + 1);
        moveToAngle(i, servos[i].currentAngle);
    }

    // ---- Initialize Display (shares the same Wire bus) ----
    if (!u8g2.begin()) {
        digitalWrite(red_led, HIGH);
        while (1) delay(100); // Halt if display fails
    }

    analogWrite(green_led, 127);
    u8g2.clearBuffer();
    u8g2.setFont(u8g2_font_6x10_tf); // Clean, readable 10px high font
    u8g2.setCursor(10, 20);
    u8g2.print("Setup Successful");
    u8g2.setCursor(10, 40);
    u8g2.print("Starting ...");
    u8g2.sendBuffer();
    delay(2000);
}

// ============================================================================
//  MAIN LOOP
// ============================================================================
void loop() {
    handleButtons();
    updateServos();

    if (millis() - lastUIDraw >= UI_INTERVAL) {
        drawUI();
        lastUIDraw = millis();
    }
}

// ---------------- SERVO LOGIC ----------------

// Converts a servo pulse width in microseconds into a PCA9685 12-bit tick
// count (0-4095) for the currently configured PWM frequency.
// tick = pulse_us / (period_us / 4096)
uint16_t usToTicks(int us) {
    float periodUs = 1000000.0f / PCA9685_FREQ;      // e.g. 20000us @ 50Hz
    float ticks = (float)us / (periodUs / 4096.0f);
    if (ticks < 0) ticks = 0;
    if (ticks > 4095) ticks = 4095;
    return (uint16_t)(ticks + 0.5f);
}

void moveToAngle(int index, int angle) {
    angle = constrain(angle, 0, 180);
    int us = map(angle, 0, 180, srv_min, srv_max);
    uint16_t ticks = usToTicks(us); // ~ typically lands in the 102-512 tick
                                     // range for a 50Hz/620-2380us servo
    pwm.setPWM(servos[index].channel, 0, ticks);
}

void updateServos() {
    unsigned long currentMillis = millis();
    for (int i = 0; i < NUM_SERVOS; i++) {
        if (servos[i].enabled) {
            unsigned long stepDelay = map(servos[i].speed, 1, 50, 50, 2);

            if (currentMillis - servos[i].lastUpdate >= stepDelay) {
                servos[i].lastUpdate = currentMillis;
                servos[i].currentAngle += servos[i].direction;

                // Bounce at dynamic boundaries
                if (servos[i].currentAngle >= servos[i].maxAngle) {
                    servos[i].currentAngle = servos[i].maxAngle;
                    servos[i].direction = -1;
                } else if (servos[i].currentAngle <= servos[i].minAngle) {
                    servos[i].currentAngle = servos[i].minAngle;
                    servos[i].direction = 1;
                }
                moveToAngle(i, servos[i].currentAngle);
            }
        }
    }
}

// ---------------- INPUT LOGIC ----------------

bool isJustPressed(int pin, int idx) {
    bool current = digitalRead(pin);
    bool pressed = (current == LOW && lastBtnState[idx] == HIGH);
    lastBtnState[idx] = current;
    return pressed;
}

void handleButtons() {
    bool up = isJustPressed(btn_up, 0);
    bool down = isJustPressed(btn_down, 1);
    bool left = isJustPressed(btn_left, 2);
    bool right = isJustPressed(btn_right, 3);
    bool ok = isJustPressed(btn_ok, 4);

    bool singleClick = false;
    bool doubleClick = false;

    // OK Button Double Click Logic
    if (ok) {
        if (waitSingleClick && (millis() - lastOkPress < 400)) {
            doubleClick = true;
            waitSingleClick = false;
        } else {
            waitSingleClick = true;
            lastOkPress = millis();
        }
    }

    if (waitSingleClick && (millis() - lastOkPress > 400)) {
        singleClick = true;
        waitSingleClick = false;
    }

    // Apply Double Click -> Toggle Servo Enable
    if (doubleClick) {
        if (currentRow >= 2) {
            int sIdx = (currentRow - 2) / 3;
            servos[sIdx].enabled = !servos[sIdx].enabled;
        }
    }

    // Navigation & Editing Logic
    if (editMode == 0) { // Scrolling
        if (up && currentRow > 0) currentRow--;
        if (down && currentRow < TOTAL_ROWS - 1) currentRow++;

        // Keep selection within the 4-row visible window
        if (currentRow < scrollY) scrollY = currentRow;
        if (currentRow >= scrollY + 4) scrollY = currentRow - 3;

        if (singleClick) {
            if (currentRow == 0) { // EMERGENCY STOP ALL
                for (int i = 0; i < NUM_SERVOS; i++) servos[i].enabled = false;
            } else if (currentRow == 1) { // START ALL
                for (int i = 0; i < NUM_SERVOS; i++) servos[i].enabled = true;
            } else {
                int sType = (currentRow - 2) % 3;
                if (sType == 1) editMode = 1; // Enter Min Angle Edit
                if (sType == 2) editMode = 3; // Enter Speed Edit
            }
        }
    } else { // Editing Slider Values
        int sIdx = (currentRow - 2) / 3;

        if (editMode == 1) { // Editing MIN
            if (left) servos[sIdx].minAngle -= 2;
            if (right) servos[sIdx].minAngle += 2;
            servos[sIdx].minAngle = constrain(servos[sIdx].minAngle, 0, servos[sIdx].maxAngle - 1);
            if (singleClick) editMode = 2; // Move to MAX edit
        }
        else if (editMode == 2) { // Editing MAX
            if (left) servos[sIdx].maxAngle -= 2;
            if (right) servos[sIdx].maxAngle += 2;
            servos[sIdx].maxAngle = constrain(servos[sIdx].maxAngle, servos[sIdx].minAngle + 1, 180);
            if (singleClick) editMode = 0; // Exit edit mode
        }
        else if (editMode == 3) { // Editing SPEED
            if (left) servos[sIdx].speed -= 2;
            if (right) servos[sIdx].speed += 2;
            servos[sIdx].speed = constrain(servos[sIdx].speed, 1, 50);
            if (singleClick) editMode = 0; // Exit edit mode
        }
    }
}

// ---------------- UI DRAWING LOGIC (U8G2) ----------------

void drawUI() {
    u8g2.firstPage();
    do {
        int visibleRows = 4; // 16 pixels per row on 64px height screen
        int startRow = scrollY;
        int endRow = min(startRow + visibleRows, TOTAL_ROWS);

        for (int i = startRow; i < endRow; i++) {
            int yPos = (i - startRow) * 16;
            bool isSelected = (i == currentRow);

            // Highlight background if selected
            if (isSelected) {
                u8g2.setDrawColor(1);
                u8g2.drawBox(0, yPos, 128, 16);
                u8g2.setDrawColor(0); // Draw text/shapes in black over white box
            } else {
                u8g2.setDrawColor(1); // Normal white drawing
            }

            // U8g2 text draws from the bottom-left baseline
            int textY = yPos + 12;

            if (i == 0) {
                u8g2.setCursor(4, textY);
                u8g2.print("! STOP ALL SERVOS !");
            } else if (i == 1) {
                u8g2.setCursor(4, textY);
                u8g2.print("> START ALL SERVOS");
            } else {
                int sIdx = (i - 2) / 3;
                int sType = (i - 2) % 3;

                if (sType == 0) { // HEADER ROW
                    u8g2.setCursor(4, textY);
                    u8g2.print(servos[sIdx].name);
                    drawIcon(114, yPos + 4, servos[sIdx].enabled);
                }
                else if (sType == 1) { // ANGLE SLIDER ROW
                    drawDualSlider(yPos, servos[sIdx].minAngle, servos[sIdx].maxAngle, isSelected, sIdx);
                }
                else if (sType == 2) { // SPEED SLIDER ROW
                    drawSingleSlider(yPos, servos[sIdx].speed, isSelected, sIdx);
                }
            }
        }
    } while (u8g2.nextPage());
}

void drawDualSlider(int yPos, int minV, int maxV, bool isSelected, int sIdx) {
    int textY = yPos + 12;

    // Draw Numbers
    u8g2.setCursor(2, textY);
    if (editMode == 1 && isSelected) u8g2.print("[");
    u8g2.print(minV);

    u8g2.setCursor(104, textY);
    if (editMode == 2 && isSelected) u8g2.print("[");
    u8g2.print(maxV);

    // Draw Track Line
    u8g2.drawLine(28, yPos + 8, 98, yPos + 8);

    // Draw Handles (Boxes)
    int x1 = map(minV, 0, 180, 28, 98);
    int x2 = map(maxV, 0, 180, 28, 98);
    u8g2.drawBox(x1 - 2, yPos + 4, 4, 9);
    u8g2.drawBox(x2 - 2, yPos + 4, 4, 9);

    // Connect active range
    u8g2.drawLine(x1, yPos + 7, x2, yPos + 7);
    u8g2.drawLine(x1, yPos + 9, x2, yPos + 9);
}

void drawSingleSlider(int yPos, int val, bool isSelected, int sIdx) {
    int textY = yPos + 12;

    u8g2.setCursor(2, textY);
    u8g2.print("Spd:");
    if (editMode == 3 && isSelected) u8g2.print("[");
    u8g2.print(val);

    // Track Line
    u8g2.drawLine(48, yPos + 8, 118, yPos + 8);

    // Handle (Box)
    int x = map(val, 1, 50, 48, 118);
    u8g2.drawBox(x - 2, yPos + 4, 4, 9);
}

// U8g2 color state is already handled before calling this, so it automatically inverts
void drawIcon(int x, int y, bool isTick) {
    if (isTick) { // Draw a Checkmark
        u8g2.drawLine(x, y + 4, x + 2, y + 7);
        u8g2.drawLine(x + 2, y + 7, x + 6, y + 1);
    } else {      // Draw an X
        u8g2.drawLine(x, y + 2, x + 6, y + 8);
        u8g2.drawLine(x + 6, y + 2, x, y + 8);
    }
}
