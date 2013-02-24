class Collision extends Force {
  float kr = 1.0; // coefficient of restitution
  pt origin; // center of box
  vec dim; // dimensions of box

  Collision(pt o, vec d) {
    this.origin = new pt(o);
    this.dim = new vec(d);
  }

  // Override application, since collision
  // force is easier to apply directly
  // to the velocity.
  Particle applyForce(Particle p) {
    vec f = V(origin, p.x);
    vec s = (new vec(f)).absolute();
    vec b = (new vec(dim)).div(2).sub(p.r);

    stroke(orange);
    strokeWeight(5);
    show(p.x, f.face().mul(50));

    if(s.x >= b.x || s.y >= b.y || s.z >= b.z) {
      // Check if we are entering a collision
      vec wn = f.face().rev(); // cube wall normal

      if(d(p.v, wn) < 0) {
        // Get the normal component of the velocity
        vec vn = V(d(p.v, wn), wn);
        p.v.add(vn.mul(-2.0));
      }
    }

    return p;
  }

  vec forceOn(Particle p) {
    return new vec();
  }
}
