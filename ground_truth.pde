class GroundTruth extends Integrator {
  pt x0;
  vec v0;

  Particle initWith(Particle p) {
    x0 = new pt(p.x);
    v0 = new vec(p.v);

    return p;
  }

  Particle step(Particle p, float h) {
    t += h;

    pt xn = (new pt(x0)).add((new vec(v0)).scaleBy(t).add((new vec(p.f)).scaleBy(0.5/p.m*sq(t))));

    p.x = xn;

    p.clearForce();
    return p;
  }
}
