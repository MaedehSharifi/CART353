class Rain extends Particle {

  float topspeed;

  Rain(PVector l) {
    super(l);
    topspeed = 2.0;
    type=4;
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    checkEdges();
  }

  //override Particle's display method
  void display() {
    stroke(127, lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(velocity.heading());
    //draw raindrop
    line(0, 0, 10, 0);
    popMatrix();
  }

  // checkEdges() wraps position horizontally + vertically
  void checkEdges() {

    if (position.x > width) {
      position.x = 0;
    } else if (position.x < 0) {
      position.x = width;
    }

    if (position.y > height) {
      position.y = 0;
    } else if (position.y < 0) {
      position.y = height;
    }
  }
}