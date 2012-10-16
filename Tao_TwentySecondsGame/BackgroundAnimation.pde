/*
Specific animation for background. It allows animation to be displayed
 infrequently
 
  Author: Tao Qian.
 */
class BackgroundAnimation extends Animation
{
  boolean doorOpen;
  boolean doorClose;

  BackgroundAnimation(int posiX, int posiY, int imageWidth, int imageHeight, String prefix, String extension, int count)
  {
    super(posiX, posiY, imageWidth, imageHeight, prefix, extension, count);
  }

  void display()
  {
    currentFrame = (currentFrame+1)%framePerImage;
    if (currentFrame != framePerImage -1 )
    {
      image(images[currentImage], posiX, posiY, imageWidth, imageHeight);
      return;
    }
    if (doorOpen)
    {
      currentImage --;
      if (currentImage == 0)
      {
        doorOpen = false;
        doorClose = true;
      }
    }
    else if (doorClose)
    {
      currentImage ++;
      if (currentImage == images.length-1)
        doorClose = false;
    }
  }

  void setDoorOpen()
  {
    doorOpen = true;
    currentImage = images.length-1;
  }

  void setDoorClose()
  {
    doorClose = true;
    currentImage = 0;
  }
}

