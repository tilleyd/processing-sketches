/**
 * Boids Simulator
 * Author: Duncan Tilley
 *
 *     Boid flocking behaviour simulation.
 **/

// variables
World world;
boolean msg = true;

void setup() {
  size(1280, 720, P3D);
  world = new World();
}

void draw() {
  background(77, 55, 77);
  world.update(width, height);
  world.draw();
  if (msg) {
    String welcome = "Boid Simulation\n" +
        "    by Duncan Tilley\n" +
        "Left click to place a boid\n" +
        "Right click to move the goal\n" +
        "Middle click to place an obstacle";
    text(welcome, 10, 10);
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    world.addBoid(mouseX, mouseY);
  } else if (mouseButton == RIGHT) {
    world.goalEnabled(false);
  } else {
    world.addObstacle(mouseX, mouseY);
  }
  msg = false;
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    world.goalEnabled(true);
    msg = false;
  }
}

void mouseDragged() {
  if (world.goalEnabled()) {
    world.goal(mouseX, mouseY);
  }
}
