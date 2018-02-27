class rock {
  PVector location;
  PVector velocity;
  float xvelocity;
  float yvelocity;
  float radius;
  float rot; //angle of rotation
  float omega; //speed of rotation
  PImage meteor;
  PVector rotCenter;
  boolean contact;
  float mass;

  rock(float x, float y, float xv, float yv, float r, float rotation, float w, int num, float m) {
    mass =m;
    xvelocity = xv;
    yvelocity = yv;
    radius = r;
    rot = rotation;
    omega = w;
    location = new PVector(x, y);
    velocity = new PVector(xvelocity, yvelocity);
    rotCenter = new PVector(0, 0);
    contact = false;
    
    //describe each image in the elements of the rock array
    switch(num) {
    case 0: 
      meteor = loadImage("rock.png");
      break;
    case 1: 
      meteor = loadImage("rock2.png");
      break;
    case 2: 
      meteor = loadImage("rock3.png");
      break;
    case 3: 
      meteor = loadImage("rock4.png");
      break;
    case 4: 
      meteor = loadImage("rock4.png");
      break;
    case 5: 
      meteor = loadImage("rock5.png");
      break;
    case 6: 
      meteor = loadImage("rock6.png");
      break;
    case 7: 
      meteor = loadImage("rock7.png");
      break;
    case 8: 
      meteor = loadImage("rock8.png");
      break;
    case 9: 
      meteor = loadImage("rock9.png");
      break;
    }
  }
}