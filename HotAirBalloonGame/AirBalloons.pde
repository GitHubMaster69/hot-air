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
  
  void drawAirBalloon(){
    translate(location.x,location.y);
    image(images[number],0,0);
    translate(-location.x,-location.y);
  }


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0.5);
  }
  
    void applyForce(PVector force) {
    PVector f = force;
    acceleration.add(f);
  }
}
