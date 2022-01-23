#include <Wire.h>
#include <MechaQMC5883.h>
#include <Math.h>

MechaQMC5883 qmc;

void setup() {
  Wire.begin();
  Serial.begin(9600);
  qmc.init();
  qmc.setMode(Mode_Continuous,ODR_10Hz,RNG_2G,OSR_512);
 qmc.setCalibration(-1830, 987, -2306, 365, -1220, 1483);

  }

void loop() {
  int x, y, z;
  float azimuth;
  float moduloH;
  int offsetx=20;
  int offsety=+14;
  
  qmc.read(&x, &y, &z,&azimuth);
  
 float x1=x/12000.0/(4*PI*1e-3)+offsetx;
 float y1=y/12000.0/(4*PI*1e-3)+offsety;
 float  z1=z/12000.0/(4*PI*1e-3);

  
  Serial.print("Hx= ");
  Serial.print(x1,2);
  Serial.print(" A/m ");
  Serial.print("\t");
    
  Serial.print("Hy= ");
  Serial.print(y1,2);
  Serial.print(" A/m ");
  Serial.print("\t");
  
  Serial.print("Hz= ");
  Serial.print(z1,2);
  Serial.print(" A/m ");
  Serial.print("\t");

  Serial.print("Azimut= ");
  Serial.print(azimuth,2);
  Serial.print("\t");

  Serial.println();
  delay(250);
  }
