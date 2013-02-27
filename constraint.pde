class Constraint extends Force {
  pt x; // center of circle
  float r; // radius

  Constraint(pt x, float r) {
    this.x = new pt(x);
    this.r = r;
  }

  vec forceOn(Particle p) {
    return new vec();
  }
}
