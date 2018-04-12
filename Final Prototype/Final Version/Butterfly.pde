//The butterfly Class is a child of the Particle class
class Butterfly extends Particle {

  Butterfly(PVector l) {
    super(l);
    //applying a default constant acceleration 
    acceleration = new PVector(0, 0.05, 0);
    //applying a random velocity
    velocity = new PVector(random(-1, 1), random(-1, 0), 0);
    velocity.mult(2);
  }

  void run() {
    update();
    render();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 20.0; //different rate of deduction of life for each butterfly particle
  }
  //applying a different acceleration to the butterflies (with respect to its father class "Particle")
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f.mult(100));
  }

  // Method to display
  void render() {
    imageMode(CENTER);


    if (maxband < 3) {

      // set a random color
      float r = 0;
      float g = 0;
      float b = 255;
      color c = color(r, g, b);
      tint(c, lifespan);
      image(img, position.x, position.y);
    } 
    if (maxband > 7) {
      float r = 255;
      float g = 255;
      float b = 0;
      color c = color(r, g, b);
      tint(c, lifespan);
      image(img, position.x, position.y);
    } if (maxband > 3 & maxband < 7) {
      float r = 255;
      float g = 0;
      float b = 0;
      color c = color(r, g, b);
      tint(c, lifespan);
      image(img, position.x, position.y);
    }


    // tint our image that color
  }

  // Is the Butterfly still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}