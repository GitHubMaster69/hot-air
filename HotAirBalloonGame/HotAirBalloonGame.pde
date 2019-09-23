PImage[] images = new PImage[18];
ArrayList<AirBalloons> balloons = new ArrayList<AirBalloons>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Target> targets = new ArrayList<Target>();
ArrayList<Clouds> clouds = new ArrayList<Clouds>();
PVector gravity = new PVector(0, 0.05);
PVector bombGravity = new PVector(0, 1);
PVector[] balloonAccel = {new PVector(0, 0), new PVector(0, 0)};
boolean[] keys = new boolean[70];
boolean[] shoot = new boolean[2];
boolean[] done = new boolean[8];
boolean removed;
boolean restarted;
boolean bottomLethal = true;                //Testing option so you don't have to keep both afloat, could also be used for singleplayer.
boolean PvP = true;                         //Option to turn damaging each other off, such that the game instead is fully focused on getting the target.
int reloadtime = 0;


void setup() {
  //size(1500, 800);
  fullScreen(1);
  frameRate(60);
  loadImages();
  textSize(40);
  balloons.add(new AirBalloons(width-250, 100, 1));
  balloons.add(new AirBalloons(100, 100, 1));
  restart();
}

void draw() {
  background(#45bbd6);
  balloonFunctions();
  balloonAccel[1].x = 0; 
  balloonAccel[1].y = 0;
  bombFunctions();
  targetFunctions();
  cloudFunctions();
  balloonUI();
  if (restarted) {
    delay(2000);
    restarted = false;
  }
  if (keys[69] == true) {
    image(images[15], 375, 0);
  }
}

void loadImages() {
  for (int i = 0; i < 2; i++) {
    images[i] = loadImage(str(i) + ".PNG");
  }
  for (int i = 2; i < images.length; i++) {
    images[i] = loadImage(str(i) + ".png");
  }
}

void cloudFunctions() {
  for (int i = 0; i < clouds.size(); i++) {
    Clouds cloud = clouds.get(i);
    cloud.drawClouds(i);
  }
}

void balloonUI() {
  for (int i = 0; i < balloons.size(); i++) {
    AirBalloons balloon = balloons.get(i);
    balloon.drawUI();
  }
}

void balloonFunctions() {
  for (int i = 0; i < balloons.size(); i++) {
    AirBalloons balloon = balloons.get(i);
    balloon.update();
    balloon.checkEdges(i);
    balloon.applyForce(gravity);
    balloon.applyForce(balloonAccel[i]);
    balloonAccel[i].x = 0; 
    balloonAccel[i].y = 0;
    balloon.drawAirBalloon();
    if (shoot[i] && !done[1+(i*2)]) {
      balloon.cannonShot(balloon.ID);
      shoot[i] = false;
      done[1+(i*2)] = true;
    }
  }
}

void bombFunctions() {
  if (bombs.size() > 0) {
    for (int i = 0; i < bombs.size(); i++) {
      Bomb bomb = bombs.get(i);
      removed = false;
      bomb.applyForce(bombGravity);
      bomb.update();
      bomb.checkCollision(i);
      if (!removed) {
        bomb.checkEdges(i);
      }
      bomb.display();
    }
  }
}

void restart() {
  AirBalloons balloon1 = balloons.get(0);
  AirBalloons balloon2 = balloons.get(1);
  balloon1.location.x = width-250;
  balloon2.location.x = 100;
  balloon1.location.y = 100;
  balloon2.location.y = 100;
  balloon1.velocity = new PVector(0,0);
  balloon2.velocity = new PVector(0,0);
  balloon1.score = 0;
  balloon2.score = 0;
  balloon1.hp = 100;
  balloon2.hp = 100;
  targets.clear();
  clouds.clear();
  bombs.clear();
  targets.add(new Target(random(100, width-100), int(random(100, height-100)), int(random(-10, 10)), int(random(-5, 5)), int(random(40, 80))));
  for (int i = 0; i < 12; i++) {
    clouds.add(new Clouds(int(random(width/4, width*0.75)), int(random(50, height-50))));
  }
  if (frameCount > 100) {
    restarted = true;
  }
}

void targetFunctions() {
  if (targets.size() > 0) {
    for (int i = 0; i < targets.size(); i++) {
      Target target = targets.get(i);
      target.update();
      target.checkEdges(i);
      target.display();
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
  if (key == 'h') {
    keys[69] = true;
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
  if (key == 'h') {
    keys[69] = false;
  }
}
