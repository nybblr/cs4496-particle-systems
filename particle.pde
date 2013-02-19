class Particle {
  pt x;
  vec v;
  vec f;
  float m;

  // Display
  float r = 20;
  color c = 0;
  String label;

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

  SimpleMatrix dx(SimpleMatrix x, t, h) {
    p = toParticle(x);
    vec v0 = p.v;
    vec a = (new vec(p.f)).divideBy(p.m);
    vec vn = v0.add(a.scaleBy(h));
    p.v = vn;
    return p.toPhase();
  }

  SimpleMatrix toPhase() {
  
  }

  Particle toParticle(SimpleMatrix m) {
  
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
