/**
 * World
 * Author: Duncan Tilley
 *
 *     Represents the environment of the simulation.
 **/

import java.util.*;

class World {

    private HashMap<Integer, Boolean> _keys;
    private LinkedList<Follower> _followers;
    private LinkedList<Entity> _entities;
    private LinkedList<Obstacle> _obst;
    private Player _player;
    private Layout _layout;
    private boolean _targetEn;

    public World() {
        _keys = new HashMap<Integer, Boolean>();
        _followers = new LinkedList<Follower>();
        _entities = new LinkedList<Entity>();
        _obst = new LinkedList<Obstacle>();
        _targetEn = false;
    }

    public LinkedList<Follower> getFollowers() {
        return _followers;
    }

    public LinkedList<Obstacle> getObstacles() {
        return _obst;
    }
    
    public LinkedList<Entity> getEntities() {
        return _entities;
    }

    public void addFollower(float x, float y) {
        Follower follower = new Follower(this, x, y);
        _followers.add(follower);
        _entities.add(follower);
    }

    public void addObstacle(float x, float y) {
        _obst.add(new Obstacle(x, y));
    }

    public void createPlayer(float x, float y, int rows, int cols) {
        _player = new Player(this, x, y);
        _entities.add(_player);
        _layout = new Layout(this, _player, rows, cols);
    }

    public void targetEnabled(boolean e) {
        _targetEn = e;
    }

    public boolean targetEnabled() {
        return _targetEn;
    }

    public void update() {
        if (_player == null || _layout == null) {
            println("Error: call World.createPlayer() first");
        }
        _player.update();
        _layout.update();
        Vector[] targets = _layout.targets();
        Iterator it = _followers.iterator();
        int i = 0;
        while (it.hasNext()) {
            Vector target;
            if (_targetEn && i < targets.length) {
                target = targets[i++];
            } else {
                target = null;
            }
            ((Follower)it.next()).update(target, _player.dir());
        }
    }

    public void draw() {
        Iterator it = _followers.iterator();
        while (it.hasNext()) {
            ((Follower)it.next()).draw();
        }

        it = _obst.iterator();
        while (it.hasNext()) {
            ((Obstacle)it.next()).draw();
        }

        // _layout.draw();
        _player.draw();
    }

    public void keyPress(int k) {
        _keys.put(k, true);
    }

    public void keyRelease(int k) {
        _keys.put(k, false);
    }

    public boolean isKeyPressed(int k) {
        try {
            return _keys.get(k);
        } catch (Exception e) {
            return false;
        }
    }

}
