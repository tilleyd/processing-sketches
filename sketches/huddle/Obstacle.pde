/**
 * Obstacle
 * Author: Duncan Tilley
 *
 *     A static object that the boids avoid.
 **/

import java.util.*;

class Obstacle {
  
  private Vector _pos;

  public Obstacle(float x, float y) {
    _pos = new Vector(x, y);
  }

  // ACCESSORS

  public Vector pos() {
    return _pos;
  }

  // AUX

  public void draw() {
    fill(221, 85, 77);
    noStroke();
    ellipse(_pos.x(), _pos.y(), 25.0f, 25.0f);
  }

}
