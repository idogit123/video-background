class ParticleManager {
  Particle[] particles; 
  
  ParticleManager(int particleAmount) {
    particles = new Particle[particleAmount];
    
    for (int i=0; i < particleAmount; i++) {
      particles[i] = new Particle(); 
    }
  }
  
  void manage() {
    for (int i=0; i < particles.length; i++) {
      particles[i].show();
      particles[i].update();
      if (particles[i].isOutOfBounds())
        particles[i] = new Particle();
    } 
  }
  
  void remove(Particle p) {
    for (int i=0; i < particles.length; i++) {
      if (particles[i] == p)
        particles[i] = new Particle();
    } 
  }
}
