import controlP5.*;
import org.ejml.*;
import org.ejml.simple.*;
import org.ejml.ops.*;

int tc = 0; // global time counter variable, in frames
float t = 0; // time in seconds
int fps = 30; // frames per second

boolean step = false; // step through frames

ControlP5 cp5;
Toggle animate;
Numberbox gravity;

Particle p1, p2, p3;

Integrator ee, rk, gt;

Force g;

void setup() {
  size(800, 600);
  frameRate(fps);

  defineMyColors();

  // Particles
  p1 = new Particle(new pt(100, 50), 10, "Explicit Euler", red);
  p2 = new Particle(new pt(400, 50), 10, "Ground Truth", blue);
  p3 = new Particle(new pt(700, 50), 10, "Runge-Kutta 4", green);

  // Forces
  g = new Gravity();
  float dg = ((Gravity)g).magnitude;

  // Integrators
  ee = new ExplicitEuler();
  rk = new RungeKutta();
  gt = new GroundTruth();
  ((GroundTruth)gt).initWith(p2);

  // Control panel
  cp5 = new ControlP5(this);

  gravity = cp5.addNumberbox("gravityValue")
    .setPosition(100,500)
    .setSize(100,20)
    .setRange(0,100)
    .setMultiplier(0.1) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(dg)
    ;

  animate = cp5.addToggle("animateState")
    .setPosition(20,500)
    .setSize(50,20)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;
}

void draw() {
  background(255);

  // Update time from counter
  t = (float)tc / fps;

  p1.draw();
  p2.draw();
  p2.drawGuide();
  p3.draw();

  if(step || animate.getState()) {
    g.applyForce(p1);
    g.applyForce(p2);
    g.applyForce(p3);
    ee.step(p1, 1.0 / fps);
    rk.step(p3, 1.0 / fps);
    gt.step(p2, 1.0 / fps);

    tc++;
    step = false;
  }
}

void keyPressed() {
  if(key==' ')
    animate.setState(true);
}

void keyReleased() {
  if(key==' ')
    animate.setState(false);
  if(key=='r') {
    p1.reset();
    p2.reset();
    p3.reset();
    ee.reset();
    rk.reset();
    gt.reset();
  }
}

void gravityValue(float value) {
  ((Gravity)g).magnitude = value;
}
