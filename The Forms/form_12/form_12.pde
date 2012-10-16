int sizeX;
int sizeY;

void setup()
{
  sizeX = 500;
  sizeY = 500;
  
  
  size(sizeX,sizeY);
  background(164, 199, 57);  
  smooth();
  
  stroke(255);
  strokeWeight(20);
  //Right White Line
  line(0,0,sizeX/5,sizeY/3);
  line(sizeX/5,sizeY/3,sizeX/5,sizeY/3*2);
  line(sizeX/5,sizeY/3*2,0,sizeY);
  
  //Left White Line
  line(sizeX,0,sizeX/5*4,sizeY/3);
  line(sizeX/5*4,sizeY/3,sizeX/5*4,sizeY/3*2);
  line(sizeX/5*4,sizeY/3*2,sizeX,sizeY);
  
  //Line between body and legs
  line(sizeX/5*4,sizeY/3*2,sizeX/2,sizeY);
  line(sizeX/5,sizeY/3*2,sizeX/2,sizeY);
  
  //Line between head and body
  line(sizeX/5,sizeY/3,sizeX/5*4,sizeY/3);
  
  //Line between head and antena
  line(sizeX/5,sizeY/3,sizeX/2,0);
  line(sizeX/5*4,sizeY/3,sizeX/2,0);
  
  //Eye line
  strokeWeight(5);
  line(sizeX/20*7,sizeY/6,sizeX/20*13,sizeY/6);
}

void draw()
{ 
    strokeWeight(3);
   stroke(255);
   line(sizeX/20*8,sizeY/6,sizeX/20*12,sizeY/6);
   stroke(164, 199, 57);
   //line(sizeX/20*8,sizeY/6,sizeX/20*10,sizeY/6);
   //line(sizeX/20*10,sizeY/6,sizeX/20*12,sizeY/6);
   line(sizeX/20*8+mouseX/20,sizeY/6,sizeX/20*8+mouseX/20+sizeX/20,sizeY/6);
   line(sizeX/2+mouseX/20,sizeY/6,sizeX/2+mouseX/20+sizeX/20,sizeY/6);
}
