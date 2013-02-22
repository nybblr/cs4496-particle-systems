class GroundTruth extends Integrator {
  Particle step(Particle p, float h) {
    t += h;

    pt xn = (new pt(p.x0)).add((new vec(p.v0)).scaleBy(t).add((new vec(p.f)).scaleBy(0.5/p.m*sq(t))));

    p.x = xn;

    p.clearForce();
    return p;
  }
}
