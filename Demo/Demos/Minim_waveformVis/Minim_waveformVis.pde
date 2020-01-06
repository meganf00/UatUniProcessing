import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
 
void setup()
{
  size(500, 500);
  minim = new Minim(this);
 
  // Load audio file from the data folder
  song = minim.loadFile("femaleSpeech.wav");
  song.play();
}
 
void draw()
{
  background(0);
  stroke(255);
  
  for(int i = 0; i < song.left.size() - 1; i++)
  {
    stroke(255);
    line(i, 50 + song.left.get(i)*40, i+1, 50 + song.left.get(i+1)*40); // 50 and 150 are the y-axis offset for placement of the waveform, 40 is the amplitude scaling factor - but magic numbers are bad coding practice!
    line(i, 150 + song.right.get(i)*40, i+1, 150 + song.right.get(i+1)*40);
 
    // Draw an ellipse that changes size and colour depending on the sound amplitude
    float amplitude = abs(song.left.get(i)*30);
    
    float m = map(amplitude, 0, 10, 0, 127); // Map colour from 0-10 (sound amplitude range for the file we're using) to colour range 0-255
    float s = map(amplitude, 0, 10, 128, 255);
    
    noStroke();
    fill(s, m, 128);
    ellipse(width/2, height/2, m, m);
    ellipse(width/2, height/2, amplitude, amplitude);
  }
}