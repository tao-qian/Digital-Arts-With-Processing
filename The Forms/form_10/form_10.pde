void setup()
{
  size(200,200);
}

void draw()
{
  background(255);
  int x= mouseX-100;
  int y = mouseY-100;
  strokeWeight((x*x+y*y)/2000+1);
  bezier(0,100,mouseX,mouseY,200-mouseX,200-mouseY,200,100);
}


