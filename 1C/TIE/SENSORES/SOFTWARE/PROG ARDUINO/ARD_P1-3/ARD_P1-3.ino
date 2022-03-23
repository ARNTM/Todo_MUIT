
#define F_CPU 16000000L
#define ARDUINO 101

#include <Arduino.h>
#include <HardwareSerial.h>
extern HardwareSerial Serial;

void establishContact();

int led = 30;

void setup() {        // Declarar los pines de los leds como salidas

  pinMode(22, OUTPUT);
  pinMode(23, OUTPUT);
  pinMode(24, OUTPUT);
  pinMode(25, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(27, OUTPUT);
  pinMode(28, OUTPUT);
  pinMode(29, OUTPUT);
}

void loop() {

  digitalWrite(led, LOW);

  if ( led > 22 ) led--;
  else led = 29;

  digitalWrite(led, HIGH);
  delay(300);
}
