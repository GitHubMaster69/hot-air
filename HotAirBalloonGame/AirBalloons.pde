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
<<<<<<< Updated upstream
  
  void drawAirBalloon(){
    translate(location.x,location.y);
    image(images[number],0,0);
    translate(-location.x,-location.y);
=======

  void drawAirBalloon() {
    translate(location.x, location.y);
    images[number].resize(int(600*0.5),int(800*0.5));
    image(images[number], 0, 0);
    translate(-location.x, -location.y);
>>>>>>> Stashed changes
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
  bombs.add(new Bomb(3,180.0+location.x,height-138.0,mouseX-100, -mouseY+540));
  }
}
