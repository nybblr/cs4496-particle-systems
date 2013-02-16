abstract class Integrator {
  float t = 0; // how many time steps?
  abstract Particle step(Particle p, float h);

  float resetTime() {
    float time = this.t;
    this.t = 0;
    return time;
  }
}
