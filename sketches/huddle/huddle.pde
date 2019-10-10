/**
 * Huddle
 * Author: tilleyd
 *
 *     Uses boid-like logic to allow NPCs to form into a formation around the
 *     player.
 **/

// constants
final int ROWS = 3;
final int COLS = 5;

// variables
World world;
boolean msg = true;

void setup() {
    size(1280, 720, OPENGL);
    world = new World();
    world.createPlayer(640.0f, 360.0f, ROWS, COLS);
}

void draw() {
    background(33, 37, 43);
    world.update();
    world.draw();
    if (msg) {
        String welcome = "Huddle Simulation\n" +
                "    by Duncan Tilley\n" +
                "Move with WASD and the mouse\n" +
                "Left click to place a follower\n" +
                "Right click to activate the huddle\n" +
                "Middle click to place an obstacle";
        text(welcome, 10, 10);
    }
}

void mouseReleased() {
    if (mouseButton == LEFT) {
        world.addFollower(mouseX, mouseY);
    } else if (mouseButton == RIGHT) {
        world.targetEnabled(false);
    } else {
        world.addObstacle(mouseX, mouseY);
    }
    msg = false;
}

void mousePressed() {
    if (mouseButton == RIGHT) {
        world.targetEnabled(true);
        msg = false;
    }
}

void keyPressed() {
    world.keyPress(keyCode);
}

void keyReleased() {
    world.keyRelease(keyCode);
}
