import processing.serial.*;
Serial port_1;
PImage background;
PImage dial;
float heading;
float headrad;

void setup() {
  //change the 0 to a 1 or 2 etc, to match your port.
  port_1 = new Serial(this, Serial.list()[1], 9600);
  background = loadImage("bg.png");//Adding image to processing
  dial = loadImage("dial.png");//Adding image to processing
  size(600, 600);
  frameRate(29);
  port_1.bufferUntil ( '\n' );
}

void draw() {
  translate(width/2, height/2);
  image(background, 0, 0, width, height);
  imageMode(CENTER);
  headrad = map(heading, 0, 360, 0, 6.283);
  //println(headrad);
  rotate(-headrad);
  image(dial, 0, 0, width, height);
}

void serialEvent (Serial port_1)
{
  heading = float(port_1.readStringUntil('\n'));
}
