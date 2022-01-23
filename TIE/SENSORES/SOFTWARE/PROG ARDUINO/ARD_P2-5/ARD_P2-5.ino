#define F_CPU 16000000L
#include <Arduino.h>
#include <HardwareSerial.h>
#include <LiquidCrystal.h>

extern HardwareSerial Serial;
extern HardwareSerial Serial1;

void ReadSerial1PrintSerial();
// void ReadSerialPrintSerial1();

int tramaD2OFF[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x32, 0x04, 0x06};
int tramaD2ON[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x32, 0x05, 0x05};
int tramaD3OFF[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x33, 0x04, 0x05};
int tramaD3ON[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x33, 0x05, 0x04};
int tramaD4OFF[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x34, 0x04, 0x04};
int tramaD4ON[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x34, 0x05, 0x03};
int tramaA0[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x30, 0x02, 0x0A};
int tramaA1[20]={0x7E, 0x00, 0x10, 0x17, 0x01, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x9A, 0xCC, 0x0D, 0xFF, 0xFE, 0x02, 0x44, 0x31, 0x02, 0x09};

void setup() {
  Serial.begin(9600);
  Serial1.begin(9600);
  delay(5000);
 } 
/*
 * Remote AT Command Request (API 1)

7E 00 10 17 01 00 13 A2 00 40 9A CC 0D FF FE 02 44 34 04 04

Start delimiter: 7E
Length: 00 10 (16)
Frame type: 17 (Remote AT Command Request)
Frame ID: 01 (1)
64-bit dest. address: 00 13 A2 00 40 9A CC 0D
16-bit dest. address: FF FE
Command options: 02
AT Command: 44 34 (D4)
Parameter: 04
Checksum: 04
 */

void loop(){ 
  Serial.println();
  Serial.println("Trama LED OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD2OFF[i],0);
  Serial.print(tramaD2OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(5000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("TramaA0    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaA0[i],0);
  Serial.print(tramaA0[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(5000);
  ReadSerial1PrintSerial();
 
  Serial.println();
  Serial.println("Trama LED ON    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD2ON[i],0);
  Serial.print(tramaD2ON[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("  ");
  delay(5000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("TramaA0    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaA0[i],0);
  Serial.print(tramaA0[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println();
  delay(5000);
  ReadSerial1PrintSerial();
}

void ReadSerial1PrintSerial() {
  while (Serial1.available() > 0 ) {
    int readByte = Serial1.read();
    Serial.print("  ");
    if (readByte==0x7E){
      Serial.println();
     }
    Serial.print(readByte, HEX);
    
  }
  Serial.println();
}
