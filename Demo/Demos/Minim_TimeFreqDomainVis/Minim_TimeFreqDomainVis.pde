import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
//AudioInput song;
FFT fft;
 
void setup()
{
  size(500, 500);
  minim = new Minim(this);
 
  // Load audio data from file in the data folder
  song = minim.loadFile("femaleSpeech.wav"); // Can set buffer length to screen length for waveform display etc.
  song.play();
  
  // Load live audio input
  //song = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
    
  fft = new FFT(song.bufferSize(), song.sampleRate()); // Default buffer side is 1024 
}
 
void draw()
{
  background(0);
  fft.forward(song.mix);
 
  // Draw the frequency spectrum as a series of vertical lines
  // Frequency amplitude is multiplied by a factor of 3 for visibility
  stroke(0, 0, 255, 128); // (R, G, B, opacity)
  for(int i = 0; i < fft.specSize(); i++)
  {
    line(i, height, i, height - fft.getBand(i)*3); //line(x1, y1, (z1), x2, y2, (z2))
  }
 
  stroke(255);
  for(int i = 0; i < song.left.size() - 1; i++)
  {
    line(i, 50 + song.left.get(i)*30, i+1, 50 + song.left.get(i+1)*30); // 50 and 150 are the y-axis offset for placement of the waveform
    line(i, 150 + song.right.get(i)*30, i+1, 150 + song.right.get(i+1)*30);
  }
}