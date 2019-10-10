/**
* Player
* Author: tilleyd
*
*     A movable and rotatable player.
**/

import java.util.*;

final float SPEED = 1.0f;

class Player extends Entity {

    boolean up, left, right, down;

    public Player(World w, float x, float y) {
        super(w, x, y);
    }

    // AUX

    @Override
    public void update() {
        _dir = new Vector(mouseX, mouseY).subtract(_pos).normalize();
        float change = 0.2f;
        if (_w.isKeyPressed(16)) { // shift
            change = 0.5f;
        }
        if (_w.isKeyPressed(65)) { // a
            _vel.x(_vel.x()-change);
        }
        if (_w.isKeyPressed(87)) { // w
            _vel.y(_vel.y()-change);
        }
        if (_w.isKeyPressed(83)) { // s
            _vel.y(_vel.y()+change);
        }
        if (_w.isKeyPressed(68)) { // d
            _vel.x(_vel.x()+change);
        }
        super.update();
    }

    @Override
    public void draw() {
        fill(120, 177, 211);
        stroke(120, 177, 211);
        super.draw();
    }

}
