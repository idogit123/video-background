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
  
  Explode(Particle p) {
    super(p, random(40, 100));
    targetLength = random(10, 20);
    targetColor = randomColor();
  }
  
  void animate() {
    strokeWeight(2);
    stroke(targetColor);
    float currentLength = map(time, 0, duration, 0, targetLength);
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
  int current;
  
  Trail(Particle p) {
    super(p, random(50, 200));
    alpha = random(200, 255);
    c = randomColor();
    trail = new PVector[50];
    current = 0;
  }
  
  void animate() {
    addTrail();
    alpha = map(time, 0, duration, alpha, 0);
    
    for (int i=0; i<current; i++) {
      PVector pos = trail[i];
      fill(c, alpha);
      noStroke();
      circle(pos.x, pos.y, map(i, 0, current, 1, p.r));
    }
    
    time++;
  }
  
  void addTrail() {
    if (current < trail.length) {
      trail[current] = p.pos.copy();
      current++;
    }
    else {
      for (int i=trail.length-1; i>0; i--) {
        trail[i] = trail[i-1];
      }
      trail[0] = p.pos.copy();
    }
  }
  
  boolean isDone() {
    return time >= duration || p.vel.mag() < 0.7; 
  }
  
  color randomColor() {
    return color(
      random(120, 255),
      random(240, 255),
      random(160, 255)
    );
  }
}
