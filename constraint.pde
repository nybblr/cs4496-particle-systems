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
    /*float r2 = sq(r);*/

    vec pos = V(x,p.x).div(r);
    vec C   = V(pos).mul(pos).div(2).sub(0.5);
    vec dC  = V(pos).mul(p.v);

    vec fbk = V(ks,C).add(V(kd,dC));
    vec ddC = V(1.0/p.m,p.f).mul(pos).sub(V(p.v).mul(p.v));
    /*ddC.add(fbk);*/

    println(pos);
    println(C);
    println(dC);
    println(n2(dC));
    println(ddC);

    float lambda = (-d(dC, p.f) - p.m*d(ddC, p.v)) / n2(dC);

    println(lambda);

    return dC.mul(lambda);
  }
}
