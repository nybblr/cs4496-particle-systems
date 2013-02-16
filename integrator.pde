abstract class Integrator {
  int t = 0; // how many time steps?
  abstract Particle step(Particle p);

  int resetTime() {
    int time = this.t;
    this.t = 0;
    return time;
  }
}
