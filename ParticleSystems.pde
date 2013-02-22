import controlP5.*;
import org.ejml.*;
import org.ejml.simple.*;
import org.ejml.ops.*;

int tc = 0; // global time counter variable, in frames
float t = 0; // time in seconds
int fps = 60; // frames per second

boolean step = false; // step through frames
boolean usingGui = false;

ControlP5 cp5;
Toggle animate;
Numberbox gravity;

Particle p1, p2, p3;

Integrator ee, rk, gt;

Force g;

void setup() {
  size(800, 600, P3D);
  frameRate(fps);

  defineMyColors();

  // Particles
  p1 = new Particle(new pt(-300, -300, 0), 10, "Explicit Euler", blue);
  p2 = new Particle(new pt(0, -300, 0), 10, "Ground Truth", red);
  p3 = new Particle(new pt(300, -300, 0), 10, "Runge-Kutta 4", blue);

  // Forces
  g = new Gravity();
  float dg = ((Gravity)g).magnitude;

  // Integrators
  ee = new ExplicitEuler();
  rk = new RungeKutta();
  gt = new GroundTruth();

  // Control panel
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.setColorLabel(black);
  cp5.setColorValueLabel(black);
  cp5.setColorBackground(yellow);
  cp5.setColorForeground(orange);
  cp5.setColorActive(orange);

  gravity = cp5.addNumberbox("gravityValue")
    .setPosition(100,550)
    /*.setSize(100,20)*/
    .setRange(0,100)
    .setMultiplier(0.1) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setValue(dg)
    ;

  animate = cp5.addToggle("animateState")
    .setPosition(20,550)
    /*.setSize(50,20)*/
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    ;
}

void draw() {
  hint(ENABLE_DEPTH_TEST);
  background(200);
  changeViewAndFrame(zoom, true);

  // Update time from counter
  t = (float)tc / fps;

  // Draw the floor
  pushMatrix();
  translate(0, height/2, 0);
  rotateZ(PI/2);
  fill(yellow);
  noStroke();
  rectMode(CENTER);
  /*rect(0,0,width,height);*/
  box(10, width, 150);
  popMatrix();

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

  // Start 2D interface
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();

  cp5.draw();
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

void mousePressed() {
  usingGui = cp5.isMouseOver();
}

void mouseDragged() {
  if(keyPressed&&key=='z') { // zoom
    zoom += (mouseY - pmouseY)/200.0;
    zoom = max(zoom, 0.4);
  }

  if(keyPressed&&key=='e') {
    L.x-=(mouseX-pmouseX); L.x=max(-300,L.x); L.x=min(300,L.x);
    L.y-=(mouseY-pmouseY); L.y=max(-300,L.y); L.y=min(300,L.y);
  }

  if(!keyPressed&&!usingGui) {
    a-=PI*(mouseY-pmouseY)/height; a=max(-PI/2+0.1,a); a=min(PI/2-0.1,a); b+=PI*(mouseX-pmouseX)/width;
  }
}

void mouseReleased() {
  usingGui = false;
}

void gravityValue(float value) {
  ((Gravity)g).magnitude = value;
}

