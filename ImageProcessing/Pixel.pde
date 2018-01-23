class Pixel {
  int x;
  int y;

  color c;  // color
  int winSize;  // radius

  Pixel(PImage pic, int posX, int posY, int cellsize) {
    winSize = cellsize;
    x = posX;
    y = posY; 

    c = pic.get(int(x), int(y));  //
  }

  void display() {
    //noSmooth();
    color c2 = winter.get(int(x), int(y));  // i use the "get" function to access my second image's pixel values
    //if the left button of the mouse is pressed
    if (mousePressed && (mouseButton == LEFT)) {
      //if the pixel position is outside the square window
      if (x<(mouseX-winSize) || x>(mouseX+winSize) ||y<(mouseY-winSize) || y>(mouseY+winSize)) {
        //the winter image is shown
        fill(c2);
      } else {
        //the summer image is shown
        fill(c);
      }
      //if the right mouse button is pressed
    } else if ((mouseButton == RIGHT)) {
      //summer image is transparent in order to merge the two images together
      fill(c, 100);
      rect(x, y, 1, 1);
      //point(x,y);
      // change the transparency of the second image depeding on tFactor
      float tFactor = map(mouseX, 0, indexX, 0, 100);
      tFactor=100;
      fill(c2, tFactor);
    } else {
      //if the pixel is outside the square window
      if (x<(mouseX-winSize) || x>(mouseX+winSize) ||y<(mouseY-winSize) || y>(mouseY+winSize)) {
        //the summer image is displayed
        fill(c);
      } else {
        //the winter image is displayed
        fill(c2);
      }
    }
    rect(x, y, 1, 1);
    //point(x,y);
    noStroke();
  }
}