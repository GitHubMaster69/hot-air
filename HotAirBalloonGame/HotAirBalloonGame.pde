PImage[] images = new PImage[2];
ArrayList<AirBalloons> balloons = new ArrayList<AirBalloons>();
PVector gravity = new PVector(0,0.1);

void setup(){
  frameRate(48);
  size(1400,800);
  balloons.add(new AirBalloons(100,100,1));
  balloons.add(new AirBalloons(600,100,1));
}

void draw(){
  background(150);
  loadImages();
  balloonFunctions();
}

void loadImages(){
  for(int i = 0; i < 2; i++){
    images[i] = loadImage(str(i) + ".PNG");
  }
}
  
  void balloonFunctions(){
    for(int i = 0; i < images.length; i++){
      AirBalloons balloon = balloons.get(i);
      balloon.update();
      balloon.applyForce(gravity);
      balloon.drawAirBalloon();
      if(keyPressed && keyCode == UP){
       balloon.acceleration.add(0,-0.4);
       println("zoom");
      } else if (keyCode == LEFT){
      balloon.velocity.add(-0.1,0);
      println("left");
    } else if (keyCode == RIGHT){
      balloon.velocity.add(0.1,0);
      println("right");
    }
    }
  }
