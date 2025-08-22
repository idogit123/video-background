ParticleManager pm;
float time;
PImage fieldImg;
color bgColor = color(2, 5, 13);

void setup() {
  fullScreen();
  background(bgColor);
  frameRate(60);
  fieldImg = loadImage("apple.jpeg");
  pm = new ParticleManager(3000);
}

void draw() {
  background(bgColor);
  
  pm.manage();
}
