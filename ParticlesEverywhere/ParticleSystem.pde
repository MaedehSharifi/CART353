
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int type;
    PImage img;
  ArrayList<PImage> fire;
  int fireCounter;

  ParticleSystem(int num, PVector v, ArrayList<PImage> f) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    fire = f;
    fireCounter = 0;
    for (int i = 0; i < num; i++) {
      
      // get an origin point for a new particle
      PVector o = gaussianOrigin();
      particles.add(new Fire(o, fire.get(fireCounter % fire.size())));   
      // increment fireCounter so we get a different img next cycle
      fireCounter++;
    }
  }
 

  void addFireParticle() {

    // get an origin point for a new particle
    PVector o = gaussianOrigin();
    // notice our crafty use of modulo to determine which fire image to get
    particles.add(new Fire(o, fire.get(fireCounter % fire.size())));        
    fireCounter++;
  }

  // set a spawn origin point roughly around the original origin
  PVector gaussianOrigin() {
    float x = origin.x;
    float y = origin.y;

    float newX = randomGaussian() * 20 + width/4;
    float newY = randomGaussian() * 3 + 5*height/6;

    PVector p = new PVector(newX, newY);
    return p;
  }

  ParticleSystem(PVector position) {
    origin = position.get();
    particles = new ArrayList<Particle>();
    type=0;
  }

  Particle addSmokeParticle() {
 
    Particle p=new Particle(new PVector(230, 100));
    particles.add(p);
    return p;
  }
  
  void addParticle() {

    particles.add(new Particle(new PVector(width/2, height/2)));
  }

  // A function to apply a force to all Particles (except fire)
  void applyForce(PVector f) {
    for (Particle p : particles) {
      if ( p.type!=1) p.applyForce(f);
    }
  }

  // A function to apply a Wind force to Fire and Smoke Particles
  void applyWindForce(PVector f) {
    for (Particle p : particles) {
      if (p.type==0 || p.type==1) p.applyForce(f);
    }
  }

  void applyBucket(Bucket r) {
    // for each particle in this system
    for (Particle p : particles) {
      // work out the absorb force of the bucket
      PVector force = r.absorb(p);        
      // apply that force to the particle
      p.applyForce(force);
    }
  }

  // An equal probablity of any type of Rain Particle being added
  void addWaterParticle(PVector P) {
    particles.add(new Rain(P));

  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
