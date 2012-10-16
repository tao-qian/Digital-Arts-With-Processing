/*
Used to display shake image, basically rotates the image at regular intervals.

 Author: Tao Qian
 */
class ShakeImage
{
  int framePerShake;
  int currentFrame;

  int maxShake;
  int currentShake;
  int[] shakes;

  float maxDegree;

  PImage pic;
  int picWidth;
  int picHeight;

  ShakeImage(String imageName, int picWidth, int framePerShake, float maxDegree, int maxShake)
  {
    pic = loadImage(imageName);

    this.picWidth = picWidth;
    picHeight = (int)((float)pic.height / (float)pic.width * picWidth);

    this.framePerShake = framePerShake;
    this.maxDegree = maxDegree;
    this.maxShake = maxShake * 2 -1;
    shakes = new int[this.maxShake];
    for (int i = 0;i<maxShake;i++)
      shakes[i] = i;
    for (int i = maxShake;i<shakes.length;i++)
      shakes[i] = shakes.length-i-1;
    currentFrame = -1;
    currentShake = 0;
  }

  void display(int posiX, int posiY)
  {
    currentFrame = (currentFrame+1)%framePerShake;
    if (currentFrame == framePerShake -1 )
      currentShake = (currentShake+1)%maxShake;
    pushMatrix();
    translate(posiX+picWidth/2, posiY+picHeight/2);
    rotate(map(shakes[currentShake], 0, (maxShake+1)/2, -1*maxDegree, maxDegree));
    translate(-posiX-picWidth/2, -posiY-picHeight/2);
    image(pic, posiX, posiY, picWidth, picHeight);
    popMatrix();
  }
}

