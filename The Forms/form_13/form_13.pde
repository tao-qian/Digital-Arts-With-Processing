int sizeX;
int sizeY;

void setup()
{
  sizeX = 600;
  sizeY = 600;
  size(sizeX, sizeY);

  background(255);
  fill(164, 199, 57);
  strokeWeight(4);
  stroke(255);
  smooth();

  //body
  rect(sizeX/5, sizeY/5*2, sizeX/5*3, sizeY/5*2);

  //left arm
  quad(sizeX/5, sizeY/5*2, sizeX/5, sizeY/5*4, 0, sizeY, 0, sizeY/5*3);

  //right arm
  quad(sizeX/5*4, sizeY/5*2, sizeX/5*4, sizeY/5*4, sizeX, sizeY, sizeX, sizeY/5*3);

  //left foot
  triangle(sizeX/5, sizeY/5*4, sizeX/20*7, sizeY, sizeX/2, sizeY/5*4);

  //right foot
  triangle(sizeX/2, sizeY/5*4, sizeX/20*13, sizeY, sizeX/5*4, sizeY/5*4);

  //head
  triangle(sizeX/5, sizeY/5*2, sizeX/5*4, sizeY/5*2, sizeX/2, 0);

  //left antena
  triangle(sizeX/5, sizeY/15*2, sizeX/10*3, sizeY/15*4, sizeX/10*4, sizeY/15*2);
  triangle(sizeX/5*3, sizeY/15*2, sizeX/10*7, sizeY/15*4, sizeX/5*4, sizeY/15*2);
}

void draw()
{
   strokeWeight(10);
   stroke(255);
   line(sizeX/20*8,sizeY/5,sizeX/40*18,sizeY/5);
   line(sizeX/40*22,sizeY/5,sizeX/20*12,sizeY/5);
   stroke(164, 199, 57);
   line(sizeX/20*8+mouseX/20,sizeY/5,sizeX/20*8+mouseX/20+sizeX/40,sizeY/5);
   line(sizeX/20*12-(sizeX-mouseX)/20,sizeY/5,sizeX/20*12-(sizeX-mouseX)/20-sizeX/40,sizeY/5);
}

