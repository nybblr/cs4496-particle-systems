class Gravity extends Force {
  float magnitude = 1.0;
  vec direction = new vec(0, -1.0);

  vec forceOn(Particle p) {
    return (new vec(this.direction)).scaleBy(this.magnitude).scaleBy(p.m);
  }
}
