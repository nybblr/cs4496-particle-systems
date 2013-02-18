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

  Particle draw() {
    fill(c);
    noStroke();
    show(x, r);

    return this;
  }

  Particle drawGuide() {
    fill(c);
    stroke(c);
    line(0, x.y+r, width, x.y+r);

    return this;
  }
}
