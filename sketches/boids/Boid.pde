/**
 * Boid
 * Author: Duncan Tilley
 *
 *     A single boid within the simulation.
 **/

import java.util.*;

class Boid {

  private static final float RAD = 100.0f;
  private static final float SPEED = 3.0f;
  private static final float DRAW = 20.0f / SPEED;
  private static final float C = 0.05f;
  private static final float A = 0.05f;
  private static final float S = 0.005f;
  private static final float G = 0.02f;
  private static final float OS = 0.02f;
  
  private World  _w;
  private Vector _pos;
  private Vector _vel;

  public Boid(World w, float x, float y) {
    _w = w;
    _pos = new Vector(x, y);
    _vel = new Vector((float)Math.random() - 0.5f, (float)Math.random() - 0.5f).normalize(SPEED);
  }

  // ACCESSORS

  public Vector pos() {
    return _pos;
  }

  public Vector vel() {
    return _vel;
  }

  // AUX

  public void update(int vw, int vh) {
    Vector avgPos = new Vector();
    Vector avgVel = new Vector();
    int numNbs = 0;
    
    // avoid obstacles
    LinkedList<Obstacle> obs = _w.getObstacles();
    Iterator it = obs.iterator();
    while (it.hasNext()) {
      Obstacle o = (Obstacle)it.next();
      float dist = _pos.distance(o.pos());
      if (dist <= RAD) {
        Vector separation = _pos.subtract(o.pos());
        float sepWeight = (RAD / separation.mag()) * OS;
        _vel = _vel.add(separation.normalize(SPEED).multiply(sepWeight));
      }
    }
    
    // move towards the goal
    if (_w.goalEnabled()) {
      Vector goal = _w.goal().subtract(_pos);
      _vel = _vel.add(goal.normalize(SPEED).multiply(G));
    }
    
    // find near boids
    LinkedList<Boid> all = _w.getBoids();
    it = all.iterator();
    while (it.hasNext()) {
      Boid b = (Boid)it.next();
      if (b == this) {
        continue;
      }
      float dist = _pos.distance(b.pos());
      if (dist <= RAD) {
        // add to the average velocity and position
        ++numNbs;
        avgPos = avgPos.add(b.pos());
        avgVel = avgVel.add(b.vel());
        // pull away from obstacles and other boids
        Vector separation = _pos.subtract(b.pos());
        float sepWeight = (RAD / separation.mag()) * S;
        _vel = _vel.add(separation.normalize(SPEED).multiply(sepWeight));
      }
    }

    if (numNbs > 0) {
      avgPos = avgPos.multiply(1.0 / numNbs);
      avgVel = avgVel.multiply(1.0 / numNbs);
      
      Vector cohesion = (avgPos.subtract(_pos));
      Vector alignment = avgVel;
      
      cohesion = cohesion.normalize(SPEED);
      alignment = alignment.normalize(SPEED);
      
      _vel = _vel.add(cohesion.multiply(C)).add(alignment.multiply(A));
    }
    
    _vel = _vel.normalize(SPEED);
    
    // wrap around
    _pos = _pos.add(_vel);
    if (_pos.x() > vw) {
      _pos.x(_pos.x() - vw);
    } else if (_pos.x() < 0) {
      _pos.x(_pos.x() + vw);
    }
    if (_pos.y() > vh) {
      _pos.y(_pos.y() - vh);
    } else if (_pos.y() < 0) {
      _pos.y(_pos.y() + vh);
    }
  }

  public void draw() {
    fill(139, 211, 120);
    pushMatrix();
    noStroke();
    ellipse(_pos.x(), _pos.y(), 15.0f, 15.0f);
    stroke(139, 211, 120);
    line(_pos.x(), _pos.y(), _pos.x() + _vel.x() * DRAW, _pos.y() + _vel.y() * DRAW);
    popMatrix();
  }

}
