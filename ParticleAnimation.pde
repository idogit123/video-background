abstract class ParticleAnimation {
  Particle p;
  float time, duration;
  
  ParticleAnimation(Particle p, float duration) {
    this.p = p;
    this.duration = duration;
    this.time = 0;
  }
  
  boolean isDone() {
    return time >= duration; 
  }
  
  abstract void animate();
}

class FadeIn extends ParticleAnimation {
  float targetA, targetR;
  
  FadeIn(Particle p) {
    super(p, random(50, 1000));
    this.targetA = random(200, 255);
    this.targetR = random(1, 8);
  }
  
  void animate() {
    p.a = map(time, 0, duration, 0, targetA);
    p.r = map(time, 0, duration, 0, targetR);
    time++;
  }
}

class Explode extends ParticleAnimation {
  float targetLength;
  color targetColor;
  float growDuration = 0.95;
  
  Explode(Particle p) {
    super(p, random(100, 500));
    targetLength = random(10, 20);
    targetColor = randomColor();
  }
  
  void animate() {
    strokeWeight(2);
    stroke(targetColor);
    float currentLength;
    if (time < duration * growDuration)
      currentLength = map(time, 0, duration * growDuration, 0, targetLength);
    else
      currentLength = map(time, duration * growDuration, duration , targetLength, 0);
    line(p.pos.x, p.pos.y, p.pos.x, p.pos.y + currentLength);
    line(p.pos.x, p.pos.y, p.pos.x, p.pos.y - currentLength);
    line(p.pos.x, p.pos.y, p.pos.x + currentLength, p.pos.y);
    line(p.pos.x, p.pos.y, p.pos.x - currentLength, p.pos.y);
    time++;
  }
  
  boolean isDone() {
    if (time >= duration) {
      pm.remove(p);
      return true;
    }
    return false;
  }
  
  color randomColor() {
    return color(
      random(240, 255),
      random(160, 255),
      random(120, 255)
    );
  }
}

class Trail extends ParticleAnimation {
  float alpha;
  color c;
  PVector[] trail;
  int trailSize = 100;
  int head = 0;
  int count = 0;
  float minSpeed = 0.7;
  
  Trail(Particle p) {
    super(p, random(200, 4000));
    alpha = random(200, 255);
    c = randomColor();
    trail = new PVector[trailSize];
    head = 0;
    count = 0;
  }
  
  void animate() {
    addTrail();
    alpha = map(time, 0, duration, alpha, 0);
    for (int i = 0; i < count; i++) {
      int idx = (head - 1 - i + trailSize) % trailSize;
      PVector pos = trail[idx];
      // Only draw if visible and on screen
      if (pos != null && alpha > 0 && p.r > 0 && pos.x + p.r > 0 && pos.x - p.r < width && pos.y + p.r > 0 && pos.y - p.r < height) {
        fill(c, alpha);
        noStroke();
        circle(pos.x, pos.y, map(i, 0, count, p.r, 1));
      }
    }
    if (p.vel.mag() < minSpeed)
      duration *= 0.5;
    time++;
  }
  
  void addTrail() {
    trail[head] = p.pos.copy();
    head = (head + 1) % trailSize;
    if (count < trailSize) count++;
  }
  
  boolean isDone() {
    return time >= duration; 
  }
  
  color randomColor() {
    return color(
      random(120, 255),
      random(240, 255),
      random(160, 255)
    );
  }
}
