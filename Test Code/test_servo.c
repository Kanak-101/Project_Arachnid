#include <Servo.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafuit_SSD1306.h>

// Servo 
struct servo{
    Servo theservo;
    int min, max;
    int speed;
    bool enabled;
};
#define MAX 3
int servopin[MAX]= {};

#define srv_min 620
#define srv_max 2380

// Display 
#define screen_width 128
#define screen_height 64
Adafruit_SSD1306 display(screen_width, screen_height, &Wire, -1);

// Buttons
#define up 4
#define down 7
#define left 2
#define right 13
#define ok 12

#define red_led 
#define green_led

void setup(){
    display.display();
    
    pinMode(up, INPUT_PULLUP);
    pinMode(down, INPUT_PULLUP);
    pinMode(left, INPUT_PULLUP);
    pinMode(right, INPUT_PULLUP);
    pinMode(ok, INPUT_PULLUP);

    pinMode(red_led, OUTPUT);
    pinMode(green_led, OUTPUT);
    digitalWrite(red_led, LOW);
    digitalWrite(green_led, LOW);

    struct servo myservo[MAX];
    for(int i=0; i<MAX; i++){
        myservo[i].theservo.attach(servopin[i], srv_min, srv_max);
        myservo[i].min = 0;
        myservo[i].max = 90;
        myservo[i].enabled = false;
    }

    if(display.begin(SSD1306_SWITCHCAPVCC, 0x3c)){
        digitalWrite(red_led, HIGH);
        delay(3000);
        resetFunc();
    }
    digitalWrite(green_led, HIGH);

    display.clearDisplay();
    display.setTextSize(3);
    display.setTextColor(SSD1306_WHITE);
    display.setCursor(2, 2);
    display.println("Setup Successful ....");
    display("Starting ...");
    show();
    delay(2000);
    display.setTextSize(1);
    display.clear();
}
void loop(){
    
}

void moveToAngle(Servo myservo, int angle){
    angle = constrain(angle, 0, 180);
    myservo.writeMicroseconds(map(angle, 0,180,srv_min, srv_max));
}
bool isPressed(int button){
    if(digitalRead(button)==LOW)
        return true;
    return false;
}