/**
 * Flag
 * Author: Duncan Tilley
 *
 *     Represents the collection of particles that form a flag.
 **/

class Flag {
  
  private static final float SCALE   = 200.0f; // pixels per meter
  private static final float GRAVITY = 9.8f * SCALE * 0.3f;
  private static final float MAXVEL  = SCALE;
  private static final float SPRING  = 1000.0f;
  private static final float DAMPING = 0.4f;
  private static final float SPEED   = 1.0f;

  private Particle[][] _parts;
  private long _timestep;
  private float _xdist, _ydist;

  public Flag(float x, float y, float z, int w, int h, int resw, int resh) {
    _parts = new Particle[resh + 1][resw + 1];
    _xdist = w / (float)resw;
    _ydist = h / (float)resh;
    for (int r = 0; r <= resh; ++r) {
      for (int c = 0; c <= resw; ++c) {
        _parts[r][c] = new Particle(x + c * _xdist, y + r * _ydist, z + (float)(Math.random() - 0.5f) * 5.0f);
      }
    }
    _parts[0][0].fixed(true);
    _parts[resh][0].fixed(true);
    _timestep = -1;
  }

  public Particle[][] getParticles() {
    return _parts;
  }

  public void update() {
    // calculate time (in sec) since last update
    if (_timestep == -1) {
      _timestep = System.nanoTime();
    }
    long now = System.nanoTime();
    float period = (now - _timestep) / 1.0e9;
    _timestep = now;
    // update the particles
    for (int r = 0; r < _parts.length; ++r) {
      for (int c = 0; c < _parts[r].length; ++c) {
        Particle p = _parts[r][c];
        updateParticle(r, c, period);
      }
    }
  }

  private void updateParticle(int r, int c, float period) {
    period *= SPEED;
    Particle p = _parts[r][c];
    // calculate spring forces between neighbours
    // only check right and bottom and update both particles
    if (c < _parts[r].length - 1) {
      Particle n = _parts[r][c + 1];
      Vector diff = n.pos().subtract(p.pos());
      float dist = diff.mag();
      float distDiff = (dist - _xdist);
      Vector force = diff.normalize().multiply(SPRING * distDiff * distDiff * distDiff);
      p.vel(p.vel().add(force.multiply(period)));
      n.vel(n.vel().add(force.multiply(-period)));
    }
    if (r < _parts.length - 1) {
      Particle n = _parts[r + 1][c];
      Vector diff = n.pos().subtract(p.pos());
      float dist = diff.mag();
      float distDiff = (dist - _ydist);
      Vector force = diff.normalize().multiply(SPRING * distDiff * distDiff * distDiff);
      p.vel(p.vel().add(force.multiply(period)));
      n.vel(n.vel().add(force.multiply(-period)));
    }
    // add gravity acceleration
    p.vel().y(p.vel().y() + GRAVITY);
    // update position with damping
    p.vel(p.vel().add(p.vel().multiply(-DAMPING)));
    p.vel(p.vel().cap(MAXVEL));
    if (!p.fixed()) {
      p.pos(p.pos().add(p.vel().multiply(period)));
    }
  }

  public void draw() {
    // draw particle vertices
    //stroke(107, 62, 62);
    noStroke();
    fill(209, 91, 91);
    for (int r = 0; r < _parts.length - 1; ++r) {
      for (int c = 0; c < _parts[r].length - 1; ++c) {
        beginShape();
        vertex(_parts[r][c].pos().x(), _parts[r][c].pos().y(), _parts[r][c].pos().z());
        vertex(_parts[r][c + 1].pos().x(), _parts[r][c + 1].pos().y(), _parts[r][c + 1].pos().z());
        vertex(_parts[r + 1][c + 1].pos().x(), _parts[r + 1][c + 1].pos().y(), _parts[r + 1][c + 1].pos().z());
        vertex(_parts[r + 1][c].pos().x(), _parts[r + 1][c].pos().y(), _parts[r + 1][c].pos().z());
        vertex(_parts[r][c].pos().x(), _parts[r][c].pos().y(), _parts[r][c].pos().z());
        endShape();
      }
    }
  }

}
