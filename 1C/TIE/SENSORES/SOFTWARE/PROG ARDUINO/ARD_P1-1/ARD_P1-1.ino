
#define F_CPU 16000000L

#include <Arduino.h>
#include <HardwareSerial.h>

extern HardwareSerial Serial;

void establishContact();

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
}

void loop() {
  while (Serial.available() <= 0) {
    Serial.println("PRACTICA 1.1 TIE"); 
    Serial.println("CURSO 2021-22"); 
    Serial.println("Gerardo Arias y Andrés Ruz");
    Serial.println(); 
    delay(300);
  }
}
