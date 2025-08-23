interface ForceFieldProvider {

  PVector getForce(PVector pos);

  void show();
  
  void update();

}

class NoiseForceField implements ForceFieldProvider {
  float noiseScale;
  color bright, dark;
  float time, timeStep;

  NoiseForceField(float noiseScale, float timeStep, color bright, color dark) {
    this.noiseScale = noiseScale;
    this.bright = bright;
    this.dark = dark;
    this.timeStep = timeStep;
    time = 0;
  }

  PVector getForce(PVector pos) {
    PVector feildPos = PVector.mult(pos, noiseScale);
    float angle = noise(feildPos.x, feildPos.y, time) * TWO_PI * 2;
    return PVector.fromAngle(angle);
  }

  void show() {
    loadPixels();
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            float n = noise(x * noiseScale, y * noiseScale, time); // noise value between 0 and 1
            float r = map(n, 0, 1, red(dark), red(bright));
            float g = map(n, 0, 1, green(dark), green(bright));
            float b = map(n, 0, 1, blue(dark), blue(bright));
            pixels[x + y * width] = color(r, g, b);
        }
    }
    updatePixels();
  }
  
  void update() {
    time += timeStep; 
  }
}

class ImageForceField implements ForceFieldProvider {
  PImage img;

  ImageForceField(PImage img) {
    this.img = img;
  }

  PVector getForce(PVector pos) {
    int x = int(pos.x);
    int y = int(pos.y);
    float brightness = 0.5;
    if (x >= 0 && x < img.width && y >= 0 && y < img.height) {
      color c = img.get(x, y);
      brightness = brightness(c) / 255.0;
    }
    float angle = brightness * TWO_PI * 2;
    return PVector.fromAngle(angle);
  }

  void show() {
    set(0, 0, img);
  }
  
  void update() {
    
  }
}
