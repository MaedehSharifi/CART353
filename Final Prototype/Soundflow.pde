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
int maxfreq;
float maxband;
ParticleSystem ps;

void setup() {
  ps = new ParticleSystem(new PVector(width/2,50));
  size(800, 600);
 
  // always start Minim first!
  minim = new Minim(this);
 
  // specify 512 for the length of the sample buffers
  // the default buffer size is 1024
  song = minim.loadFile("music.wav", 512);
  song.play();
 
  // an FFT needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw() {
  //perform a forward fft on one of song's buffers
  fft.forward(song.mix);
   maxfreq=fft.specSize();
  maxband=0;
  int band_maxf=0;
  
  for(int i = 0; i < maxfreq; i++)
  {
    if (maxband<fft.getBand(i)) 
      {
        maxband=fft.getBand(i);
        band_maxf=i;
      }
  }
  maxfreq=4*band_maxf;
  background(255);
  for (int i=0;i<(band_maxf/15)+1;i++)
  ps.addParticle(new PVector(random(width),random(height)));
  
  // Apply gravity force to all Particles
  PVector gravity = new PVector(maxband/30,band_maxf/10);
  ps.applyForce(gravity);
  
  // Apply force from other particles
  ps.applyParticles();
  
  ps.run();
}
