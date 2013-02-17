class Particle {
  pt x;
  vec v;
  vec f;
  float m;

  Particle(pt x, vec v, vec f, float m) {
    this.x = new pt(x);
    this.v = new vec(v);
    this.f = new vec(f);
    this.m = m;
  }

  Particle(pt x, float m) {
    this(x, new vec(), new vec(), m);
  }

  Particle addForce(vec g) {
    this.f.add(g);
    return this;
  }

  Particle clearForce() {
    this.f.zero();
    return this;
  }

  Particle draw(color c) {
    fill(c);
    noStroke();
    show(x, 20);

    return this;
  }
}
