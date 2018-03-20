class Fire extends Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float lifespan;
  PImage img;

  Fire(PVector l,PImage img_) {
    super(l);
    type=1;
    acc = new PVector(0,0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    vel = new PVector(vx,vy);
    pos = l.get();
    lifespan = 100.0;
    img = img_;
  }

  void run() {
    update();
    render();
  }

  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update position
  void update() {
    vel.add(acc);
    pos.add(vel);
    lifespan -= 1;
    acc.mult(0); // clear Acceleration
  }

  // Method to display
  void render() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, pos.x,pos.y);
  }

  // When the particle dies
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}