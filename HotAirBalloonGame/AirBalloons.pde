public class AirBalloons {

  PVector location;
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);
  int ID;
  int hp = 100;
  int score = 0;
  int mapWins = 0;

  int lastFired;

  AirBalloons(int x, int y, int s) { 
    location = new PVector(x, y);
    ID = balloons.size();
  }
  void drawAirBalloon() {
    translate(location.x, location.y);
    images[12+ID].resize(int(500*0.10), int(500*0.10));
    image(images[12+ID], 25+(50*ID), 120);
    images[ID].resize(int(600*0.25), int(800*0.25));
    image(images[ID], 0, 0);
    images[5].resize(int(600*0.25), int(800*0.25));
    image(images[5], 0, 0);
    fill(0, hp, 0);
    rect(25, -20, max(hp, 0), 10);    //powerthingy OwO
    images[14].resize(int(100*0.25), int(100*0.25));
    image(images[14], -8, -27);
    if ((0 > acceleration.y) && (acceleration.y < 0.15)) {
      images[6].resize(int(600*0.25), int(800*0.25));
      image(images[6], 0, 0);
    } else if ((0.15 > acceleration.y) && (acceleration.y < 200)) {
      images[7].resize(int(600*0.25), int(800*0.25));
      image(images[7], 0, 0);
    }

    translate(-location.x, -location.y);
  } 
 
 void drawUI(){
   fill(0);
   text("Player" + (ID+1) + " Score: " + score + "/5",80+(((width/1.5)*((ID-1)*(-1)))),50);
   text("Player" + (ID+1) + " Mapwins: " + mapWins,80+(((width/1.5)*((ID-1)*(-1)))),100);
 }


  void update() {
    velocity.add(acceleration);
    velocity.x *= speedMult;
    location.add(velocity);
    velocity.x *= (1/speedMult);
    velocity.mult(0.99);
    acceleration.mult(0.7);
    if (keys[0+(ID*3)] == true && !done[0+(ID*2)]) {
      acceleration.y += -0.01*hp*pumpPower;
      done[0+(ID*2)] = true;
    }
    if (keys[1+(ID*3)] == true) {
      acceleration.x += -0.1;
    }
    if (keys[2+(ID*3)] == true) {
      acceleration.x += 0.1;
    }
  }

  void applyForce(PVector force) {
    PVector f = force;
    acceleration.add(f);
  }

  void cannonShot(int i) {
    if((millis()-lastFired) > 600){
    bombs.add(new Bomb(6, location.x+45+(65*ID), location.y+155, 300*((ID-0.5)*2), 200, i));
    lastFired = millis();
    }
  }

  void checkEdges(int i) {
    if (location.x > width-123) {
      location.x = width-123;
      acceleration.x = 0;
      velocity.x *= 0;
    } else if (location.x < -28) {
      velocity.x *= 0;
      location.x = -28;
      acceleration.x = 0;
    }
    if (location.y > height-175) {
      velocity.y *= 0;
      location.y = height-175;
      AirBalloons balloon = balloons.get(i);
      AirBalloons balloon2 = balloons.get(int((i-1)*(-1)));
      if(bottomLethal == true){
      balloon2.mapWins++;
      restart(str(balloon2.ID), "Falling");
      }
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
