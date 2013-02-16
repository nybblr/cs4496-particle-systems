class ExplicitEuler extends Integrator {
  Particle step(Particle p, float h) {
    pt xn = (new pt(p.x)).add((new vec(p.v)).scaleBy(h));
    vec vn = (new vec(p.v)).add((new vec(p.f)).divideBy(p.m).scaleBy(h));

    p.x = xn; p.v = vn;
    p.clearForce();

    return p;
  }
}
