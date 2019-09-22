class Clouds{
 
  PImage cloud1;
  PImage cloud2;
  PImage cloud3;
  PImage cloud4;
  
  void setup(){
   cloud1 = loadImage("cloud1.png");
   cloud2 = loadImage("cloud2.png");
   cloud3 = loadImage("cloud3.png");
   cloud4 = loadImage("cloud4.png");
  }
  
  void draw(){
    image(cloud1,random(1,1000),random(1,1000));
    image(cloud2,random(1,1000),random(1,1000));
    image(cloud3,random(1,1000),random(1,1000));
    image(cloud4,random(1,1000),random(1,1000));
  }
}
