class RungeKutta extends Integrator {
  Particle step(Particle p, float h) {
    SimpleBase x0 = p.xPhase();
    /*println(x0.toString());*/

    SimpleBase k1 = p.dx(x0, new SimpleMatrix(2,2), t, 0).scale(h);
    SimpleBase k2 = p.dx(x0, ((SimpleBase)(new SimpleMatrix((SimpleMatrix)k1))).divide(2.0), t, h / 2.0).scale(h);
    SimpleBase k3 = p.dx(x0, ((SimpleBase)(new SimpleMatrix((SimpleMatrix)k2))).divide(2.0), t, h / 2.0).scale(h);
    SimpleBase k4 = p.dx(x0, ((SimpleBase)(new SimpleMatrix((SimpleMatrix)k3))), t, h).scale(h);

    SimpleBase xn = x0.copy();
    xn = xn.plus(k1.scale(1.0/6.0));
    xn = xn.plus(k2.scale(1.0/3.0));
    xn = xn.plus(k3.scale(1.0/3.0));
    xn = xn.plus(k4.scale(1.0/6.0));

    p.x.x = (float)xn.get(0,0); p.x.y = (float)xn.get(0,1);
    p.v.x = (float)xn.get(1,0); p.v.y = (float)xn.get(1,1);

    p.clearForce();

    t += h;

    return p;
  }
}
