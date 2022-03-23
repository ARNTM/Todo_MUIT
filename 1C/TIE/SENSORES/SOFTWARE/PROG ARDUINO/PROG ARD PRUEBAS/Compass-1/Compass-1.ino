#include <Wire.h>
#include <MechaQMC5883.h>


MechaQMC5883 mag;

void setup(void)
{
  Wire.begin();
  Serial.begin(9600);
  mag.init();
  mag.setMode(Mode_Continuous,ODR_10Hz,RNG_2G,OSR_512);
}

void loop()
{
  int x, y, z;
  float azimuth;
  float moduloH;
 mag.read(&x, &y, &z,&azimuth);
 float x1=x/12000.0/(4*PI*1e-3);
 float y1=y/12000.0/(4*PI*1e-3);
 float z1=z/12000.0/(4*PI*1e-3);
 float orientacion=(180/PI)*atan2(y1,x1);
 if (orientacion <0) {
  orientacion=orientacion+360;
 }
  
 Serial.print(orientacion);
 Serial.print('\t');
 Serial.println(azimuth);
 delay(200);
}
