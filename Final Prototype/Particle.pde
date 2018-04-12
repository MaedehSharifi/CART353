class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  float mass = 1; // mass of each particle

  // Force Constant
  float G = 100;

  Particle(PVector l) {
    //applying a 0 acceleration 
    acceleration = new PVector(0, 0);
    //applying a random velocity
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.get();
    lifespan = 255.0;
  }

  //function to run each particle
  void run() {
    update();
    display();
  }

  //finding the acceleration of a particle with "mass" from the applied force
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acceleration.add(f);
  }

  // Calculate a force to push another particle away from this one
  PVector repel(Particle p) {
    PVector dir = PVector.sub(position, p.position);      // Calculate direction of force
    float d = dir.mag();                       // Distance between objects
    dir.normalize();                           // Normalize vector 
    d = constrain(d, 5, 100);                    // Keep distance within a reasonable range
    float force = -1 * G / (d * d);            // Repelling force is inversely proportional to distance
    dir.mult(force);                           // Get force vector --> magnitude * direction
    return dir;
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 10.0; //rate of deduction of the life of each particle
  }

  // Method to display particles
  void display() {

    stroke(255, 0, 0, 128);
    strokeWeight(10);
    noFill();

    for (int i = 0; i < maxfreq; i++)
    {
      //changing the color with respect to the amplitude and frequency
      stroke(255*fft.getBand(i)/maxband, i*255/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
      //create each round particle
      //producing the arc around the particles using the selected color 
      //the arc length depends on the frequency and amplitude
      arc(position.x, position.y, width*i/maxfreq/4, height*i/maxfreq/4, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    }
    //return to white
    stroke(255);
  }

  // Is the particle still useful?
  boolean isDead() {
    //if the lifespan value reaches 0, kill the particle
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}