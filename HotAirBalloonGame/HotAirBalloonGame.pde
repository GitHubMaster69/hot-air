PImage[] images = new PImage[8];
ArrayList<AirBalloons> balloons = new ArrayList<AirBalloons>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
PVector gravity = new PVector(0, 0.05);
PVector bombGravity = new PVector(0, 1);
PVector[] balloonAccel = {new PVector(0, 0), new PVector(0, 0)};
boolean[] keys = new boolean[6];
boolean[] shoot = new boolean[2];
boolean[] done = new boolean[8];


void setup() {
  size(1500,800);
  //fullScreen(1);
  frameRate(144);
  balloons.add(new AirBalloons(width-400, 100, 1));
  balloons.add(new AirBalloons(100, 100, 1));
  loadImages();
}

void draw() {
  background(#45bbd6);
  balloonFunctions();
  balloonAccel[1].x = 0; 
  balloonAccel[1].y = 0;
  bombFunctions();
  text(((1000*frameCount)/millis()), 100, 100);
}

void loadImages() {
  for (int i = 0; i < 2; i++) {
    images[i] = loadImage(str(i) + ".png");
  }
  for (int i = 2; i < images.length; i++) {
    images[i] = loadImage(str(i) + ".png");
  }
}


void balloonFunctions() {
  for (int i = 0; i < balloons.size(); i++) {
    AirBalloons balloon = balloons.get(i);
    balloon.update();
    balloon.checkEdges();
    balloon.applyForce(gravity);
    balloon.applyForce(balloonAccel[i]);
    balloonAccel[i].x = 0; 
    balloonAccel[i].y = 0;
    balloon.drawAirBalloon();
    if (shoot[i] && !done[1+(i*2)]) {
      balloon.cannonShot();
      shoot[i] = false;
      done[1+(i*2)] = true;
    }
  }
}

void bombFunctions() {
  if (bombs.size() > 0) {
    for (int i = 0; i < bombs.size(); i++) {
      Bomb bomb = bombs.get(i);
      bomb.applyForce(bombGravity);
      bomb.update();
      bomb.checkEdges(i);
      bomb.display();
    }
  }
}


void keyPressed() {
  if (keyCode == UP) {
    keys[0] = true;
  }
  if (keyCode == LEFT) {
    keys[1] = true;
  } 
  if (keyCode == RIGHT) {
    keys[2] = true;
  } 
  if (key == ENTER) {
    shoot[0] = true;
  }
  if (key == 'w') {
    keys[3] = true;
  }
  if (key == 'a') {
    keys[4] = true;
  }
  if (key == 'd') {
    keys[5] = true;
  }
  if (key == 'q') {
    shoot[1] = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    keys[0] = false;
    done[0] = false;
  }
  if (keyCode == LEFT) {
    keys[1] = false;
  } 
  if (keyCode == RIGHT) {
    keys[2] = false;
  } 
  if (key == ENTER) {
    shoot[0] = false;
    done[1] = false;
  }
  if (key == 'w') {
    keys[3] = false;
    done[2] = false;
  }
  if (key == 'a') {
    keys[4] = false;
  }
  if (key == 'd') {
    keys[5] = false;
  }
  if (key == 'q') {
    shoot[1] = false;
    done[3] = false;
  }
}
