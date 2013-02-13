import controlP5.*;

ControlP5 cp5;
Numberbox nb1;

void setup() {
  size(800, 600);

  cp5 = new ControlP5(this);

  nb1 = cp5.addNumberbox("numberbox")
    .setPosition(100,160)
    .setSize(100,14)
    .setScrollSensitivity(1.1)
    .setValue(50)
    ;

  cp5.addNumberbox("numberboxValue")
     .setPosition(100,200)
     .setSize(100,14)
     .setRange(0,200)
     .setMultiplier(0.1) // set the sensitifity of the numberbox
     .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
     .setValue(100)
     ;
  cp5.addTextfield("input")
     .setPosition(20,100)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
}

void draw() {
  background(255);
  fill(0);
  stroke(0);
  text("It is "+nb1.getValue(), 100, 100);
}
