pt T = P(); // camera target point set with mouse when pressing 't'
pt E = P(), L=P(); // eye and lookAt
float d=800, b=PI/2.0, a=0; // view parameters: distance, angles, q
float zoom = 1.0;

void  changeViewAndFrame(float zoom, boolean lights) {
  float ca=cos(a), sa=sin(a), cb=cos(b), sb=sin(b); // viewing direction angles
  E.set(d*cb*ca, d*sa, d*sb*ca); // sets the eye
  camera(zoom*E.x, zoom*E.y, zoom*E.z, L.x, L.y, L.z, 0.0, 1.0, 0.0); // defines the view : eye, ctr, up
  if (lights)
    directionalLight(250, 250, 250, -E.x, -E.y, -E.z); // puts a white light above and to the left of the viewer
}
