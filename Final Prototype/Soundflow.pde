//import minim library
import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

//create object minim from Class Minim
Minim minim;
//create object song (the music which will be played) from class AudioPlayer
AudioPlayer song;
//fast fourier transform. Creates frequency domain of the song
FFT fft;
int maxfreq; // max frequency of the song
float maxband; //max amplitude of the song
ParticleSystem ps; //ps object from ParticleSystem Class
PImage img; //object imag

//create array to store the position of 8 butterflies
float[] yoff = {0, 0, 0, 0, 0, 0, 0, 0};
float[] xoff = {0, 0, 0, 0, 0, 0, 0, 0};
//current position of butterfly on screen
float x = 0;
float y= 0;
float time=0; //display the waves motions created with the amplitude of the song and perlin noise
int nomusic =0; //index of the song which will be played
//create butterflies array
Butterfly[] bs = new Butterfly[8];

void setup() {
  img = loadImage("butterfly3.png");
  ps = new ParticleSystem(new PVector(width/2, 50));
  size(800, 600);

  // start Minim first
  minim = new Minim(this);

  if (nomusic == 2) {
    nomusic = 0;
  }
  if (nomusic == 0) {
    // specify 512 for the length of the sample buffers
    song = minim.loadFile("music.wav", 512);
    song.play();
  } else if (nomusic==1) {
    song = minim.loadFile("hanami.wav", 512);
    song.play();
  }
  // The FFt needs to know the length of the audio buffer and the sample rate of the audio
  // It creates frequency domain from the song
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw() {
  //choose a song by pressing the mouse button
  if (mousePressed == true) {
    song.close();
    nomusic ++;
    //when the song changes, steup must be executed again
    setup();
  }

  // Perform a forward fft on the song's mix buffers
  fft.forward(song.mix);
  //find the maximum frequency of the song
  maxfreq=fft.specSize();

  //find the maximum amplitude of the song
  maxband=0;
  int band_maxf=0; //frequency of the max amplitude 

  //searching the frequency which has the maximum amplitude
  for (int i = 0; i < maxfreq; i++)
  {
    if (maxband<fft.getBand(i)) 
    {
      maxband=fft.getBand(i);
      band_maxf=i;
    }
  }

  //Reducing the frequency range to 4 times the frequency which has the max amplitude
  //cut off the high frequency sounds
  //In such a way, we can produces a better animation
  maxfreq=4*band_maxf;
  println(maxband);

  //adding round particles with respect to the frequency(with max amplitude). 
  //Higher frequencies produce a higher number of particles
  for (int i=0; i<(band_maxf/15)+1; i++)
    //randomize the particles position
    ps.addParticle(new PVector(random(width), random(height)));

  // Create acceleration force with respect to the amplitude and frequency of the sound
  //amplitude controls the acceleration in x direction and the frequency controls the acceleration in y direction
  PVector musicAcc = new PVector(maxband/30, band_maxf/10);
  ps.applyForce(musicAcc);

  //Background (grayscale) changes with amplitude of the song
  background(maxband*100);

  //x position of the waves
  x = 0 ;
  //create a wave form
  while (x< width) {
    //color of the waves changes with respect to the amplitude (contrary to the background)
    stroke(255-maxband*100);
    //display wave created by changing the y position and using perlin noise
    line(x, 300 +maxband*5 +50 *noise(x/100, time), x, height);
    x = x+1;
  }
  time= time + 0.02; //increment time to create motion in waves

  // Apply a repelling force to the particles
  ps.applyParticles();

  //choosing the position (path) of each butterfly
  for (int i = 0; i<8; i++) {
    //x position changes according to the amplitude and perlin noise
    xoff[i] = xoff[i] + .01 *i+maxband/300;
    x = noise(xoff[i]) * width;
    //y position changes according to the frequency and perlin noise
    yoff[i] = yoff[i] + .03*i+band_maxf/100 +0.02;
    y = noise(yoff[i]) * height;

    //use the position coordinates in the Pvector
    PVector v = new PVector((int)x, (int)y);
    //create butterflies [i] (from 0 to 7)
    bs[i] = new Butterfly(v);
    //apply the music Acceleration to the butterflies
    bs[i].applyForce(musicAcc);
    //display butterflies
    bs[i].run();
  }
  //dsplay particles
  ps.run();
}
