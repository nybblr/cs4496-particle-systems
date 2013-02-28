class Constraint extends Force {
  pt x; // center of circle
  float r; // radius

  private float ks = 1.0;
  private float kd = 1.0;

  Constraint(pt x, float r) {
    this.x = new pt(x);
    this.r = r;
  }

  vec forceOn(Particle p) {
    float r2 = sq(r);

    vec pos = V(x,p.x);
    vec C   = V(pos).mul(pos).div(2).div(r2).sub(0.5);
    vec dC  = V(pos).mul(p.v).div(r2);

    vec fbk = V(ks,C).add(V(kd,dC));
    vec ddC = V(1.0/p.m,p.f).mul(pos).sub(V(p.v).mul(p.v)).div(r2);
    /*ddC.add(fbk);*/

    float lambda = (-d(dC, p.f) - p.m*d(ddC, p.v)) / n2(dC);

    return dC.mul(lambda);
  }
}
