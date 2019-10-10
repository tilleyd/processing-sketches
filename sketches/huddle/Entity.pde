/**
* Entity
* Author: tilleyd
*
*     An entity with direction and position.
**/

import java.util.*;

float DIR_LENGTH = 20.0f;
float DAMPING_RATIO = 0.9f;

class Entity {

    protected World  _w;
    protected Vector _pos; // world position vector
    protected Vector _dir; // normal direction vector
    protected Vector _vel; // velocity vector

    public Entity(World w, float x, float y) {
        _w = w;
        _pos = new Vector(x, y);
        _dir = new Vector(0.0f, 1.0f);
        _vel = new Vector(0.0f, 0.0f);
    }

    // ACCESSORS

    public Vector pos() {
        return _pos;
    }

    public Vector dir() {
        return _dir;
    }

    public Vector vel() {
        return _vel;
    }

    // AUX

    public void update() {
        _pos = _pos.add(_vel);
        _vel = _vel.multiply(DAMPING_RATIO);
    }

    public void draw() {
        pushMatrix();
        line(_pos.x(), _pos.y(),
             _pos.x() + _dir.x() * DIR_LENGTH,
             _pos.y() + _dir.y() * DIR_LENGTH);
        noStroke();
        ellipse(_pos.x(), _pos.y(), 25.0f, 25.0f);
        popMatrix();
    }

}
