
//3 different forces acting on meteor (rolling entity) 
PVector ground;
PVector antigravity;
PVector space; 

//set initial acceleration of the meteor
PVector acceleration = new PVector(0.0, 0.0);

//instantiate rock array
rock[] meteor= new rock[9];

PVector dir; //direction of meteor
float dist; //distance between meteor and rocks
float rocksize; //size of each rock
PImage bground; //background image

void setup() {
  size(600, 360);
  bground = loadImage("background.jpg");

  //describe rolling entity (meteor)
  //(float x, float y, float xv (xvelocity), float yv (yvelocity), float r (radius), float rotation, float w (omega), int num (number of , float m (mass))
  meteor[0] = new rock(40, 30, 1.0, 0.1, random(10, 30), (random (0, 360)), (random (10, 20))/100, 0, 100);

  //describe each element of the rock array
  for (int i=1; i<9; i++) {  
    rocksize = random(10, 30);
    meteor[i] = new rock(40+100*i, random(20, 360)-rocksize, 0, 0, rocksize, (random (0, 360)), (random (10, 20))/100, i, 0);

    //define the vectors of each force
    ground = new PVector(0, 0.5);
    antigravity = new PVector(0, -0.5);
    space = new PVector(0, 0.0001);
  }
}

void draw() {
  background(bground);

  //if the meteor is in the first zone (ground)
  if (meteor[0].location.x < 200) {
    //acceleration given by (F/m)
    meteor[0].applyForce(ground);
    //acceleration.set(0, f1/meteor[0].mass);

    //if the meteor is in the third zone (space)
  } else if (meteor[0].location.x > 400 ) {
    //acceleration.set(0, f3/meteor[0].mass* meteor[0].velocity.y/abs(meteor[0].velocity.y));
    meteor[0].applyForce(space);

    //if the meteor is in the second zone (antigravity)
  } else {
    //acceleration.set(0, f2/meteor[0].mass);
    meteor[0].applyForce(antigravity);
  }
  meteor[0].velocity.add(acceleration); //add acceleration to velocity
  meteor[0].location.add(meteor[0].velocity); //add velocity to location

  //// Set mouse location in x direction
  meteor[0].location.set(mouseX, meteor[0].location.y);


  acceleration.mult(0);

  //if the meteor reaches the left or right side of the screen, change direction of x velocity
  if ((meteor[0].location.x >= width-meteor[0].radius) || (meteor[0].location.x <= meteor[0].radius)) {
    meteor[0].velocity.set(meteor[0].velocity.x*-1, meteor[0].velocity.y);
  }
  //if the meteor reaches the top of bottom side of the screen, change direction of y velocity
  if ((meteor[0].location.y >= height-meteor[0].radius) || (meteor[0].location.y <= meteor[0].radius)) {
    meteor[0].velocity.set(meteor[0].velocity.x, meteor[0].velocity.y*-1);
  }
  //if the meteor reaches the top of the screen, set the location
  if (meteor[0].location.y > height-meteor[0].radius) {
    meteor[0].location.set(meteor[0].location.x, height-meteor[0].radius);
  }
  //if the meteor reaches the bottom of the screen, set the location
  if (meteor[0].location.y < meteor[0].radius) {
    meteor[0].location.set(meteor[0].location.x, meteor[0].radius);
  }
  //if the meteor reaches the right side of the screen, set the location
  if (meteor[0].location.x > width-meteor[0].radius) {
    meteor[0].location.set(width-meteor[0].radius, meteor[0].location.y);
  }
  //if the meteor reaches the left side of the screen, set the location
  if (meteor[0].location.x < meteor[0].radius) {
    meteor[0].location.set(meteor[0].radius, meteor[0].location.y);
  }

  for (int i=1; i<8; i++) {
    //if the meteor does not come into contact with another rock
    if (meteor[i].contact == false) {
      //direction vector of the meteor and compilation of rocks
      dir = PVector.sub(meteor[0].location, meteor[i].location);
      dist = dir.mag();
      //if the meteor comes near another rock
      if (dist < (meteor[0].radius + meteor[i].radius)) {
        meteor[i].contact = true;
        //set the location of the rock to the location of the meteor
        meteor[i].location.set(meteor[0].location.x, meteor[0].location.y);
        //set the direction of the meteor to the direction of the rock
        meteor[i].rotCenter.set(dir);
        //add mass of the rock to the mass of the meteor
        meteor[0].mass += meteor[i].mass;
      }
    }
  } 

  for ( int i=0; i<8; i++) {
    //if the meteor comes into contact with another rock
    if (meteor[i].contact == true) {
      //set the location of the rock to the location of the meteor
      meteor[i].location.set(meteor[0].location.x, meteor[0].location.y);
      //set the velocity of the rock to the velocity of the meteor
      meteor[i].velocity.set(meteor[0].velocity.x, meteor[0].velocity.y);
      //set the omega (speed of rotation) of the rock to the omega of the meteor
      meteor[i].omega = meteor[0].omega;
    }
    //rotation of each entity (meteor and rock)
    imageMode(CENTER);
    translate(meteor[i].location.x, meteor[i].location.y);
    rotate(meteor[i].rot);
    image(meteor[i].meteor, meteor[i].rotCenter.x, meteor[i].rotCenter.y, meteor[i].radius*2, meteor[i].radius*2);
    rotate(-1*meteor[i].rot);
    meteor[i].rot = meteor[i].rot + meteor[i].omega;
    translate(-1*meteor[i].location.x, -1*meteor[i].location.y);
  }
}