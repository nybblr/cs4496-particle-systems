class RungeKutta extends Integrator {
  Particle step(Particle p, float h) {
    SimpleBase x0 = p.xPhase();

    SimpleBase k1 = p.dx(x0, t, 0).scale(h);
    SimpleBase k2 = p.dx(((SimpleBase)(new SimpleMatrix((SimpleMatrix)k1))).divide(2.0).plus(x0), t, h / 2.0).scale(h);
    SimpleBase k3 = p.dx(((SimpleBase)(new SimpleMatrix((SimpleMatrix)k2))).divide(2.0).plus(x0), t, h / 2.0).scale(h);
    SimpleBase k4 = p.dx(((SimpleBase)(new SimpleMatrix((SimpleMatrix)k3))).plus(x0), t, h).scale(h);

    SimpleBase xn = x0.copy();
    xn.plus(k1.scale(1.0/6.0));
    xn.plus(k2.scale(1.0/3.0));
    xn.plus(k3.scale(1.0/3.0));
    xn.plus(k4.scale(1.0/6.0));

    return p;
  }
}
