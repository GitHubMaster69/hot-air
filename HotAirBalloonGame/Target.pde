class Target {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;

  Target(float x, float y, float xVel, float yVel, int s) {
    size = s;
    location = new PVector(width/2, y);
    velocity = new PVector(xVel, -yVel);
  }

  void update() {
    velocity.x *= speedMult;
    location.add(velocity);
    velocity.x *= (1/speedMult);
  }

  void display() {
    fill(200, 50, 50);
    ellipse(location.x, location.y, size, size);
  }

  void checkEdges(int i) {
    if (location.x > width-size/2) {
      location.x = width-size/2;
      velocity.x *= -1;
    } else if (location.x < size/2) {
      velocity.x *= -1;
      location.x = size/2;
    }
    if (location.y > height-size/2) {
      velocity.y *= -1;
      location.y = height-size/2;
    } else if (location.y < size/2) {
      velocity.y *= -1;
      location.y = size/2;
    }
  }
}
