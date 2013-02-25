import controlP5.*;
import org.ejml.*;
import org.ejml.simple.*;
import org.ejml.ops.*;

Mode mode;

int tc = 0; // global time counter variable, in frames
float t = 0; // time in seconds
int fps = 60; // frames per second
float h; // timestep size

boolean step = false; // step through frames
boolean usingGui = false;

ControlP5 cp5;
Toggle animate;
Button stepping;
Numberbox gravity;
Numberbox timestep;

Particle p1, p2, p3;
Particle[] ps = new Particle[50];

Integrator ee, rk, gt;

Force g, c;

void setup() {
  // Setup
  size(800, 600, P3D);
  frameRate(fps);

  defineMyColors();

  mode = Mode.galileo;

  // Particles
  p1 = new Particle(new pt(-300, -300, 0), 10, "Explicit Euler", blue);
  p2 = new Particle(new pt(0, -300, 0), 10, "Ground Truth", red);
  p3 = new Particle(new pt(300, -300, 0), 10, "Runge-Kutta 4", blue);

  for(int i = 0; i < ps.length; i++) {
    pt x = new pt(random(-200, 200), random(-200, 200), random(-200, 200));
    color cl = (random(1) >= 0.5) ? blue : white;
    ps[i] = new Particle(x, 10, null, cl);
  }

  // Forces
  g = new Gravity();
  float dg = ((Gravity)g).magnitude;

  c = new Collision(new pt(), new vec(500,500,500));

  // Constants
  float h0 = 1.0/(float)fps;

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
    .setPosition(80,550)
    .setRange(0,500)
    .setMultiplier(1.0) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setLabel("Gravity Value")
    .setValue(dg)
    ;

  timestep = cp5.addNumberbox("timestepValue")
    .setPosition(170,550)
    .setRange(0,10)
    .setMultiplier(0.001) // set the sensitifity of the numberbox
    .setDirection(Controller.HORIZONTAL) // change the control direction to left/right
    .setLabel("Timestep Value")
    .setValue(h0)
    ;

  animate = cp5.addToggle("animateState")
    .setPosition(20,550)
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("Animate")
    ;

  stepping = cp5.addButton("stepState")
    .setPosition(250,550)
    .setLabel("One Step")
    ;
}

void draw() {
  hint(ENABLE_DEPTH_TEST);
  background(200);
  changeViewAndFrame(zoom, true);

  // Update time from counter
  t = (float)tc / fps;

  switch(mode) {
  case galileo:
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
      ee.step(p1, h);
      rk.step(p3, h);
      gt.step(p2, h);

      tc++;
      step = false;
    }

    break;

  case snow:
    Collision cf = (Collision)c;
    pushMatrix();
    noFill();
    stroke(orange);
    strokeWeight(5);
    rectMode(CENTER);
    translate(cf.origin.x, cf.origin.y, cf.origin.z);
    box(cf.dim.x, cf.dim.y, cf.dim.z);
    popMatrix();

    for(int i = 0; i < ps.length; i++) {
      ps[i].draw();
      g.applyForce(ps[i]);
      c.applyForce(ps[i]);
      ee.step(ps[i], h);
    }

    ((Collision)c).moving();

    break;
  }

  // Start 2D interface
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();

  cp5.draw();

  fill(black);
  stroke(black);
  textAlign(RIGHT);
  text("You are in " + mode + " mode.", 780, 30);
  text("CONTROLS: 'r':reset, spacebar:animate, drag+'s':shake globe\n'm':switch modes, drag:rotate, drag+'z':zoom, drag+'e':view center", 780, 560);
}

void keyPressed() {
  if(key==' ')
    animate.setState(true);
}

void keyReleased() {
  if(key=='m')
    mode = mode.next();
  if(key==' ')
    animate.setState(false);
  if(key=='r') {
    p1.reset();
    p2.reset();
    p3.reset();
    ee.reset();
    rk.reset();
    gt.reset();

    t = 0;
    tc = 0;
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

  if(keyPressed&&key=='s') {
    pt cv = ((Collision)c).origin;
    cv.x+=(mouseX-pmouseX); cv.x=max(-300,cv.x); cv.x=min(300,cv.x);
    cv.y+=(mouseY-pmouseY); cv.y=max(-300,cv.y); cv.y=min(300,cv.y);
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

void timestepValue(float value) {
  h = value;
}

void stepState(boolean value) {
  step = value;
}
