// Modified from http://sweb.cityu.edu.hk/sm1204/2012A/page20/index.html

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;

void setup()
{
  size(500, 500);
  minim = new Minim(this);
  song = minim.loadFile("frankum_nebula.mp3");
  song.play();   
}

void draw()
{
  background(255);
  strokeWeight(3);
  
  float a = 0;
  float angle = (2*PI) / 200;
  int step = song.bufferSize() / 200;
  for(int i=0; i < song.bufferSize() - step; i+=step) {
    float x = 100 + cos(a) * (40 * song.mix.get(i) + 60);
    float y = 100 + sin(a) * (40 * song.mix.get(i) + 60);
    float x2 = 100 + cos(a + angle) * (40 * song.mix.get(i+step) + 60);
    float y2 = 100 + sin(a + angle) * (40 * song.mix.get(i+step) + 60);
    line(x+width/4,y+height/4,x2+width/4,y2+height/4);
    a += angle;
  }
}