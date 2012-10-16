/*
Class for animal. Supports the movement, drawing of animals on the
 canvas.It is responsible for the interaction between the animal and the ufo.
 
 Author: Tao Qian
 */
public class Animal extends MapElement
{
  ShakeImage animalImage;
  UFO ufo;
  int upSpeed;
  int downSpeed;
  int groundLevel;
  int animalWidth;
  int animalHeight;
  String imageName;


  boolean rescued;
  boolean movable;
  boolean attractable;

  Animal(int canvasX, int canvasY, int posiX, int posiY, int groundLevel, int animalWidth, String imageName, UFO ufo)
  {
    super(canvasX, canvasY, posiX, posiY);
    animalImage = new ShakeImage(imageName, animalWidth, 2, 0.3, 5);
    this.groundLevel = groundLevel;
    upSpeed = 5;
    downSpeed = 2;
    rescued = false;
    animalWidth = animalImage.picWidth;
    animalHeight = animalImage.picHeight;
    this.ufo = ufo;
    this.imageName = imageName;
    movable = false;
    attractable = true;
  }

  int ufoAttraction()
  {
    if (!attractable)
      return 0;
    if (posiX > ufo.posiX && posiX<ufo.posiX+ufo.ufoWidth)
      return upSpeed*((ufo.ufoWidth/2)-abs(posiX-ufo.posiX-ufo.ufoWidth/2))/(ufo.ufoWidth/2)+downSpeed;
    return 0;
  }

  void moveDown(int distance)
  {    
    if (movable)
    {
      super.moveDown(distance);
      if (posiY > groundLevel)
        posiY = groundLevel;
    }
  }

  void moveUp(int distance)
  {    
    if (movable)
    {
      super.moveUp(distance);
      if (posiY < ufo.posiY+ufo.ufoHeight)
        rescued = true;
    }
  }

  void setPosiX(int posiX)
  {
    if (movable)
    {
      this.posiX = posiX;
    }
  }

  void setMovable(boolean movable)
  {
    this. movable = movable;
  }

  void setAttractable(boolean attractable)
  {
    this.attractable = attractable;
  }
  void drawElement()
  {
    if (rescued)
      return;
    moveUp(ufoAttraction());
    moveDown(downSpeed);
    animalImage.display( posiX, posiY);
  }

  String getImageName()
  {
    return imageName;
  }
}

