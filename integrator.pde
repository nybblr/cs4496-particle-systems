abstract class Integrator {
  int t = 0; // how many time steps?
  abstract Integrator step(Particle p);

  Integrator resetTime() {
    this.t = 0;
    return this;
  }
}
