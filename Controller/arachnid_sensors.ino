/*
 * arachnid_sensors.ino  –  Project Arachnid
 * Arduino Uno — Gas sensors + Ultrasonic collision detection
 *
 * Wiring:
 *   MQ-2  → A0    MQ-4  → A1    MQ-5  → A2
 *   MQ-6  → A3    MQ-7  → A4    MQ-8  → A5
 *
 *   HC-SR04 FRONT:  TRIG=2  ECHO=3
 *   HC-SR04 LEFT:   TRIG=4  ECHO=5
 *   HC-SR04 RIGHT:  TRIG=6  ECHO=7
 *
 *   Arduino → RPi:  USB cable (shows as /dev/ttyUSB0 on RPi)
 *
 * Output: JSON line every 100 ms
 * {"MQ2":320,"MQ4":0,"MQ5":0,"MQ6":0,"MQ7":0,"MQ8":0,
 *  "front":180,"left":999,"right":999}
 */

// ── Pin definitions ──────────────────────────────────────────────────────────
const int PIN_MQ2 = A0, PIN_MQ4 = A1, PIN_MQ5 = A2;
const int PIN_MQ6 = A3, PIN_MQ7 = A4, PIN_MQ8 = A5;

struct Sonar { int trig; int echo; };
Sonar sonars[3] = {{2,3},{4,5},{6,7}};   // front, left, right
const char* sonar_names[3] = {"front","left","right"};

// ── Ultrasonic measurement ───────────────────────────────────────────────────
long readSonar(int trig, int echo) {
  digitalWrite(trig, LOW);  delayMicroseconds(2);
  digitalWrite(trig, HIGH); delayMicroseconds(10);
  digitalWrite(trig, LOW);
  long dur = pulseIn(echo, HIGH, 30000);  // 30 ms timeout → ~500 cm
  return (dur == 0) ? 999 : dur / 58;     // cm
}

void setup() {
  Serial.begin(115200);
  for (int i = 0; i < 3; i++) {
    pinMode(sonars[i].trig, OUTPUT);
    pinMode(sonars[i].echo, INPUT);
  }
  delay(2000);  // Let MQ sensors warm up (ideally 60s for accuracy)
}

void loop() {
  // ── Read gas sensors ───────────────────────────────────────────────────────
  int mq[6] = {
    analogRead(PIN_MQ2), analogRead(PIN_MQ4), analogRead(PIN_MQ5),
    analogRead(PIN_MQ6), analogRead(PIN_MQ7), analogRead(PIN_MQ8)
  };
  const char* mq_names[6] = {"MQ2","MQ4","MQ5","MQ6","MQ7","MQ8"};

  // ── Read ultrasonic sensors ────────────────────────────────────────────────
  long dist[3];
  for (int i = 0; i < 3; i++) {
    dist[i] = readSonar(sonars[i].trig, sonars[i].echo);
  }

  // ── Emit JSON ──────────────────────────────────────────────────────────────
  Serial.print("{");
  for (int i = 0; i < 6; i++) {
    Serial.print("\""); Serial.print(mq_names[i]); Serial.print("\":");
    Serial.print(mq[i]);
    Serial.print(",");
  }
  for (int i = 0; i < 3; i++) {
    Serial.print("\""); Serial.print(sonar_names[i]); Serial.print("\":");
    Serial.print(dist[i]);
    if (i < 2) Serial.print(",");
  }
  Serial.println("}");

  delay(100);   // 10 Hz
}
