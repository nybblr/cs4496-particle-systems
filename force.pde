abstract class Force {
  abstract vec forceOn(Particle p);
  Particle applyForce(Particle p) {
    p.addForce(forceOn(p));
    return p;
  }
}
