class Smoke extends Particle {

Smoke(PVector l) {
    super(l);
    type=5;
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-2,0));
    lifespan = 500;
  }
}