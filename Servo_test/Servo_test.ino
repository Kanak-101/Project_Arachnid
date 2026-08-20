#include <Servo.h>
#include <Wire.h>
#include <U8g2lib.h>

// ---------------- HARDWARE PINS ----------------
#define NUM_SERVOS 3
const int servoPins[NUM_SERVOS] = {9, 10, 11}; // Define your actual PWM pins

#define srv_min 620
#define srv_max 2380
unsigned long lastUIDraw = 0;
const int UI_INTERVAL = 50;

// Initialize u8g2 display for standard 128x64 I2C OLED
U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);

// Buttons
#define btn_up 4
#define btn_down 7
#define btn_left 2
#define btn_right 8
#define btn_ok 12

// LEDs
#define red_led 5   
#define green_led 6

// ---------------- DATA STRUCTURES ----------------
struct MyServo {
    Servo theservo;
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

void setup() {
    Serial.begin(9600);

    pinMode(btn_up, INPUT_PULLUP);
    pinMode(btn_down, INPUT_PULLUP);
    pinMode(btn_left, INPUT_PULLUP);
    pinMode(btn_right, INPUT_PULLUP);
    pinMode(btn_ok, INPUT_PULLUP);

    pinMode(red_led, OUTPUT);
    pinMode(green_led, OUTPUT);
    digitalWrite(red_led, LOW);
    digitalWrite(green_led, LOW);

    // Initialize Servos
    for(int i = 0; i < NUM_SERVOS; i++){
        servos[i].theservo.attach(servoPins[i], srv_min, srv_max);
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

    // Initialize Display
    if(!u8g2.begin()) {
        digitalWrite(red_led, HIGH);
        while(1); // Halt if display fails
    }
    
    digitalWrite(green_led, HIGH);
    u8g2.clearBuffer();
    u8g2.setFont(u8g2_font_6x10_tf); // Clean, readable 10px high font
    u8g2.setCursor(10, 20);
    u8g2.print("Setup Successful");
    u8g2.setCursor(10, 40);
    u8g2.print("Starting ...");
    u8g2.sendBuffer(); 
    delay(2000);
}

void loop() {
    handleButtons();
    updateServos();
    
    if (millis() - lastUIDraw >= UI_INTERVAL) {
        drawUI();
        lastUIDraw = millis();
    }
}

// ---------------- SERVO LOGIC ----------------

void moveToAngle(int index, int angle) {
    angle = constrain(angle, 0, 180);
    servos[index].theservo.writeMicroseconds(map(angle, 0, 180, srv_min, srv_max));
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
                for(int i=0; i<NUM_SERVOS; i++) servos[i].enabled = false;
            } else if (currentRow == 1) { // START ALL
                for(int i=0; i<NUM_SERVOS; i++) servos[i].enabled = true;
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
    if(editMode == 1 && isSelected) u8g2.print("["); 
    u8g2.print(minV);
    
    u8g2.setCursor(104, textY);
    if(editMode == 2 && isSelected) u8g2.print("[");
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
    if(editMode == 3 && isSelected) u8g2.print("[");
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
        u8g2.drawLine(x, y+4, x+2, y+7);
        u8g2.drawLine(x+2, y+7, x+6, y+1);
    } else {      // Draw an X
        u8g2.drawLine(x, y+2, x+6, y+8);
        u8g2.drawLine(x+6, y+2, x, y+8);
    }
}