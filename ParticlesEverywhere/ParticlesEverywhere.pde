//instantiate particle system
ParticleSystem Sys;
ArrayList<Bucket> buckets;
//image background
PImage bg;

void setup() {
  size(640, 360, P2D);
  bg = loadImage("house.jpg");
  buckets = new ArrayList<Bucket>();
 
  //create 3 buckets on screen to collect the water
  Bucket r = new Bucket(380, 320);
  buckets.add(r);
  r = new Bucket(450, 320);
  buckets.add(r);
  r = new Bucket(520, 320);
  buckets.add(r);

  //create a particle system of fire
  PImage fire1 = loadImage("fire.png");
  PImage fire2 = loadImage("fire2.png");
  PImage fire3 = loadImage("fire3.png");
  ArrayList<PImage> firepic = new ArrayList<PImage>();
  firepic.add(fire1);
  firepic.add(fire2);
  firepic.add(fire3);
  Sys = new ParticleSystem(0, new PVector(width/4, height/3), firepic);
}

void draw() {
  background(bg);
  //smoke
  Particle p=Sys.addSmokeParticle();

  // for each bucket
  for (Bucket r : buckets) {
    //the bucket applies absorbtion on the rain
    Sys.applyBucket(r);
    r.display();
  }

  Sys.addWaterParticle(new PVector (380, 160));
  Sys.addWaterParticle(new PVector (450, 160));
  Sys.addWaterParticle(new PVector (520, 160));


  // Calculate a "wind" force based on mouse horizontal position
  float dx = map(mouseX, 0, width, -0.2, 0.2);
  PVector wind = new PVector(dx, 0);
  Sys.applyWindForce(wind);

  Sys.addFireParticle();

  Sys.run();
}