class AnimationManager {
  ArrayList<ParticleAnimation> animations;
  
  AnimationManager() {
    animations = new ArrayList<ParticleAnimation>();
  }
  
  void add(ParticleAnimation a) {
    // Prevent duplicate animation types for the same particle
    for (ParticleAnimation existing : animations) {
      if (existing.getClass() == a.getClass() && existing.p == a.p) {
        return;
      }
    }
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
  }
}
