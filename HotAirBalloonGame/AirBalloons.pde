class AirBalloons {

  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);
  int speedMult;
  int number;
  int shotsMax = 5;
  int shotsLeft = 5;
  int hp = 100;

  AirBalloons(int x, int y, int s) { 
    location = new PVector(x, y);
    speedMult = s;
    number = balloons.size();
  }
    void drawAirBalloon() {
    translate(location.x, location.y);
    images[number].resize(int(600*0.4), int(800*0.4));
    image(images[number], 0, 0);
    images[5].resize(int(600*0.4), int(800*0.4));
    image(images[5], 0, 0);
    println(acceleration.y);
    if ((0 > acceleration.y) && (acceleration.y < 0.15)){
      images[6].resize(int(600*0.4), int(800*0.4));
      image(images[6], 0, 0);
    }
      else if((0.15 > acceleration.y) && (acceleration.y < 200)){
      images[7].resize(int(600*0.4), int(800*0.4));
      image(images[7], 0, 0);
    }
    
    translate(-location.x, -location.y);
  }  


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0.7);
    if (keys[0+(number*3)] == true && !done[0+(number*2)]) {
      acceleration.y += -0.01*hp;
      done[0+(number*2)] = true;
    }
    if (keys[1+(number*3)] == true) {
      acceleration.x += -0.1;
    }
    if (keys[2+(number*3)] == true) {
      acceleration.x += 0.1;
    }
  }

  void applyForce(PVector force) {
    PVector f = force;
    acceleration.add(f);
  }

  void cannonShot(int i) {
    //Bomb bomb = bombs.get((number-1)*(-1));
    bombs.add(new Bomb(6, 180.0+location.x, location.y+150, 450*((number-0.5)*2), 200,i));
  }

  void checkEdges() {
    if (location.x > width-250) {
      location.x = width-250;
      acceleration.x = 0;
      velocity.x *= 0;
    } else if (location.x < -50) {
      velocity.x *= 0;
      location.x = -50;
      acceleration.x = 0;
    }
    if (location.y > height-250) {
      velocity.y *= 0;
      location.y = height-250;
      if (velocity.y > -3) {
        velocity.y = 0;
      }
    } else if (location.y < 0) {
      velocity.y *= 0;
      location.y = 0;
      acceleration.y = 0;
    }
  }
}
