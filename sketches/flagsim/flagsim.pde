/**
 * Flag Simulation
 * Author: Duncan Tilley
 *
 *     Flag simulation using a newtonian particle system.
 **/

// variables
Flag flag;
boolean msg = true;

void setup() {
  size(1280, 720, P3D);
  // determine flag location
  int flagWidth = 360;
  int flagHeight = 240;
  float flagX = (width - flagWidth) / 2.0f;
  float flagY = 0.0f;//(height - flagHeight) / 2.0f;
  flag = new Flag(flagX, flagY, 0.0f, flagWidth, flagHeight, 20, 15);
}

void draw() {
  background(216, 231, 234);
  lights();
  flag.update();
  flag.draw();
  if (msg) {
    fill(0x2e);
    String welcome = "Flag Simulation\n" +
        "    by Duncan Tilley";
    text(welcome, 20, 20);
  }
}

void mouseReleased() {
}

void mousePressed() {
}

void mouseDragged() {
}
