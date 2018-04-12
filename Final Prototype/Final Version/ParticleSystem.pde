class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle(PVector p) {
    particles.add(new Particle(p));
  }

  // A function to apply a force to all Particles
  void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }

  //applying the repel force amongst the particles
  void applyParticles() {
    // for every particle in this system
    for (Particle p: particles) {
      // loop through every (other) particle in this system
      for(Particle r: particles) {
        if(p != r) {
          // work out the repel force of THAT particle (r) on THIS one (p)
          PVector force = r.repel(p);        
          // apply r particle's repel force to p particle's acceleration
          p.applyForce(force);
        }
      }
    }
  }
    
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run(); //display particles
      
      //remove particle when lifespan reches 0
      if (p.isDead()) {
        //kill the particle
        particles.remove(i);
      }
    }
  }
  // add butterflies to the particle system
   void addStar() {
     //randomize their initial position
    particles.add(new Butterfly(new PVector(random(width),random(height))));
  }
}