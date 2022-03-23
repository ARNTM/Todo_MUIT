

#include <Wire.h>             // include Wire library, required for I2C devices
#include <Adafruit_Sensor.h>  // include Adafruit sensor library
#include <Adafruit_BMP280.h>  // include adafruit library for BMP280 sensor
#define BMP280_I2C_ADDRESS  0x76   // define device I2C address: 0x76 or 0x77 (0x77 is library default address)

Adafruit_BMP280 bmp280;
float localAltitude = 0;
void setup() {
  Serial.begin(9600);
  //Serial1.begin(9600);
  //Serial.println(F("Arduino + BMP280"));
  if (!bmp280.begin(BMP280_I2C_ADDRESS))
  {
    //Serial.println("Could not find a valid BMP280 sensor, check wiring!");
    while (1);
  }
  for (int j = 0; j < 1000; j++) {
    localAltitude = localAltitude + bmp280.readPressure();
  }
  localAltitude = localAltitude / 1000;
}
void loop() {
  float pressure = 0;
  float avgpressure = 0;
  float temperature = 0;
  float avgtemperature = 0;
  float altitud = 0;
  float avgaltitud = 0;
  float seaLevelhPa = localAltitude / 100; // Presión atmosférica de referencia para altidud relativa=0
  int nummuestras = 1000;       // nº de lecturas a promediar


  for (int i = 0; i < nummuestras; i++) {
    pressure = bmp280.readPressure();
    temperature = bmp280.readTemperature();
    altitud = bmp280.readAltitude(seaLevelhPa);
    avgpressure = avgpressure + pressure;
    avgtemperature = avgtemperature + temperature;
    avgaltitud = avgaltitud + altitud;
  }
  pressure = avgpressure / nummuestras;
  temperature = avgtemperature / nummuestras;
  altitud = avgaltitud / nummuestras;
  /*Serial.print("Pressure = ");
    Serial.print(pressure);
    Serial.print("Pa,   ");
  
    Serial.print("Temperature = ");
    Serial.print(temperature);
    Serial.print(" ºC,   ");*/
    delay(16000);
    Serial.print(altitud * 100);
  /*Serial.print("Altitude = ");
  Serial.print(altitud * 100);
  Serial.println(" cm,   ");*/

}
