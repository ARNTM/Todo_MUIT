
// i2c_scanner
// Este boceto prueba las direcciones estándar de 7 bits. 
// Los dispositivos con dirección de bits más alta 
// no pueden ser vistas correctamente.

#include <Wire.h>

void setup()
{
Wire.begin();
 
Serial.begin(9600);
Serial.println("\nI2C Scanner");
}
 
void loop()
{
byte error, address;
int nDevices;
 
Serial.println("Scanning...");
 
nDevices = 0;
for(address = 1; address < 127; address++ ) 
{
// El i2c_scanner utiliza el valor devuelto o el 
// Write.endTransmisstion para ver si un 
// dispositivo reconoció la dirección.
Wire.beginTransmission(address);
error = Wire.endTransmission();
 
if (error == 0)
{
Serial.print("Dispositivo I2C en dirección 0x");
if (address<16) 
Serial.print("0");
Serial.println(address,HEX);
Serial.println();
 
nDevices++;
}
else if (error==4) 
{
Serial.print("Error desconocido en dirección 0x");
if (address<16) 
Serial.print("0");
Serial.println(address,HEX);
} 
}
if (nDevices == 0)
Serial.println("Dispositivo I2C No hallado.\n");
//else
//Serial.println("hecho\n");
 
delay(3000);   // espera 3 segundos para otro scan
}
