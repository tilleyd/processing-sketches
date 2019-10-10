/**
 * Particle
 * Author: Duncan Tilley
 *
 *     A single vertex particle of the flag.
 **/

import java.util.*;

class Particle {
  
  private Vector _pos;
  private Vector _vel;
  private boolean _fixed;

  public Particle(float x, float y, float z) {
    _pos = new Vector(x, y, z);
    _vel = new Vector();
    _fixed = false;
  }

  // ACCESSORS

  public Vector pos() {
    return _pos;
  }
  
  public void pos(Vector p) {
    _pos = p;
  }

  public Vector vel() {
    return _vel;
  }
  
  public void vel(Vector v) {
    _vel = v;
  }
  
  public boolean fixed() {
    return _fixed;
  }
  
  public void fixed(boolean f) {
    _fixed = f;
  }

}
