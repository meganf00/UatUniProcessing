// Modified from https://erichizdepski.wordpress.com/2016/01/15/music-visualization-with-processing/

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput player;
//AudioPlayer player;
FFT fft;

void setup()
{
  size(1000, 500);
  minim = new Minim(this);

  player = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
  //player = minim.loadFile("frankum_nebula.mp3"); // Can set buffer length to screen length for waveform display etc.
  //player.play();

  // Setup the FFT object
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

// Variables to store the real and imaginary components of each frequency band obtained from the FFT
float[] real;
float[] img;

void draw()
{
  background(255); // reset the display window
  stroke(200, 100, 0, 70); //rgba format
  strokeWeight(3); // Thicker

  //perform a forward fft on a buffer of audio (left, right or L/R mix)
  fft.forward(player.mix); // left/right mix buffer 
  real = fft.getSpectrumReal();
  img = fft.getSpectrumImaginary();

  //use for centering the rendering in the window
  //int xOffset = (width - fft.specSize())/2;
  int xOffset = fft.specSize()/4;

  //get the number of frequency bands and draw each one
  for (int i = 0; i < fft.specSize(); i++)
  {
    //line API is for point to point drawing using these coordniates:
    //x1, y1, x2, y2
    stroke(real[i] * 50, img[i] * 50, fft.getBand(i)*7, 170); // 50 are multiplier factors
    
    //use polar coordinates
    //can use real(x) and imaginary(y) data for this
    line (i + xOffset, height/2, i + xOffset + real[i] * 25, height/2 + img[i] * 25); // 25 are multiplier factors
  }
}