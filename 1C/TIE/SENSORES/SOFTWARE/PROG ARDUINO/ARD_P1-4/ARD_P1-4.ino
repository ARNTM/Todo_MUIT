
#define F_CPU 16000000L
#define ARDUINO 101

#include <Arduino.h>
#include <HardwareSerial.h>

extern HardwareSerial Serial;
void establishContact();
int led = 30;

void setup() {      // start serial port at 9600 bps:
  Serial.begin(9600);

  pinMode(22, OUTPUT);     // Declarar los pines de los leds como salidas
  pinMode(23, OUTPUT);
  pinMode(24, OUTPUT);
  pinMode(25, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(27, OUTPUT);
  pinMode(28, OUTPUT);
  pinMode(29, OUTPUT);
}

void loop() {

  digitalWrite(led, LOW);   // Apaga el led anterior

  if ( led > 22 ) led--;    // Actualiza el valor del led que debe encenderse
  else led = 29;

  digitalWrite(led, HIGH);    // Enciende el led actual

  Serial.println(30 - led);   // Envia el numero del led encendido

  delay(1000);            // Retardo de 1 segundo
}
