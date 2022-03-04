
#define F_CPU 16000000L
#define ARDUINO 101
#include <Arduino.h>
#include <HardwareSerial.h>

extern HardwareSerial Serial;
void establishContact();
int led = 29;

void setup() {            // start serial port at 9600 bps
  Serial.begin(9600);
  pinMode(22, OUTPUT);      // Declarar los pines de los leds como salidas
  pinMode(23, OUTPUT);
  pinMode(24, OUTPUT);
  pinMode(25, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(27, OUTPUT);
  pinMode(28, OUTPUT);
  pinMode(29, OUTPUT);
}

void loop() {

  if (Serial.available() > 0) {   // Leer el valor del puerto serie

    unsigned char inByte = Serial.read();

    if ( inByte >= 49 && inByte <= 56 ) {
      digitalWrite(led, LOW);     // Apagar el led antiguo
      inByte = inByte - 48;     // Convertir el valor ascii al valor numérico
      led = 30 - inByte;        // Obtener el valor del pin del led
      Serial.println( inByte );     // Enviar por consola el valor del led
      digitalWrite(led, HIGH);      // Encender el nuevo led
    }
    else {
      if (inByte == 10) {}
      else {
        Serial.println( inByte );
        Serial.println( "Número no válido (sólo del 1 al 8)" );       // Mostrar que no se ha introducido un valor válido
      }
    }
  }
  else {}
}
