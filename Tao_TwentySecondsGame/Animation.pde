/*
General animation class to display animation

 Author: Tao Qian
 */
class Animation
{
  int posiX;
  int posiY;
  int imageWidth;
  int imageHeight;
  PImage[] images;
  int currentImage;
  int framePerImage;
  int currentFrame;

  private Animation(int posiX, int posiY, int imageWidth, int imageHeight)
  {
    setPosition(posiX, posiY);
    this.imageWidth = imageWidth;
    this.imageHeight = imageHeight;
    currentImage = -1;
    framePerImage = 1;
    currentFrame = -1;
  }

  Animation(int posiX, int posiY, int imageWidth, int imageHeight, String prefix, String extension, int count)
  {
    this(posiX, posiY, imageWidth, imageHeight);
    images = new PImage[count];
    for (int i = 0;i<images.length;i++)
    {
      images[i] = loadImage(prefix+i+"."+extension);
    }
  }

  Animation(int posiX, int posiY, int imageWidth, int imageHeight, String[] imagePaths)
  {
    this(posiX, posiY, imageWidth, imageHeight);
    images = new PImage[imagePaths.length];
    for (int i = 0;i<this.images.length;i++)
    {
      images[i] = loadImage(imagePaths[i]);
    }
  }

  Animation(int posiX, int posiY, int imageWidth, String prefix, String extension, int count)
  {
    this.posiX = posiX;
    this.posiY = posiY;
    this.imageWidth = imageWidth;
    currentImage = -1;
    framePerImage = 1;
    currentFrame = -1;
    images = new PImage[count];
    for (int i = 0;i<images.length;i++)
    {
      images[i] = loadImage(prefix+i+"."+extension);
    }
    imageHeight = (int)((float)images[0].height / (float)images[0].width * imageWidth);
  }


  void setPosition(int posiX, int posiY)
  {
    this.posiX = posiX;
    this.posiY = posiY;
  }

  void setFramePerImage(int framePerImage)
  {
    this.framePerImage = framePerImage;
    currentImage = 0;
  }

  void setCurrentImage(int currentImage)
  {
    this.currentImage = currentImage;
  }
  void setRepeating()
  {
    PImage[] newImages = new PImage[images.length*2-1];
    for (int i = 0;i< images.length;i++)
      newImages[i] = images[i];
    for (int i =images.length;i<newImages.length;i++)
      newImages[i] = images[newImages.length-i];
    images = newImages;
  }

  void display() {
    currentFrame = (currentFrame+1)%framePerImage;
    if (currentFrame == framePerImage -1 )
      currentImage = (currentImage+1)%images.length;
    image(images[currentImage], posiX, posiY, imageWidth, imageHeight);
  }
}

