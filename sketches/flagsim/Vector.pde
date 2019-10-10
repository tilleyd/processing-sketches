/**
 * Vector
 * Author: Duncan Tilley
 *
 *     3D vector with basic vector operations.
 **/

class Vector {

  private float _x, _y, _z;

  public Vector() {
    _x = _y = _z = 0.0;
  }

  public Vector(float x, float y, float z) {
    _x = x;
    _y = y;
    _z = z;
  }
    
  // ACCESSORS

  public float x() {
    return _x;
  }

  public float y() {
    return _y;
  }

  public float z() {
    return _z;
  }
  
  public void x(float x) {
    _x = x;
  }
  
  public void y(float y) {
    _y = y;
  }
  
  public void z(float z) {
    _z = z;
  }

  public float mag() {
    return (float)Math.sqrt(_x*_x + _y*_y + _z*_z);
  }

  public float distance(Vector v) {
    float xd = _x - v.x();
    float yd = _y - v.y();
    float zd = _z - v.z();
    return (float)Math.sqrt(xd*xd + yd*yd + zd*zd);
  }

  // OPERATORS

  public Vector add(Vector v) {
    return new Vector(_x + v.x(), _y + v.y(), _z + v.z());
  }
  
  public Vector subtract(Vector v) {
    return new Vector(_x - v.x(), _y - v.y(), _z - v.z());
  }

  public Vector negate() {
    return new Vector(-_x, -_y, -_z);
  }

  public Vector multiply(float sc) {
    return new Vector(sc * _x, sc * _y, sc * _z);
  }

  public Vector clone() {
    return new Vector(_x, _y, _z);
  }

  public Vector normalize() {
    return normalize(1.0);
  }

  public Vector normalize(float l) {
    float m = mag();
    if (m > 0.0) {
      return multiply(l / m);
    } else {
      return clone();
    }
  }
  
  public Vector cap(float l) {
    if (l <= 0.0) {
      return clone();
    } else {
      float m = mag();
      if (m > l) {
        return multiply(l / m);
      } else {
        return clone();
      }
    }
  }

}
