/**
 * World
 * Author: Duncan Tilley
 *
 *     Represents the environment of the simulation.
 **/

import java.util.*;

class World {

  private LinkedList<Boid> _boids;
  private LinkedList<Obstacle> _obst;
  private boolean _goalEn;
  private Vector  _goal;

  public World() {
    _boids = new LinkedList<Boid>();
    _obst = new LinkedList<Obstacle>();
    _goal = new Vector();
    _goalEn = false;
  }

  public LinkedList<Boid> getBoids() {
    return _boids;
  }
  
  public LinkedList<Obstacle> getObstacles() {
    return _obst;
  }
  
  public Vector getGoal() {
    return _goal;
  }
  
  public void addBoid(float x, float y) {
    _boids.add(new Boid(this, x, y));
  }
  
  public void addObstacle(float x, float y) {
    _obst.add(new Obstacle(x, y));
  }
  
  public Vector goal() {
    return _goal;
  }
  
  public void goal(float x, float y) {
    _goal.x(x);
    _goal.y(y);
  }
  
  public void goalEnabled(boolean e) {
    _goalEn = e;
  }
  
  public boolean goalEnabled() {
    return _goalEn;
  }

  public void update(int vw, int vh) {
    Iterator it = _boids.iterator();
    while (it.hasNext()) {
      ((Boid)it.next()).update(vw, vh);
    }
  }

  public void draw() {    
    Iterator it = _boids.iterator();
    while (it.hasNext()) {
      ((Boid)it.next()).draw();
    }
    
    if (_goalEn) {
      fill(80, 111, 222);
      noStroke();
      ellipse(_goal.x(), _goal.y(), 15.0f, 15.0f);
    }
    
    it = _obst.iterator();
    while (it.hasNext()) {
      ((Obstacle)it.next()).draw();
    }
  }

}
