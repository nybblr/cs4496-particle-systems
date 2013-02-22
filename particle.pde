class Particle {
  pt x0;
  vec v0;
  pt x;
  vec v;
  vec f;
  float m;

  // Display
  float r = 20;
  color c = 0;
  String label;

  Particle(Particle p) {
    this(p.x, p.v, p.f, p.m);
    this.x0 = new pt(p.x);
    this.v0 = new vec(p.v);
    this.r = p.r;
    this.c = p.c;
    this.label = new String(p.label);
  }

  Particle(pt x, vec v, vec f, float m) {
    this.x0 = new pt(x);
    this.v0 = new vec(v);
    this.x = new pt(x);
    this.v = new vec(v);
    this.f = new vec(f);
    this.m = m;
  }

  Particle(pt x, float m, String label, color c) {
    this(x, new vec(), new vec(), m);
    this.label = label;
    this.c = c;
  }

  String toString() {
    return xPhase().toString();
  }

  Particle reset() {
    clearForce();
    x = new pt(x0);
    v = new vec(v0);

    return this;
  }

  Particle addForce(vec g) {
    this.f.add(g);
    return this;
  }

  Particle clearForce() {
    this.f.zero();
    return this;
  }

  SimpleBase dx(SimpleBase x, SimpleBase k, float t, float h) {
    SimpleBase d = dxPhase();

    // Add in k's velocity and the force's acceleration
    d.set(0,0, d.get(0,0) + f.x/m*h);
    d.set(0,1, d.get(0,1) + f.y/m*h);
    d.set(0,2, d.get(0,2) + f.z/m*h);

    return d;
  }

  SimpleBase xPhase() {
    SimpleBase m = new SimpleMatrix(2, 3);

    m.setRow(0, 0, x.x, x.y, x.z);
    m.setRow(1, 0, v.x, v.y, v.z);

    return m;
  }

  SimpleBase dxPhase() {
    SimpleBase d = new SimpleMatrix(2, 3);

    d.setRow(0, 0, v.x, v.y, v.z);
    d.setRow(1, 0, f.x/m, f.y/m, f.z/m);

    return d;
  }

  Particle toParticle(SimpleBase m) {
    Particle p = new Particle(this);

    p.x.x = (float)m.get(0,0); p.x.y = (float)m.get(0,1); p.x.z = (float)m.get(0,2);
    p.v.x = (float)m.get(1,0); p.v.y = (float)m.get(1,1); p.v.z = (float)m.get(1,2);

    return p;
  }

  Particle draw() {
    fill(c);
    noStroke();
    show(x, r);

    fill(black);
    stroke(black);
    textAlign(CENTER, BOTTOM);
    text(label, x.x, x.y-r);

    return this;
  }

  Particle drawGuide() {
    fill(c);
    stroke(c);
    line(-width/2, x.y+r, width/2, x.y+r);

    return this;
  }
}
