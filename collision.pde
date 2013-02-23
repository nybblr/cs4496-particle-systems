class Collision extends Force {
  float kr = 1.0; // coefficient of restitution

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
