PImage summer;
PImage winter;

Pixel[] myImage;

int indexX;  //variable for the width of the window
int indexY;  //height of the window
int indexM; // index of the mouse


void setup() {
  size(800, 600);
  background(255);
  summer = loadImage("summer.jpg");
  winter = loadImage("winter.jpg");

  indexX = summer.width;  
  indexY = summer.height;
  indexM = 100; //size of the square window
  
  //instantiate an array object which will act as the image seen on the screen
  //use all the pixel of the image using the x y axis
  myImage = new Pixel[indexX*indexY];
  for (int j=0; j < indexY; j++) {
    for (int i=0; i < indexX; i++) {
      myImage[j*indexX+i] = new Pixel(summer, i, j, indexM);
    }
  }
}

void draw() {

  loadPixels();
  //work with each pixel of the two images
  for (int i=0; i < indexX*indexY; i++) {
    myImage[i].display();

  }

  //save the image by pressing s
  if (key == 's' || key == 'S') {
    save("newImage.jpg");
  }
}