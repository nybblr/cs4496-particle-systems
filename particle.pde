class Particle {
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
    this.r = p.r;
    this.c = p.c;
    this.label = new String(p.label);
  }

  Particle(pt x, vec v, vec f, float m) {
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

  Particle addForce(vec g) {
    this.f.add(g);
    return this;
  }

  Particle clearForce() {
    this.f.zero();
    return this;
  }

  SimpleBase dx(SimpleBase x, float t, float h) {
    Particle p = toParticle(x);
    vec v0 = p.v;
    vec a = (new vec(p.f)).divideBy(p.m);
    vec vn = v0.add(a.scaleBy(h));
    p.v = vn;
    return p.xPhase();
  }

  SimpleBase xPhase() {
    SimpleBase m = new SimpleMatrix(2, 2);

    m.setRow(0, 0, x.x, x.y);
    m.setRow(0, 0, v.x, v.y);

    return m;
  }

  Particle toParticle(SimpleBase m) {
    Particle p = new Particle(this);

    p.x.x = (float)m.get(0,0); p.x.y = (float)m.get(0,1);
    p.v.x = (float)m.get(1,0); p.v.y = (float)m.get(1,1);

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
    line(0, x.y+r, width, x.y+r);

    return this;
  }
}
