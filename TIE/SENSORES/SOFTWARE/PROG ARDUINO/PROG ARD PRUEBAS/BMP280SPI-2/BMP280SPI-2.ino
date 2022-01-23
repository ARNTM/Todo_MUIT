
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
    // default settings
    // (you can also pass in a Wire library object like &Wire2)
    status = sensor1.begin();  
    if (!status) {
        Serial.println("Could not find a valid BME280 sensor, check wiring!");
        while (1);
    }
    Serial.println("Measurement of sea level pressure. Wait 10seg");
    for(int i=0; i<1000; i++){
      AvgPressure = AvgPressure + sensor1.readPressure()/100.0;
      delay (10);
      }
    SEALEVELPRESSURE_HPA = AvgPressure/1000;
    Serial.print("Presión a altura de referencia cero = ");
    Serial.print(SEALEVELPRESSURE_HPA);
    Serial.println(" mbar");
    }

void loop() { 
  
    float AvgPressure = 0;
    float AvgAltitude = 0;
    
    Serial.print(F("Temperature = "));
    Serial.print(sensor1.readTemperature());
    Serial.println(" ºC");

    for(int i=0; i<1000; i++){
      AvgPressure = AvgPressure + sensor1.readPressure()/100.0;
      AvgAltitude=AvgAltitude + sensor1.readAltitude(SEALEVELPRESSURE_HPA);
      //delay (10);
      }

    
    Serial.print(F("Pressure = "));
    Serial.print(AvgPressure / 1000.0);
    Serial.println(" mbar");
        
    Serial.print("Approx. Altitude = ");
    Serial.print(AvgAltitude/10,1);
    Serial.println(" cm");
    delay(50);
    }
