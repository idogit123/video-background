ParticleManager pm;
float time;
PImage fieldImg;
color bgColor = color(2, 5, 13);

void setup() {
  fullScreen();
  background(bgColor);
  frameRate(30);
  fieldImg = loadImage("space2.png");
  fieldImg.resize(width, height);
  pm = new ParticleManager(5000);
}

void draw() {
  set(0, 0, fieldImg);
  
  pm.manage();
}
