Particle Systems
================
- CS4496: Computer Animation
- Prof. Karen Liu
- By Jonathan Martin

Thanks to Prof. Jarek Rossignac for the 3D vector library (distributed freely). I heavily modified and added to it to make it fit my coding style and needs with utility functions and interpolation methods.

Setup
-----
This Processing applet requires a few dependencies:
- Processing obviously, specifically 2.0b7 (required as OpenGL API has completely changed in P3D)
- [ControlP5](http://www.sojamo.de/libraries/controlP5/), a GUI library. Included under `/libs`.
- [Efficient Java Matrix Library](https://code.google.com/p/efficient-java-matrix-library/), a comprehensive Matrix math library. A custom built Processing-wrapped version is included under `/libs`.

Once you have installed Processing, locate the Processing's `Processing/libraries` directory (on Mac OSX, it is under `~/Documents/` by default) and copy both ControlP5 and EJML into the directory; restart Processing.

You should be able to compile and run the app from Processing's GUI or the command line tools included in beta 7. A precompiled version of the applet is also included under `/tmp`, **but it may not run on your computer.**

Controls & Notes
----------------
The applet has a straighforward control legend in the bottom right corner. In Galileo mode, the red line shows the bottom of the Ground Truth particle, and makes it easier to compare the two integration methods. Explicit Euler will produce good results at 60 FPS, but raising the timestep value and gravity strength will expose it's poor performance.

Note that increasing the timestep will accelerate the animation, so you can click the "Step State" button to simulate one frame at a time in Galileo mode.

In the absence of physical units, the gravity control is in pixels per second squared. The default of 10.0 p/s^2 may be too slow for Galileo mode, but works well for the snowglobe; hence, it is adjustable (as are the other controls) by dragging the GUI control horizontally.
