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
    vec pos = V(x,p.x).div(r);
    vec vel = V(p.v).div(r);
    vec frc = V(p.f).div(r);
    vec acc = V(frc).div(p.m);

    /*vec C   = V(pos).mul(pos).div(2).sub(0.5);*/
    float C  = 0.5*n2(pos) - 0.5;
    float Cd = d(pos,vel);

    vec dC  = V(pos);
    vec ddC = V(vel);

    /*vec fbk = V(ks,C).add(V(kd,dC));*/
    float fbk = -ks*C - kd*Cd;
    /*ddC.add(fbk);*/

    /*println(fbk);*/
    /*println(pos);*/
    /*println(C);*/
    /*println(dC);*/
    /*println(n2(dC));*/
    /*println(ddC);*/

    float lambda = (-d(dC, frc) - p.m*d(ddC, vel) + fbk) / n2(dC);

    /*println(lambda);*/

    return dC.mul(r*lambda);

  }
}
