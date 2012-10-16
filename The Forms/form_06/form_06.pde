void setup(){
  
size(200, 200);
background(255);
}
void draw()
{
  background(255);
  int x = mouseX;
  int y = mouseY;
  size(400, 400);
  strokeWeight(mouseX%10 + mouseY%5);
  line(x, 200-x, y, 200-y);
  line(200-y, y, 200-x, x);
}

