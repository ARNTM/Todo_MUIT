
#define F_CPU 16000000L

#include <Arduino.h>
#include <HardwareSerial.h>
extern HardwareSerial Serial;
void establishContact();
const int led = 25;
void setup() {
  pinMode(led, OUTPUT);
}
void loop() {
  digitalWrite(led, HIGH); // turn the LED on (HIGH is the voltage level)
  delay(1000); // wait for a second
  digitalWrite(led, LOW); // turn the LED off by making the voltage LOW
  delay(1000); // wait for a second
}
