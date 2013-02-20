class RungeKutta extends Integrator {
  Particle step(Particle p, float h) {
    SimpleMatrix  x = new SimpleMatrix();
    SimpleMatrix dx = new SimpleMatrix();

    SimpleMatrix k1 = h * p.dx(x, t, 0);
    SimpleMatrix k2 = h * p.dx(x + k1 / 2.0, t, h / 2.0);
    SimpleMatrix k3 = h * p.dx(x + k2 / 2.0, t, h / 2.0);
    SimpleMatrix k4 = h * p.dx(x + k3, t, h);

    SimpleMatrix xn = x + 1.0/6.0*k1 + 1.0/3.0*k2 + 1.0/3.0*k3 + 1.0/6.0*k4;

    return p;
  }
}
