import controlP5.*;
import processing.serial.*;

Serial port;
float brightness = 0;
char lf = '\n';

ControlP5 cp5;
void setup(){
  size(500,500);
  smooth();
  noStroke();
  
  port = new Serial(this, "COM4", 9600);
  port.bufferUntil(lf);
  
  cp5 = new ControlP5(this);

  cp5.addButton("btnLED1")
     .setValue(1)
     .setPosition(100,100)
     .setSize(200,30)
     .setLabel("LED 1");
     ;
     
  cp5.addButton("btnLED2")
     .setValue(2)
     .setPosition(100,220)
     .setSize(200,30)
     .setLabel("LED2");
     ;
}

void btnLED1(int value) {
  println("a button event from: " + value); //<>//
}

void btnLED2(int value) {
  println("a button event from: " + value);
}

void draw(){
  background(0);
  drawBox(brightness);
}

void drawBox(float b){
  fill(0, 0, b);
  rect(30, 20, 55, 55);
}

public void controlEvent(ControlEvent evt) {
  int v = Math.round(evt.getController().getValue());  
  byte[] b = String.valueOf(v).getBytes();
  port.write(b);
  println(v);
}

void serialEvent(Serial port){
 brightness = float(port.readStringUntil(lf));
 //println(brightness);
}