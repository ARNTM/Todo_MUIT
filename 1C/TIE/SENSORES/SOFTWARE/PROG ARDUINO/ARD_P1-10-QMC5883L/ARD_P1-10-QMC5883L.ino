
#include <QMC5883LCompass.h>

QMC5883LCompass compass;

void setup() {
  Serial.begin(9600);
  compass.init();
  //Pegue el resultado de la calibración a continuación
  compass.setCalibration(-2220, 1242, -2043, 908, -1490, 1876);
  
  }

void loop() {
  int x, y, z;
  float Hx, Hy, Hz, moduloH;
  
  // Read compass values
  compass.read();

  // Return XYZ readings
  x = compass.getX()/35;
  y = compass.getY()/35;
  z = compass.getZ()/35;
  moduloH=sqrt(x*x+y*y+z*z);
    
  Serial.print("Hx = ");
  Serial.print(x);
  Serial.print("      Hy = ");
  Serial.print(y);
  Serial.print("      Hz = "); 
  Serial.print(z);
  Serial.print("      |Z| = ");
  Serial.print(moduloH,0);
  
  Serial.println();
  
  delay(10);
}
