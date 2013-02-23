class Collision extends Force {
  float kr = 1.0; // coefficient of restitution
  pt origin; // center of box
  vec dim; // dimensions of box

  Collision(pt o, vec d) {
    this.origin = new pt(o);
    this.dim = new vec(d);
  }

  // Override application, since collision
  // force is easier to apply directly
  // to the velocity.
  Particle applyForce(Particle p) {
    return p;
  }

  vec forceOn(Particle p) {
    return new vec();
  }
}
