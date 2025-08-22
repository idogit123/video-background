class AnimationManager {
  ArrayList<ParticleAnimation> animations; 
  Particle p;
  float expldeChance = 0.00005, trailChance = 0.0005;
  
  AnimationManager(Particle p) {
    this.p = p;
    animations = new ArrayList<ParticleAnimation>();
    add(new FadeIn(p));
  }
  
  void add(ParticleAnimation a) {
    animations.add(a);
  }
  
  void manage() {
    for (int i=0; i<animations.size(); i++) {
      ParticleAnimation a = animations.get(i);
      a.animate();
      if (a.isDone()) {
        animations.remove(a);
        i--;
      }
    }
    
    if (random(1) < expldeChance)
      add(new Explode(p));
    if (p.vel.mag() > 0.788)
      add(new Trail(p));
  }
}
