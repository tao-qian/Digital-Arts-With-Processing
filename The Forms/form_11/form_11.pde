/*
Modifications:
Add a background music. 
Play rate is proportional to the speed at which the mouse moves.

The music's name is "Always with me", a song taken from the japanese movie spirited away.
The frequencies of different notes are taken from a Wikipedia page:http://en.wikipedia.org/wiki/Piano_key_frequencies.
*/

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

int sizeX;
int sizeY;

int armWidth;
int armLength;
int bodyWidth;
int bodyHeight;
int eyeRadius;


MusicPlayer m ;
int distance;
int lastX;
int lastY;

void setup()
{
  sizeX = 500;
  sizeY = 500;
  armWidth = sizeX/5;
  armLength = sizeY/2;
  bodyWidth = sizeX/5*3;
  bodyHeight = sizeY/5*2;
  eyeRadius = sizeX/25;

  distance = 0;
  lastX= 0;
  lastY = 0;
  //Music here
  int[] music = new int[] {
    1, 2, 3, 1, 5, 0, 3, 2, 5, 2, 0, 1, 6, 3, 0, 1, 7, 0, 1, 7, 6, 7, 1, 2, 0, 5, 1, 2, 3, 0, 4, 4, 3, 2, 1, 2, 0, 1, 2, 3, 1, 5, 0, 3, 2, 5, 2, 0, 1, 6, 6, 7, 1, 5, 0, 5, 6, 7, 1, 2, 5, 1, 2, 3, 4, 4, 3, 2, 1, 1, 0, 3, 4, 5, 5, 5, 0, 5, 5, 6, 5, 4, 0, 3, 3, 3, 0, 3, 3, 4, 3, 2, 1, 1, 0, 1, 7, 6, 7, 0, 7, 1, 2, 2, 3, 2, 3, 2, 0, 3, 4, 5, 5, 5, 0, 5, 5, 6, 5, 4, 0, 3, 3, 3, 3, 3, 4, 3, 2, 0, 1, 7, 6, 6, 7, 0, 1, 2, 5, 1, 2, 3, 4, 0, 3, 2, 1, 1
  };
  m = new MusicPlayer(music
    , new Minim(this));
  m.play();

  size(500, 500); 
  //noStroke();
  //smooth();
  fill(164, 199, 57);
}

void draw()
{
  background(255);

  //Body
  stroke(255);
  rect(sizeX/5, sizeY/5*2, bodyWidth, bodyHeight);

  //Head
  quad(sizeX/5, sizeY/5*2, sizeX/10*3, sizeY/5, sizeX/10*7, sizeY/5, sizeX/5*4, sizeY/5*2);

  //Antena
  triangle(sizeX/10*3, sizeY/5, sizeX/5*2, sizeY/10, sizeX/2, sizeY/5);
  triangle(sizeX/10*7, sizeY/5, sizeX/2, sizeY/5, sizeX/5*3, sizeY/10);

  //Eyes
  ellipse(sizeX/5*2, sizeY/10*3, 2*eyeRadius, 2*eyeRadius);
  ellipse(sizeX/5*3, sizeY/10*3, 2*eyeRadius, 2*eyeRadius);

  //Eye balls
  fill(255);
  if (dist(mouseX, mouseY, sizeX/5*2, sizeY/10*3)>2*eyeRadius)
  {
    pushMatrix();
    rotate(sizeX/5*2, sizeY/10*3, mouseX, mouseY);
    ellipse(eyeRadius/2, 0, eyeRadius, eyeRadius);
    popMatrix();
  }
  else
  {
    ellipse(sizeX/5*2, sizeY/10*3, eyeRadius, eyeRadius);
  }
  if (dist(mouseX, mouseY, sizeX/5*3, sizeY/10*3)>2*eyeRadius)
  {
    pushMatrix();
    rotate(sizeX/5*3, sizeY/10*3, mouseX, mouseY);
    ellipse(eyeRadius/2, 0, eyeRadius, eyeRadius);
    popMatrix();
  }
  else
  {
    ellipse(sizeX/5*3, sizeY/10*3, eyeRadius, eyeRadius);
  }
  fill(164, 199, 57);

  //Legs
  rect(sizeX/5, sizeY/5*4, sizeX/5, sizeY/5*4);
  rect(sizeX/5*3, sizeY/5*4, sizeX/5, sizeY/5*4);

  //Arms
  pushMatrix();
  rotate(sizeX/10, sizeY/2, mouseX, mouseY);
  translate(-sizeX/10, -sizeX/10);
  drawOval(armLength, armWidth);
  popMatrix();
  pushMatrix();
  rotate(sizeX/10*9, sizeY/2, mouseX, mouseY);
  translate(-sizeX/10, -sizeX/10);
  drawOval(armLength, armWidth);
  popMatrix();

  //Here is the music part.
  //We check the how far the mouse has moved in draw().
  //If it exceeds a limit, we play next note and 
  //reset the totoal distance to 0.
  //We did not use the dist() function here
  //because float point calculation is slow.
  //Useing the sum of horizontal and vertical differences
  //might be inaccurate, but is fast.
  distance += Math.abs(mouseX-lastX) + Math.abs(mouseY-lastY);
  if (distance > sizeX/3*2)
  {
    m.nextNote();
    distance = 0;
  }
  lastX = mouseX;
  lastY = mouseY;
}

void rotate(int positionX, int positionY, int directionX, int directionY)
{
  float angle = atan((float)(directionY-positionY)/(directionX-positionX));
  if ((directionX-positionX)<0)
    angle += PI;
  translate(positionX, positionY);
  rotate(angle);
}

//Draws a horizontal oval with white stroke around it.
//Change stroke to noStroke();
void drawOval(int totalWidth, int rectHeight)
{
  int rectWidth = totalWidth - rectHeight;
  stroke(255);
  strokeWeight(2);
  rect(rectHeight/2, 0, rectWidth, rectHeight);
  ellipse(rectHeight/2, rectHeight/2, rectHeight, rectHeight);
  ellipse(rectHeight/2+rectWidth, rectHeight/2, rectHeight, rectHeight);
  noStroke();
  rect(rectHeight/2, 0, rectWidth, rectHeight);
}

class MusicPlayer
{
  int musicPosition;//The current note played.It is the index in the music array.
  Minim minim;//The minim instance used. Cannot be initialized with in this class.
  AudioOutput audioOut;//Control sound output
  LowPassSP lowerPass;//Needed to manage the quality of sound
  SquareWave squareWave;//Control sound frequency(note)
  float[] notes ;//The standard notes
  int[] music;//An array of ints, each entey must be between 0 and 8(inclusive)


  MusicPlayer(int[] music, Minim minim)
  {
    musicPosition = -1;
    this.music = music;
    this.minim = minim;
    audioOut = minim.getLineOut() ;
    squareWave = new SquareWave(440, 1, 44100);
    lowerPass = new LowPassSP(200, 44100);
    audioOut.addEffect(lowerPass);

      notes = new float[9] ; // create the array to hold the note frequencies

    /*    //C Major
     notes[0] = 0//No sound
     notes[1] = 261.63 ;//C
     notes[2] = 293.67 ;//D
     notes[3] = 329.63 ;//E
     notes[4] = 349.23 ;//F
     notes[5] = 391.99 ;//G
     notes[6] = 440 ;//A
     notes[7] = 493.88 ;//B
     notes[8] = 523.25 ;//C
     */

    //F Major
    notes[0] = 0;//No sound
    notes[1] = 349.22 ;
    notes[2] = 391.99 ;
    notes[3] = 440.00 ;
    notes[4] = 466.16 ;
    notes[5] = 523.25 ;
    notes[6] = 293.66 ;
    notes[7] = 329.62;
    notes[8] = 698.45 ;
  }

  //Start playing
  void play()
  {
    audioOut.addSignal(squareWave);
  }

  //Stop playing
  void stop()
  {
    audioOut.removeSignal(squareWave);
  }

  //Move to the next note
  void nextNote()
  {
    musicPosition++;
    musicPosition = musicPosition%music.length;
    squareWave.setFreq(notes[music[musicPosition]]);
  }
}


