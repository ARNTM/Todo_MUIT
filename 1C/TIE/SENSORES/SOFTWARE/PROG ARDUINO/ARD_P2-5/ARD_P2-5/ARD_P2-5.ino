#define F_CPU 16000000L
#include <Arduino.h>
#include <HardwareSerial.h>
#include <LiquidCrystal.h>

extern HardwareSerial Serial;
extern HardwareSerial Serial1;

void ReadSerial1PrintSerial();

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
  delay(500);

  Serial.println();
  Serial.println("Trama LED D2 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD2OFF[i],0);
  Serial.print(tramaD2OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(2000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D3 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD3OFF[i],0);
  Serial.print(tramaD3OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(2000);
  ReadSerial1PrintSerial();
  
  Serial.println();
  Serial.println("Trama LED D4 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD4OFF[i],0);
  Serial.print(tramaD4OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama ADC A0 LM35   ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaA0[i],0);
  Serial.print(tramaA0[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
  ReadSerial1PrintSerial();
  
  Serial.println();
  Serial.println("Trama ADC A1 LDR    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaA1[i],0);
  Serial.print(tramaA1[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
  ReadSerial1PrintSerial();
}

void loop(){ 
  
  Serial.println();
  Serial.println("Trama LED D2 ON    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD2ON[i],0);
  Serial.print(tramaD2ON[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("  ");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D3 ON    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD3ON[i],0);
  Serial.print(tramaD3ON[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("  ");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D4 ON    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD4ON[i],0);
  Serial.print(tramaD4ON[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("  ");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D2 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD2OFF[i],0);
  Serial.print(tramaD2OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D3 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD3OFF[i],0);
  Serial.print(tramaD3OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
  ReadSerial1PrintSerial();

  Serial.println();
  Serial.println("Trama LED D4 OFF    ");
  for (int i=0;i<20;i++){
  Serial1.print(tramaD4OFF[i],0);
  Serial.print(tramaD4OFF[i],HEX);
  Serial.print("  ");
  delay(5);
  }
  Serial.println("");
  delay(3000);
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
