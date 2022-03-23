#define F_CPU 16000000L
#include <Arduino.h>
#include <HardwareSerial.h>
#include <LiquidCrystal.h>

extern HardwareSerial Serial;
extern HardwareSerial Serial1;

void ReadSerial1PrintSerial();
void ReadSerialPrintSerial1();

void setup() {

  Serial.begin(9600);
  Serial1.begin(9600);
  delay(5000);

  Serial1.print("+++");
  delay(2000);
  Serial.println("+++");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATID");  // Comando ATID
  delay(1000);
  Serial.println("ATID");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATSH");  // Comando ATSH
  delay(1000);
  Serial.println("ATSH");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATSL");  // Comando ATSL
  delay(1000);
  Serial.println("ATSL");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATID15"); // Comando ATID9
  delay(1000);
  Serial.println("ATID15");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATID");  // Comando ATID
  delay(1000);
  Serial.println("ATID");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATDH0013A200");  // Comando ATDH
  delay(1000);
  Serial.println("ATDH0013A200");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATDL409ACC0D");  // Comando ATDL
  delay(1000);
  Serial.println("ATDL409ACC0D");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATDH");      // Comando ATDH
  delay(1000);
  Serial.println("ATDH");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATDL");    // Comando ATDL
  delay(1000);
  Serial.println("ATDL");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();

  Serial.println();
  Serial1.println("ATCN");  // Comando ATCN
  delay(1000);
  Serial.println("ATCN");
  Serial.print("Zigbee responde: ");
  ReadSerial1PrintSerial();
}

void loop() {
  ReadSerial1PrintSerial();
  ReadSerialPrintSerial1();
}

void ReadSerial1PrintSerial() {
  while (Serial1.available() > 0 ) {
    char readByte = Serial1.read();
    Serial.print(readByte);
    delay(50);
  }
}
void ReadSerialPrintSerial1() {
  while (Serial.available() > 0 ) {
    char readByte = Serial.read();
    Serial1.println(readByte);
    delay(50);
  }
}
