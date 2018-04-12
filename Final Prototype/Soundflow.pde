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
  float maxband=0;
  int band_maxf=0;

  for (int i = 0; i < maxfreq; i++)
  {
    if (maxband<fft.getBand(i)) 
    {
      maxband=fft.getBand(i);
      band_maxf=i;
    }
  }
  maxfreq=4*band_maxf;
  //println(maxband, maxfreq);
  int max_x=song.left.size();
  int max_p=band_maxf+2;// nb of particle
  int rangeOfParticle=width/max_p;
  float maxband_p=0; //for a given particle
  for (int j = 0; j < max_p; j++)
  {
    maxband_p=0;
    for (int i = j*maxfreq/max_p; i < (j+1)*maxfreq/max_p; i++) // Find average band for a given particle
    {
      maxband_p+=fft.getBand(i)/(maxfreq/max_p);
      //if (maxband_p<fft.getBand(i)) maxband_p=fft.getBand(i);
    }
    for (int i = j*maxfreq/max_p; i < (j+1)*maxfreq/max_p; i++)
    {
      //println(max_p,maxband_p,maxband, max_x);
      stroke(255*fft.getBand(i)/maxband, i*255/maxfreq, 255*(1 - fft.getBand(i)/maxband), 128);
      arc(width/(2*max_p)+j*rangeOfParticle+maxband_p/maxband*width/10, height/max_p+j*height/max_p + song.left.get(max_x/8)*height/2, width*i/maxfreq, height*i/maxfreq, PI/2 -2*PI*fft.getBand(i)/maxband, 2*PI*fft.getBand(i)/maxband, OPEN);
    }
  }

  stroke(255);
}
