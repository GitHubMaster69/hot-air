class Bomb {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  float prevRotate;
  int origin;

  Bomb(float m, float x, float y, float xVel, float yVel, int o) {
    mass = m;
    size = m*16;
    location = new PVector(x, y);
    velocity = new PVector(xVel/20, -yVel/12);
    acceleration = new PVector(0, 0);
    origin = o;
  }




  void applyForce(PVector force) {
    PVector f = force;
    velocity.add(f);
  }


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.mult(0.99);
  }

  void display() {
    stroke(0);
    translate(location.x, location.y);
    rotate(radians(velocity.x+prevRotate));
    fill(224, 172, 105);
    rect(10, 0, 10, 2); // ignition coil draw
    fill(0);
    ellipse(0, 0, mass*4, mass*4); // bomb draw
    fill(240, 240, 240);
    ellipse(10, 3, 5, 5); //bomb shadow (white) draw
    fill(175);
    rotate(-radians(velocity.x+prevRotate));
    prevRotate += velocity.x;
    translate(-location.x, -location.y);
  }

  void checkEdges(int i) {
    if (location.x > width-size/2) {
      location.x = width-size/2;
      acceleration.x = 0;
      velocity.x *= -0.95;
    } else if (location.x < size/2) {
      velocity.x *= -0.95;
      location.x = size/2;
      acceleration.x = 0;
    }
    if (location.y > height-size/8) {
      bombs.remove(i);
      if (velocity.y > -3) {
        velocity.y = 0;
      }
    } else if (location.y < size/2) {
      velocity.y *= -0.95;
      location.y = size/2;
      acceleration.y = 0;
    }
  }

  void checkCollision(int i) {
    AirBalloons balloon = balloons.get(int((origin-1)*(-1)));
    AirBalloons balloon2 = balloons.get(origin);
    Target target = targets.get(0);
    if (location.x+(size/2) > balloon.location.x+60 && location.x-(size/2) < balloon.location.x+90 && location.y+(size/2) > balloon.location.y && location.y-(size/2) < balloon.location.y+280) {
      balloon.hp -= 10;
      if(balloon.hp < 1){
        balloon2.mapWins++;
        restart();
      }
      if(bombs.size() > 0){
      bombs.remove(i);
      removed = true;
      }
    } else if (location.x > target.location.x-target.size/2 && location.x < target.location.x+target.size/2 && location.y > target.location.y-target.size/2 && location.y < target.location.y+target.size/2) {
      bombs.remove(i);
      removed = true;
      balloon2.score++;
      if(balloon2.score >= 5){
        text("player " + (2-balloon2.ID) + " has won map 1", width/2, height/2);
        restart();
        restarted = true;
      }
      println("player " + (2-balloon2.ID) + " now has " + balloon2.score + " points");
      targets.remove(0);
      targets.add(new Target(random(100, width-100), int(random(100, height-100)), int(random(-10, 10)), int(random(-5, 5)), int(random(40, 80))));
    }
  }
}
