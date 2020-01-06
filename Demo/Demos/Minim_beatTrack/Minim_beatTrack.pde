import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

float ellipseBeatRadius = 100;
float ellipseNoBeatRadius = 20;

void setup()
{
  size(500, 500);
  minim = new Minim(this);
  
  // Live audio input
  //song = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
  
  // Read audio in from file
  song = minim.loadFile("frankum_nebula.mp3"); // Can set buffer length to screen length for waveform display etc.
  song.play(); 
  
  // Create a beat detection object based on the sound energy
  beat = new BeatDetect();
  
}

void draw()
{
  background(0);
  beat.detect(song.mix);

  fill(60, 255, 0, 64);
  ellipse(width/2, height/2, ellipseNoBeatRadius, ellipseNoBeatRadius);
  if ( beat.isOnset() ) 
  {
    fill(60, 255, 0, 128);
    ellipse(width/2, height/2, ellipseBeatRadius, ellipseBeatRadius);
  }
}