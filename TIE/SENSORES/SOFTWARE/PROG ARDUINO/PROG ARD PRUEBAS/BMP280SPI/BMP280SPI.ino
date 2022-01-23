
#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>


#define BMP_SCK 52
#define BMP_MISO 50
#define BMP_MOSI 51
#define BMP_CS 53

//#define SEALEVELPRESSURE_HPA (1013.25)
float SEALEVELPRESSURE_HPA;
float AvgPressure = 0;

Adafruit_BMP280 sensor1(BMP_CS); // hardware SPI
//Adafruit_BME280 bme(BME_CS, BME_MOSI, BME_MISO, BME_SCK); // software SPI

void setup() {

    Serial.begin(9600);
    Serial.println(F("BMP280 SPI test"));
    
    bool status;    
    status = sensor1.begin();  
    if (!status) {
        Serial.println("Could not find a valid BME280 sensor, check wiring!");
        while (1);
    }
    for(int i=0; i<100; i++){
      AvgPressure = AvgPressure + sensor1.readPressure()/100.0;
      Serial.print(".");
      delay (100);
      }
    SEALEVELPRESSURE_HPA = AvgPressure/100;
    Serial.println(".");
}

void loop() { 
    
    Serial.print(F("Temperature = "));
    Serial.print(sensor1.readTemperature());
    Serial.println(" ºC");
    
    Serial.print(F("Pressure = "));
    Serial.print(sensor1.readPressure() / 100.0);
    Serial.println(" mbar");
        
    Serial.print("Approx. Altitude = ");
    Serial.print(sensor1.readAltitude(SEALEVELPRESSURE_HPA)*100);
    Serial.println(" cm");
    delay(5000);
    }
