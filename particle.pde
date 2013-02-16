class particle {
  pt x;
  vec v;
  vec f;
  float m;

  particle(pt x, vec v, vec f, float m) {
    this.x = pt(x);
    this.v = vec(v);
    this.f = vec(f);
    this.m = m;
  }

  particle(pt x, float m) {
    this(x, new vec(), new vec(), m);
  }

  particle addForce(vec g) {
    this.f.add(g);
    return this;
  }
  
  particle clearForce() {
    this.f.zero();
    return this;
  }
}
