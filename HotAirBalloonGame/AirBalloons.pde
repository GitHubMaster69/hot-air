class AirBalloons {
  
  PVector location;
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  int speedMult;
  int number;
  int shotsMax = 5;
  int shotsLeft = 5;
  
  AirBalloons(int x, int y, int s){ 
    location = new PVector(x,y);
    speedMult = s;
    number = balloons.size();
  }
  void drawAirBalloon() {
    translate(location.x, location.y);
    images[number].resize(int(600*0.5),int(800*0.5));
    image(images[number], 0, 0);
    translate(-location.x, -location.y);
  }


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0.7);
  }
  
    void applyForce(PVector force) {
    PVector f = force;
    acceleration.add(f);
  }
  
  void cannonShot(){
  bombs.add(new Bomb(6,180.0+location.x,height-138.0,mouseX-100, -mouseY+540));
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
    if (location.y > height-350) {
      velocity.y *= 0;
      location.y = height-350;
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
