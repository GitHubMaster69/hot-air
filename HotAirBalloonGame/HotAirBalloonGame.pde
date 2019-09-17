PImage[] images = new PImage[2];
ArrayList<AirBalloons> balloons = new ArrayList<AirBalloons>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
PVector gravity = new PVector(0, 0.1);

void setup() {
  fullScreen(1);
  frameRate(60);
  balloons.add(new AirBalloons(100, 100, 1));
  balloons.add(new AirBalloons(width-400, 100, 1));
  loadImages();
}

void draw() {
  background(150);
  balloonFunctions();
  bombFunctions();
}

void loadImages() {
  for (int i = 0; i < 2; i++) {
    images[i] = loadImage(str(i) + ".PNG");
  }
}

void balloonFunctions() {
  for (int i = 0; i < images.length; i++) {
    AirBalloons balloon = balloons.get(i);
    balloon.update();
    balloon.checkEdges();
    balloon.applyForce(gravity);
    balloon.drawAirBalloon();
    if (keyPressed){
      if(keyCode == UP) {
      balloon.acceleration.add(0, -0.4);
      println("zoom");
    } else if (keyCode == LEFT) {
      balloon.velocity.add(-0.1, 0);
      println("left");
    } else if (keyCode == RIGHT) {
      balloon.velocity.add(0.1, 0);
      println("right");
    } else if (key == ENTER) {
      balloon.cannonShot();
      println("enter");
    }
    }
  }
}

void bombFunctions() {
  if (bombs.size() > 0) {
    for (int i = 0; i < bombs.size(); i++) {
      Bomb bomb = bombs.get(i);
      bomb.applyForce(gravity);
      bomb.update();
      bomb.checkEdges();
      bomb.display();
    }
  }
}
