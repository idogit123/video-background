class ParticleManager {
  AnimationManager animationManager;
  Particle[] particles; 
  float explodeChance = 0.005, trailSpeed = 0.78;
  
  ParticleManager(int particleAmount) {
    particles = new Particle[particleAmount];
    animationManager = new AnimationManager();
    for (int i=0; i < particleAmount; i++) {
      particles[i] = new Particle(); 
      animationManager.add(new FadeIn(particles[i]));
    }
  }
  
  void manage() {
    float rnd = random(1);
    if (rnd < explodeChance) {
      int idx = (int)(rnd * particles.length);
      animationManager.add(new Explode(particles[idx]));
    }

    for (int i=0; i < particles.length; i++) {
      particles[i].show();
      particles[i].update();
      if (particles[i].isOutOfBounds()) {
        particles[i].reset();
      }
      else if (particles[i].vel.mag() > trailSpeed) {
        animationManager.add(new Trail(particles[i]));
      }
    }
    animationManager.manage();
  }
  
  void remove(Particle p) {
    for (int i=0; i < particles.length; i++) {
      if (particles[i] == p)
        particles[i].reset();
    }
  }
}
