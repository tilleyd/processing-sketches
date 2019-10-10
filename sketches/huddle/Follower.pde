/**
 * Follower
 * Author: tilleyd
 *
 *     A follower that huddles around the player on demand.
 **/

import java.util.*;

class Follower extends Entity {

    private static final float RAD = 20.0f;
    private static final float SPEED = 5.0f;
    private static final float DRAW = 20.0f / SPEED;
    private static final float S = 0.2f;
    private static final float G = 0.5f;
    private static final float OS = 0.2f;

    public Follower(World w, float x, float y) {
        super(w, x, y);
    }

    // AUX

    public void update(Vector tVel, Vector tDir) {
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
                _vel = _vel.add(separation.limit(1.0f).multiply(sepWeight));
            }
        }

        // move towards the target
        if (tVel != null) {
            tVel = tVel.subtract(_pos);
            _vel = _vel.add(tVel.limit(1.0f).multiply(G));

            float dis = min(RAD, tVel.mag()) / RAD;
            _dir = _vel.multiply(dis).add(tDir.multiply(1.0f-dis)).multiply(0.5f).normalize();
        }


        // find near entities
        LinkedList<Follower> all = _w.getFollowers();
        it = all.iterator();
        while (it.hasNext()) {
            Follower b = (Follower)it.next();
            if (b == this) {
                continue;
            }
            float dist = _pos.distance(b.pos());
            if (dist <= RAD) {
                // pull away from obstacles and other boids
                Vector separation = _pos.subtract(b.pos());
                float sepWeight = (RAD / separation.mag()) * S;
                _vel = _vel.add(separation.limit(1.0f).multiply(sepWeight));
            }
        }

        _vel = _vel.limit(SPEED);

        super.update();
    }

    @Override
    public void draw() {
        fill(139, 211, 120);
        stroke(139, 211, 120);
        super.draw();
    }

}
