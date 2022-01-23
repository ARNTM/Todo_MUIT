
#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>


#define BMP_SCK 52
#define BMP_MISO 50
#define BMP_MOSI 51
#define BMP_CS 53

float AvgPressure = 0;

Adafruit_BMP280 sensor1(BMP_CS, BMP_MOSI, BMP_MISO, BMP_SCK); // software SPI

void setup() {
    Serial.begin(9600);
    Serial.println(F("BMP280 SPI test"));
    bool status;    
    status = sensor1.begin();  
    if (!status) {
        Serial.println("Could not find a valid BME280 sensor, check wiring!");
        while (1);
    }
  }

void loop() { 
    float AvgPressure = 0;
    for(int i=0; i<1000; i++){
      AvgPressure = AvgPressure + sensor1.readPressure()/100000.0;
      }
    
    Serial.print(F("Pressure = "));
    Serial.print(AvgPressure / 1000.0);
    Serial.println(" mbar");
    }
