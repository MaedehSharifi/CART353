
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int type=0;
  
  float mass = 1; 

  Particle(PVector l) {
    acceleration = new PVector(0,0.5);
    velocity = new PVector(random(-1,1),random(-2,0));
    position = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }
  void display() {
    //draw the smoke
    stroke(0,lifespan);
    strokeWeight(0);
    fill(80,lifespan);
    ellipse(position.x+5,position.y+5,15,15);
    fill(150,lifespan);
    ellipse(position.x+5,position.y-5,15,15);
    fill(180,lifespan);
    ellipse(position.x-5,position.y+5,15,15);
    strokeWeight(2);
  }


  // When the particle dies
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}