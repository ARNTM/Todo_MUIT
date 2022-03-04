#include <Wire.h>                 // include Wire library, required for I2C devices
#include <Adafruit_Sensor.h>    // include Adafruit sensor library
#include <Adafruit_BMP280.h>    // include adafruit library for BMP280 sensor
#define BMP280_I2C_ADDRESS  0x76   // define device I2C address: 0x76 or 0x77 
float ZeroAltPressure;   // presión en el nivel de altitude relativa 0
Adafruit_BMP280 bmp280;
 void setup() {
    Serial.begin(9600);
    Serial.println(F("Arduino + BMP280"));
   if (!bmp280.begin(BMP280_I2C_ADDRESS))   {  
     Serial.println("Could not find a valid BMP280 sensor, check wiring!");
     while (1);
    }
    ZeroAltPressure = bmp280.readPressure()/100; 
  }
 
void loop()
{   // get temperature, pressure and altitude from library
  float temperature = bmp280.readTemperature();         // get temperature
  float pressure    = bmp280.readPressure();            // get pressure
  float altitud   = bmp280.readAltitude(ZeroAltPressure);  // get altitude 

  Serial.print("Temperature = "); // print data on the serial monitor software
  Serial.print(temperature);
  Serial.print(" °C     ");
  Serial.print("Pressure = ");
  Serial.print(pressure/1000,3);
  Serial.print(" kPa    ");
  Serial.print("Approx Altitude = ");
  Serial.print(altitud*100);
  Serial.println(" cm    ");
    
  Serial.println();   // start a new line
  delay(1000);        // wait 1 seconds
  
}
