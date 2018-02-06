import processing.video.*;
import java.util.*; 

float zoff;
float cell;
//2D array for height coordinates
float[][] heights;
//Capture class built in video processing library
Capture video;

int numCols;
int numRows;

//Random class built in processing
Random generator;

void setup() {

  size(640, 480, P3D); //3D display
  zoff = 1000.0;
  cell = 150;
  numCols = 4;
  numRows = 4;
  //instantiate new capture
  video = new Capture(this, width, height);
  video.start();

  // this array lets us store (x, y, z) values: i and j will let us determine x and y, while the stored val is z
  heights = new float[numCols][numRows];
  //instantiate new Random object
  generator = new Random();
}

void captureEvent(Capture c) {
  video.read();
}

// calculateHeights() is based on i, j, and a changing value of zoff
void calculateHeights() {

  for (int i = 0; i < numCols; i++) {
    for (int j = 0; j < numRows; j++) {

      // assign z a perlin noise val based on a mapping of i, a mapping of j, and zoff
      float z = noise(map(i, 0, numCols, 0, 1), map(j, 0, numRows, 0, 1), zoff);

      // in heights[i][j], store a new height: a mapped version of z that will vary between -100 and 100
      heights[i][j] = map(z, 0, 1, -100, 100);
    }
  }

  // change zoff for next time we call draw()
  zoff += 0.01;
}

void draw() {
  background(100);

  // fill our heights array with a new set of z vals
  calculateHeights();

  video.loadPixels();

  // change the perspective on our cell grid so we can see the heights better
  pushMatrix();
  translate(100, 0, -100);
  rotateX(PI/8);

  for (int i = 0; i < (numCols-1); i++) { 
    for (int j = 0; j < (numRows-1); j++) { 

      noStroke();

      // grab the color from our pixel array
      // i + j*width
  
      int multiplier = width/numCols;

      int loc = (numCols - i*multiplier - 1) + j*multiplier * numCols;
      loc = constrain(loc, 0, video.pixels.length-1);
      color c = video.pixels[loc];
      //multiply the pixel with nextGaussian in order to randomize the color displayed 
      float r = red(video.pixels[loc]) * (float) generator.nextGaussian();
      float g = green(video.pixels[loc]) * (float) generator.nextGaussian();
      float b = blue(video.pixels[loc]) * (float) generator.nextGaussian();
      fill(r,g,b);

      pushMatrix();
      // translate our point of origin for drawing: jump to where each cell starts
      translate(i * cell, j * cell, 0);

      // we have to use quads rather than rect: this will allow us
      // to define 4 vertices in 3D space (i.e. we can work the notion of 
      // variable height in this way)
      beginShape(QUADS);

      // now specify 4 vertices, each a point in 3D space, drawing from our heights array
      vertex(0, 0, heights[i][j]);
      vertex(cell, 0, heights[i+1][j]);
      vertex(cell, cell, heights[i+1][j+1]);
      vertex(0, cell, heights[i][j+1]);
      endShape();

      // popMatrix so that we can reset the origin for our next quad
      popMatrix();
    }
  }
  popMatrix();
}