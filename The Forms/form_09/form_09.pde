void setup() {
  size(200, 200);
  noStroke();
  background(255);
}

void draw()
{
  background(255);
  
  fill(mouseX);
  beginShape();
  vertex(mouseX, 80);
  vertex(mouseX, 120);
  vertex(mouseX/1.5,160);
  vertex(mouseX/3,160);
    vertex(0,120);
  vertex(0, 80);
  vertex(mouseX/3,40);
  vertex(mouseX/1.5,40);
  endShape(CLOSE);

  fill(255-mouseX);
  beginShape();
  vertex(mouseX/1.5,40);
  vertex(mouseX, 80);
  vertex(mouseX, 120);
  vertex(mouseX/1.5,160);
  vertex(200-mouseX/3,160);
    vertex (200 - mouseX/4,180);
    vertex(200,120);
  vertex(200, 80);
  vertex (200 - mouseX/4,20);
   vertex(200-mouseX/3,40);
  endShape(CLOSE);
}

