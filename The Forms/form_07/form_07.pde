void setup()
{
  size(200, 200);
  background(255);
}

void draw()
{
  noStroke();
  fill(50);
  background(255);
  float x = mouseX-100;
  float y = mouseY-100;
  float angle = atan(x/y);
  ellipse(100+50*sin(angle),100+50*cos(angle),10,10);
  ellipse(100+50*sin(angle),100-50*cos(angle),10,10);
  ellipse(100+50*sin(angle),100,(100+50*cos(angle))/7,(100+50*cos(angle))/7);
}

