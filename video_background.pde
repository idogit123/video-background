ParticleManager pm;
ForceFieldProvider ffp;
float time;
PImage fieldImg;
color bgColor = color(2, 5, 13);

void setup() {
  fullScreen();
  background(bgColor);
  frameRate(30);
  //fieldImg = loadImage("space2.png");
  //fieldImg.resize(width, height);
  pm = new ParticleManager(5000);
  ffp = new NoiseForceField(0.01, 0.001, color(120, 250, 35), bgColor);
}

void draw() {
  background(bgColor);
  ffp.update();

  pm.manage();
}
