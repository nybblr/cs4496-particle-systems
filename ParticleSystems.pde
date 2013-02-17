import controlP5.*;
import org.ejml.*;
import org.ejml.simple.*;

int tc = 0; // global time counter variable, in frames
float t = 0; // time in seconds
int fps = 10; // frames per second

boolean step = false; // step through frames
Toggle animate;

ControlP5 cp5;
Numberbox nb1;

Particle p1 = new Particle(new pt(100, 50), 10),
         p2 = new Particle(new pt(400, 50), 10),
         p3 = new Particle(new pt(700, 50), 10);

Integrator ee, gt;

Force g = new Gravity();

void setup() {
  size(800, 600);
  frameRate(fps);

  cp5 = new ControlP5(this);

  nb1 = cp5.addNumberbox("numberboxValue")
    .setPosition(100,200)
    .setSize(100,14)
    .setRange(0,200)
    .setMultiplier(0.1) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(100)
    ;

  // create a toggle and change the default look to a (on/off) switch look
  animate = cp5.addToggle("toggle")
    .setPosition(40,250)
    .setSize(50,20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;

  ee = new ExplicitEuler();
  gt = new GroundTruth();
  ((GroundTruth)gt).initWith(p2);
}

void draw() {
  background(255);

  // Update time from counter
  t = (float)tc / fps;

  fill(0);
  stroke(0);
  text("animate: "+animate.getState(), 50, 550);

  p1.draw(red);
  p2.draw(green);
  p3.draw(blue);

  if(step || animate.getState()) {
    g.applyForce(p1);
    g.applyForce(p2);
    ee.step(p1, 1.0 / fps);
    gt.step(p2, 1.0 / fps);

    tc++;
    step = false;
  }
}
