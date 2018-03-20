
class Bucket {
  
  // Gravitational Constant
  float G = 0;
  // position
  PVector position;
  float r = 48;
  PImage bucket;

  Bucket(float x, float y)  {
    position = new PVector(x,y);
  }

  void display() {
    stroke(0);
    strokeWeight(0);
    fill(128,0,0);
    rectMode(CENTER);
    //draw a bucket
    rect(position.x,position.y,r,r);
  }

  PVector absorb(Particle p) {
    PVector dir = PVector.sub(position, p.position);      // Calculate direction of force
    float d = dir.mag();                       // Distance between objects
    dir.normalize();                           // Normalize vector 
    d = constrain(d,5,100);                    // Keep distance within a reasonable range
    float force = -2 * G / (d * d);            // Repelling force is inversely proportional to distance
    dir.mult(force);          // Get force vector --> magnitude * direction
    if (d <= r) {
    p.lifespan = -1.0;
    }
    return dir;
  }  
}