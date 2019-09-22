class Clouds {

  PVector location;
  int type; 

  Clouds(int x, int y) {
    location = new PVector(x, y);
    type = int(random(1, 4));
  }

  void drawClouds(int i) {
    //images[i+8].resize();
    imageMode(CENTER);
    image(images[type+8], location.x, location.y);
    imageMode(CORNER);
  }
}
