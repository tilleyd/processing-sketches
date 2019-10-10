/**
* Layout
* Author: tilleyd
*
*     Controls the target locations for huddling.
**/

import java.util.*;

float SEP = 50.0f;

class Layout {

    private World  _w;
    private Player _p;

    private Vector[] _offsets;
    private Vector[] _targets;

    public Layout(World w, Player p, int rows, int cols) {
        _w = w;
        _p = p;
        _offsets = new Vector[rows*cols - 1];
        _targets = new Vector[rows*cols - 1];
        int playerR = 0;
        int playerC = cols / 2;
        int i = 0;
        float offY = -playerR * SEP;
        for (int r = 0; r < rows; ++r) {
            float offX = -playerC * SEP;
            for (int c = 0; c < cols; ++c) {
                if (r != playerR || c != playerC) {
                    _offsets[i] = new Vector(offX, offY);
                    _targets[i] = new Vector();
                    ++i;
                }
                offX += SEP;
            }
            offY += SEP;
        }
    }

    // ACCESSORS

    public Vector[] targets() {
        return _targets;
    }

    // AUX

    public void update() {
        // calculate new target positions
        float pX = _p.pos().x();
        float pY = _p.pos().y();
        float dX = _p.dir().x();
        float dY = _p.dir().y();
        float angle = atan2(dY, dX) + HALF_PI;
        for (int i = 0; i < _targets.length; ++i) {
            // player + rotated offset
            Vector t = _targets[i];
            Vector o = _offsets[i];
            float cs = cos(angle);
            float sn = sin(angle);
            t.x(pX + (cs*o.x() - sn*o.y()));
            t.y(pY + (sn*o.x() + cs*o.y()));
        }
    }

    public void draw() {
        pushMatrix();
        noFill();
        stroke(255, 255, 255);
        for (int i = 0; i < _targets.length; ++i) {
            Vector t = _targets[i];
            ellipse(t.x(), t.y(), 5.0f, 5.0f);
        }
        popMatrix();
    }

}
