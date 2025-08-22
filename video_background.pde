ParticleManager pm;
float time;
color bgColor = color(2, 5, 13);

void setup() {
  fullScreen();
  background(bgColor);
  frameRate(30);
  
  pm = new ParticleManager(100);
}

void draw() {
  background(bgColor);
  
  pm.manage();
}
