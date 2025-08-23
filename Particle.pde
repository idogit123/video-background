class Particle {
  PVector pos, vel, acc;
  float r;
  float speed, minSpeed = 0.05, maxSpeed = 0.8;
  float noiseOffset = 0, noiseStep = 0.01, noiseForceMultiplyer = 0.015;
  float forceFeildMultiplyer = 0.01;
  color c;
  float a;

  Particle() {
    acc = new PVector();
    vel = new PVector();
    pos = new PVector(
      random(0, width),
      random(0, height)
    );
    noiseOffset = random(1, 1000);
    r = 0;
    speed = random(minSpeed, maxSpeed);
    c = randomColor();
    a = 0;
  }
  
  void update() {
    PVector ff = forceFeild();
    PVector nf = noiseForce();
    acc.set(ff.x + nf.x, ff.y + nf.y);
    vel.add(acc);
    vel.limit(speed);
    pos.add(vel);
    
    noiseOffset += noiseStep;
  }
  
  void show() {
    // Only draw if visible and on screen
    if (a > 0 && r > 0 && !isOutOfBounds()) {
      fill(c, a);
      noStroke();
      circle(pos.x, pos.y, r);
    }
  }
  
  boolean isOutOfBounds() {
    if (
      pos.x - r > width ||
      pos.x + r < 0 ||
      pos.y - r > height ||
      pos.y + r < 0
    ) {
      return true;
    }
      
    return false;
  }
  
  PVector noiseForce() {
    float angle = noise(noiseOffset) * TWO_PI * 2;
    return PVector.fromAngle(angle).mult(noiseForceMultiplyer);
  }
  
  PVector forceFeild() {
    return ffp.getForce(pos).mult(forceFeildMultiplyer);
  }
  
  color randomColor() {
    boolean isBlue = random(1) > 0.4;
    if (isBlue) {
      return color(
        random(190, 255),
        random(210, 255),
        random(240, 255)
      );
    }
    else {
      return color(
        random(240, 255),
        random(235, 255),
        random(200, 255)
      );
    }
  }

  void reset() {
    pos.set(random(0, width), random(0, height));
    vel.set(0, 0);
    acc.set(0, 0);
    noiseOffset = random(1, 1000);
    r = 0;
    speed = random(minSpeed, maxSpeed);
    c = randomColor();
    a = 0;
  }
}
