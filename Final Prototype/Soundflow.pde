import processing.video.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
FFT fft;
 
void setup()
{
  size(800, 600);
 
  // always start Minim first!
  minim = new Minim(this);
 
  // specify 512 for the length of the sample buffers
  // the default buffer size is 1024
  song = minim.loadFile("music.mp3", 512);
  song.play();
 
  // an FFT needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
  fft = new FFT(song.bufferSize(), song.sampleRate());
}
 
void draw()
{
  background(0);
  // first perform a forward fft on one of song's buffers
  // I'm using the mix buffer
  //  but you can use any one you like
  fft.forward(song.mix);
 
  stroke(255, 0, 0, 128);
  strokeWeight(10);
  noFill();
  // draw the spectrum as a series of vertical lines
  // I multiple the value of getBand by 4 
  // so that we can see the lines better
  int maxfreq=fft.specSize();
  int maxband=0;
  
  for(int i = 0; i < maxfreq; i++)
  {
    if (maxband<fft.getBand(i)) maxband=(int)fft.getBand(i);
  }
  int max_x=song.left.size();
  for(int i = 0; i < maxfreq; i++)
  {
 ///   for(int j = 0; j < max_x - 1; j++)
 /// {
    stroke(255*fft.getBand(i)/maxband, i*255/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
    arc(width/8, height/2 + song.left.get(max_x/8)*height/2, width*i/maxfreq, height*i/maxfreq, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    stroke(155*fft.getBand(i)/maxband, i*155/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
    arc(width/8*3, height/2 + song.left.get(max_x/8*3)*height/2, width*i/maxfreq, height*i/maxfreq, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    stroke(55*fft.getBand(i)/maxband, i*55/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
    arc(width/8*5, height/2 + song.left.get(max_x/8*5)*height/2, width*i/maxfreq, height*i/maxfreq, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    stroke(205*fft.getBand(i)/maxband, i*205/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
    arc(width/8*7, height/2 + song.left.get(max_x/8*7)*height/2, width*i/maxfreq, height*i/maxfreq, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    //arc(width/4, height/4, width*i/maxfreq, height*i/maxfreq, PI/2, 2*PI*fft.getBand(i)/maxband, OPEN);
    //arc(0, 0, width*i/maxfreq, height*i/maxfreq, PI/2, 2*PI*fft.getBand(i)/maxband, OPEN);
    //arc(width/1.2, height/1.2, width*i/maxfreq, height*i/maxfreq, PI/2, 2*PI*fft.getBand(i)/maxband, OPEN);
 /// }
//    if (i<=maxfreq/2){
    //line(2*width*i/maxfreq, height, 2*width*i/maxfreq, height - fft.getBand(i)*4);
    //line(width*i/maxfreq, height, width*i/maxfreq, height*(1 - fft.getBand(i)/maxband));
 //   }
 //   else {
 //   line(2*width*i/maxfreq-width, 0, 2*width*i/maxfreq-width, 0 + fft.getBand(i)*4);
 //   }
  }
 
  stroke(255);
  // I draw the waveform by connecting 
  // neighbor values with a line. I multiply 
  // each of the values by 50 
  // because the values in the buffers are normalized
  // this means that they have values between -1 and 1. 
  // If we don't scale them up our waveform 
  // will look more or less like a straight line.
 /// for(int i = 0; i < song.left.size() - 1; i++)
 /// {
    //line(i, 50 + song.left.get(i)*50, i+1, 50 + song.left.get(i+1)*50);
    //line(i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50);
 /// }
  
}