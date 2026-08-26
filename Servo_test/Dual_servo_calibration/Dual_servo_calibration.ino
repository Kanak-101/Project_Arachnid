/*
 * ============================================================================
 *  Dual-Mode Servo Controller & 360-Degree Calibration Tool
 * ============================================================================
 *  ESP32 + PCA9685 + SSD1306 (U8g2) + 5 Buttons / 2 LEDs
 * 
 *  TOGGLE MODES: Press UP + DOWN + OK together to switch between:
 *    - Mode 0: Main 3-Servo UI Controller
 *    - Mode 1: MG996R 360° Zero-Trim Calibration Tool
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
#define PCA9685_FREQ   50     // 50 Hz standard servo frequency

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(PCA9685_ADDR);

// ---------------- HARDWARE PINS ----------------
#define NUM_SERVOS 3
const int servoChannels[NUM_SERVOS] = {0, 1, 2};

#define srv_min 620
#define srv_max 2380

// Initialize u8g2 display
U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);

// ---------------- BUTTONS ----------------
#define btn_up     32
#define btn_down   15
#define btn_left   4
#define btn_right  25
#define btn_ok     33

// ---------------- LEDs ----------------
#define red_led    17
#define green_led  16

// ---------------- SYSTEM MODE STATE ----------------
// 0 = Main 3-Servo UI Controller, 1 = 360-Degree Zero Calibration
int activeSystemMode = 0; 
unsigned long lastModeSwitch = 0;

// ---------------- MAIN UI DATA STRUCTURES ----------------
struct MyServo {
    int channel;
    int minAngle;
    int maxAngle;
    int currentAngle;
    int speed;      
    int direction;  
    unsigned long lastUpdate;
    bool enabled;
    char name[10];
};

MyServo servos[NUM_SERVOS];

// Main UI Variables
int TOTAL_ROWS = 2 + (NUM_SERVOS * 3);
int currentRow = 0;
int scrollY = 0;
int editMode = 0; // 0=Navigating, 1=Editing Min, 2=Editing Max, 3=Editing Speed

// Button State Tracking
unsigned long lastOkPress = 0;
bool waitSingleClick = false;
bool lastBtnState[5] = {HIGH, HIGH, HIGH, HIGH, HIGH};

unsigned long lastUIDraw = 0;
const int UI_INTERVAL = 50;

// ---------------- CALIBRATION MODE VARIABLES ----------------
int calibNeutralUs = 1500; // Microsecond pulse for calibration mode

// ---------------- HELPER FUNCTIONS ----------------

uint16_t usToTicks(int us) {
    float periodUs = 1000000.0f / PCA9685_FREQ; // 20000us @ 50Hz
    float ticks = (float)us / (periodUs / 4096.0f);
    if (ticks < 0) ticks = 0;
    if (ticks > 4095) ticks = 4095;
    return (uint16_t)(ticks + 0.5f);
}

void moveToAngle(int index, int angle) {
    angle = constrain(angle, 0, 180);
    int us = map(angle, 0, 180, srv_min, srv_max);
    uint16_t ticks = usToTicks(us);
    pwm.setPWM(servos[index].channel, 0, ticks);
}

bool isJustPressed(int pin, int idx) {
    bool current = digitalRead(pin);
    bool pressed = (current == LOW && lastBtnState[idx] == HIGH);
    lastBtnState[idx] = current;
    return pressed;
}

// Check for 3-button combo press: UP + DOWN + OK
void checkModeSwitchCombo() {
    bool upRaw   = (digitalRead(btn_up) == LOW);
    bool downRaw = (digitalRead(btn_down) == LOW);
    bool okRaw   = (digitalRead(btn_ok) == LOW);

    if (upRaw && downRaw && okRaw) {
        if (millis() - lastModeSwitch > 1000) { // 1-second debounce
            activeSystemMode = (activeSystemMode == 0) ? 1 : 0;
            lastModeSwitch = millis();

            // Emergency stop servos on mode switch
            for (int i = 0; i < NUM_SERVOS; i++) {
                servos[i].enabled = false;
                pwm.setPWM(servos[i].channel, 0, 0);
            }

            // Blink LEDs to indicate mode switch
            digitalWrite(red_led, HIGH);
            digitalWrite(green_led, LOW);
            delay(200);
            digitalWrite(red_led, LOW);
            digitalWrite(green_led, HIGH);
        }
    }
}

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

    Wire.begin(I2C_SDA, I2C_SCL);
    Wire.setClock(400000);

    pwm.begin();
    pwm.setPWMFreq(PCA9685_FREQ);

    for (int i = 0; i < NUM_SERVOS; i++) {
        servos[i].channel = servoChannels[i];
        servos[i].minAngle = 0;
        servos[i].maxAngle = 135;
        servos[i].currentAngle = 90;
        servos[i].speed = 25;
        servos[i].direction = 1;
        servos[i].enabled = false;
        servos[i].lastUpdate = 0;
        sprintf(servos[i].name, "Servo %d", i + 1);
        moveToAngle(i, servos[i].currentAngle);
    }

    if (!u8g2.begin()) {
        digitalWrite(red_led, HIGH);
        while (1) delay(100);
    }

    analogWrite(green_led, 127);
    u8g2.clearBuffer();
    u8g2.setFont(u8g2_font_6x10_tf);
    u8g2.setCursor(10, 20);
    u8g2.print("Dual-Mode Ready");
    u8g2.setCursor(10, 40);
    u8g2.print("Hold 3-Btns Switch");
    u8g2.sendBuffer();
    delay(1500);
}

// ============================================================================
//  MAIN LOOP
// ============================================================================
void loop() {
    checkModeSwitchCombo(); // Constant background check for UP+DOWN+OK combo

    if (activeSystemMode == 0) {
        // --- MODE 0: ORIGINAL UI CONTROLLER ---
        handleButtonsMainUI();
        updateServosMainUI();

        if (millis() - lastUIDraw >= UI_INTERVAL) {
            drawMainUI();
            lastUIDraw = millis();
        }
    } else {
        // --- MODE 1: 360-DEGREE ZERO CALIBRATION ---
        handleButtonsCalibrationMode();

        if (millis() - lastUIDraw >= UI_INTERVAL) {
            drawCalibrationUI();
            lastUIDraw = millis();
        }
    }
}

// ============================================================================
//  MODE 0 FUNCTIONS (ORIGINAL CODE)
// ============================================================================

void updateServosMainUI() {
    unsigned long currentMillis = millis();
    for (int i = 0; i < NUM_SERVOS; i++) {
        if (servos[i].enabled) {
            unsigned long stepDelay = map(servos[i].speed, 1, 50, 50, 2);

            if (currentMillis - servos[i].lastUpdate >= stepDelay) {
                servos[i].lastUpdate = currentMillis;
                servos[i].currentAngle += servos[i].direction;

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

void handleButtonsMainUI() {
    bool up = isJustPressed(btn_up, 0);
    bool down = isJustPressed(btn_down, 1);
    bool left = isJustPressed(btn_left, 2);
    bool right = isJustPressed(btn_right, 3);
    bool ok = isJustPressed(btn_ok, 4);

    bool singleClick = false;
    bool doubleClick = false;

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

    if (doubleClick) {
        if (currentRow >= 2) {
            int sIdx = (currentRow - 2) / 3;
            servos[sIdx].enabled = !servos[sIdx].enabled;
            if (!servos[sIdx].enabled) {
                pwm.setPWM(servos[sIdx].channel, 0, 0); // Disables active PWM
            }
        }
    }

    if (editMode == 0) {
        if (up && currentRow > 0) currentRow--;
        if (down && currentRow < TOTAL_ROWS - 1) currentRow++;

        if (currentRow < scrollY) scrollY = currentRow;
        if (currentRow >= scrollY + 4) scrollY = currentRow - 3;

        if (singleClick) {
            if (currentRow == 0) { // EMERGENCY STOP
                for (int i = 0; i < NUM_SERVOS; i++) {
                    servos[i].enabled = false;
                    pwm.setPWM(servos[i].channel, 0, 0);
                }
            } else if (currentRow == 1) { // START ALL
                for (int i = 0; i < NUM_SERVOS; i++) servos[i].enabled = true;
            } else {
                int sType = (currentRow - 2) % 3;
                if (sType == 1) editMode = 1;
                if (sType == 2) editMode = 3;
            }
        }
    } else {
        int sIdx = (currentRow - 2) / 3;

        if (editMode == 1) {
            if (left) servos[sIdx].minAngle -= 2;
            if (right) servos[sIdx].minAngle += 2;
            servos[sIdx].minAngle = constrain(servos[sIdx].minAngle, 0, servos[sIdx].maxAngle - 1);
            if (singleClick) editMode = 2;
        }
        else if (editMode == 2) {
            if (left) servos[sIdx].maxAngle -= 2;
            if (right) servos[sIdx].maxAngle += 2;
            servos[sIdx].maxAngle = constrain(servos[sIdx].maxAngle, servos[sIdx].minAngle + 1, 180);
            if (singleClick) editMode = 0;
        }
        else if (editMode == 3) {
            if (left) servos[sIdx].speed -= 2;
            if (right) servos[sIdx].speed += 2;
            servos[sIdx].speed = constrain(servos[sIdx].speed, 1, 50);
            if (singleClick) editMode = 0;
        }
    }
}

void drawMainUI() {
    u8g2.firstPage();
    do {
        int visibleRows = 4;
        int startRow = scrollY;
        int endRow = min(startRow + visibleRows, TOTAL_ROWS);

        for (int i = startRow; i < endRow; i++) {
            int yPos = (i - startRow) * 16;
            bool isSelected = (i == currentRow);

            if (isSelected) {
                u8g2.setDrawColor(1);
                u8g2.drawBox(0, yPos, 128, 16);
                u8g2.setDrawColor(0);
            } else {
                u8g2.setDrawColor(1);
            }

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

                if (sType == 0) {
                    u8g2.setCursor(4, textY);
                    u8g2.print(servos[sIdx].name);
                    drawIcon(114, yPos + 4, servos[sIdx].enabled);
                }
                else if (sType == 1) {
                    drawDualSlider(yPos, servos[sIdx].minAngle, servos[sIdx].maxAngle, isSelected, sIdx);
                }
                else if (sType == 2) {
                    drawSingleSlider(yPos, servos[sIdx].speed, isSelected, sIdx);
                }
            }
        }
    } while (u8g2.nextPage());
}

void drawDualSlider(int yPos, int minV, int maxV, bool isSelected, int sIdx) {
    int textY = yPos + 12;

    u8g2.setCursor(2, textY);
    if (editMode == 1 && isSelected) u8g2.print("[");
    u8g2.print(minV);

    u8g2.setCursor(104, textY);
    if (editMode == 2 && isSelected) u8g2.print("[");
    u8g2.print(maxV);

    u8g2.drawLine(28, yPos + 8, 98, yPos + 8);

    int x1 = map(minV, 0, 180, 28, 98);
    int x2 = map(maxV, 0, 180, 28, 98);
    u8g2.drawBox(x1 - 2, yPos + 4, 4, 9);
    u8g2.drawBox(x2 - 2, yPos + 4, 4, 9);

    u8g2.drawLine(x1, yPos + 7, x2, yPos + 7);
    u8g2.drawLine(x1, yPos + 9, x2, yPos + 9);
}

void drawSingleSlider(int yPos, int val, bool isSelected, int sIdx) {
    int textY = yPos + 12;

    u8g2.setCursor(2, textY);
    u8g2.print("Spd:");
    if (editMode == 3 && isSelected) u8g2.print("[");
    u8g2.print(val);

    u8g2.drawLine(48, yPos + 8, 118, yPos + 8);

    int x = map(val, 1, 50, 48, 118);
    u8g2.drawBox(x - 2, yPos + 4, 4, 9);
}

void drawIcon(int x, int y, bool isTick) {
    if (isTick) {
        u8g2.drawLine(x, y + 4, x + 2, y + 7);
        u8g2.drawLine(x + 2, y + 7, x + 6, y + 1);
    } else {
        u8g2.drawLine(x, y + 2, x + 6, y + 8);
        u8g2.drawLine(x + 6, y + 2, x, y + 8);
    }
}

// ============================================================================
//  MODE 1 FUNCTIONS (CALIBRATION MODE)
// ============================================================================

void handleButtonsCalibrationMode() {
    bool up    = isJustPressed(btn_up, 0);
    bool down  = isJustPressed(btn_down, 1);
    bool left  = isJustPressed(btn_left, 2);
    bool right = isJustPressed(btn_right, 3);
    bool ok    = isJustPressed(btn_ok, 4);

    if (up)    calibNeutralUs += 5;  // +5us step
    if (down)  calibNeutralUs -= 5;  // -5us step
    if (left)  calibNeutralUs -= 1;  // -1us step
    if (right) calibNeutralUs += 1;  // +1us step
    if (ok)    calibNeutralUs = 1500; // Reset to standard 1500us

    calibNeutralUs = constrain(calibNeutralUs, 500, 2500);

    // Apply live pulse output directly to PCA9685 Channel 0
    uint16_t ticks = usToTicks(calibNeutralUs);
    pwm.setPWM(0, 0, ticks);
}

void drawCalibrationUI() {
    u8g2.firstPage();
    do {
        uint16_t ticks = usToTicks(calibNeutralUs);

        u8g2.drawStr(0, 10, "== 360 SERVO ZERO TRIM ==");

        u8g2.setCursor(0, 26);
        u8g2.print("Signal Pulse: ");
        u8g2.print(calibNeutralUs);
        u8g2.print(" us");

        u8g2.setCursor(0, 38);
        u8g2.print("PCA9685 Ticks: ");
        u8g2.print(ticks);

        u8g2.setCursor(0, 50);
        if (calibNeutralUs == 1500) {
            u8g2.print("State: Standard 1500us");
        } else if (calibNeutralUs > 1500) {
            u8g2.print("State: CW Rotation");
        } else {
            u8g2.print("State: CCW Rotation");
        }

        u8g2.setCursor(0, 62);
        u8g2.print("[U/D]+-5us [L/R]+-1us");

    } while (u8g2.nextPage());
}