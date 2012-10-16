/*
The UFO map element.

 Author: Tao Qian
 */
class UFO extends MapElement
{
  Animation ufoPic;
  int ufoWidth;
  int ufoHeight;

  int currentLightHeight;
  int lightShownSpeed;
  int lightHeight;
  int lightWidth;

  int tintLevel;

  boolean isGoingLeft;

  UFO(int canvasX, int canvasY, int posiX, int posiY, int ufoWidth)
  {
    super(canvasX, canvasY, posiX, posiY);
    this.ufoWidth = ufoWidth;
    ufoPic = new Animation(posiX, posiY, ufoWidth, "ufo_", "png", 5);
    ufoPic.setRepeating();
    ufoPic.setFramePerImage(5);
    ufoHeight = ufoPic.imageHeight;
    currentLightHeight = 0;
    lightWidth = 0;
    lightHeight = 0;
    lightShownSpeed = 0;
  }
  void setLight(int lightheight, int lightwidth, int lightShownSpeed)
  {
    lightHeight = lightheight;
    lightWidth = lightwidth;
    currentLightHeight = 0;
    this. lightShownSpeed = lightShownSpeed;
  }

  void setCurrentLightHeight(int currentLightHeight)
  {
    this.currentLightHeight = currentLightHeight;
  }

  void showLight()
  {
    if (currentLightHeight <= lightHeight)
    {
      currentLightHeight += lightShownSpeed;
      if (currentLightHeight > lightHeight)
        currentLightHeight = lightHeight;
    }
    else if (currentLightHeight >= lightHeight)
    {
      currentLightHeight -= lightShownSpeed;
      if (currentLightHeight < lightHeight)
        currentLightHeight = lightHeight;
    }
    pushStyle();
    noStroke();
    fill(238, 255, 85, 80);
    quad(posiX+ufoWidth/5, posiY+ufoHeight/2, posiX+lightWidth-ufoWidth/5, posiY+ufoHeight/2, posiX+lightWidth+(lightWidth/3)*currentLightHeight/(lightHeight+1), posiY+ufoHeight/2+currentLightHeight, posiX-(lightWidth/3)*currentLightHeight/(lightHeight+1), posiY+ufoHeight/2+currentLightHeight);
    ellipse(posiX+lightWidth/2, posiY+ufoHeight/2+currentLightHeight, lightWidth+2*(lightWidth/3)*currentLightHeight/(lightHeight+1), 30);
    popStyle();
  }

  void setTintLevel(int tintLevel)
  {
    this.tintLevel = tintLevel;
  }

  void drawElement()
  {
    ufoPic.setPosition(posiX, posiY);
    super.drawElement();
    pushStyle();
    showLight();
    tint(255, 255-tintLevel, 255-tintLevel);
    ufoPic.display();
    popStyle();
  }

  void randomHorizontalMove()
  {
    if (random(100)>99)
      isGoingLeft = !isGoingLeft;
    int movement = (int)random(2, 4);
    if (isGoingLeft)
    {
      if (posiX<width/20*7)
      {
        isGoingLeft = false;
        movement *= -1;
      }
      moveLeft(movement);
    }
    else 
    {
      if (posiX + ufoWidth > canvasX)
      { 
        isGoingLeft = true;
        movement *= -1;
      }
      moveRight(movement);
    }
    drawElement();
  }

  void moveLeft(int n)
  {
    super.moveLeft(n);
  }

  void moveRight(int n)
  {
    super.moveRight(n);
  }

  void moveUp(int n)
  {
    super.moveUp(n);
  }

  void moveDown(int n)
  {
    super.moveDown(n);
  }

  boolean moveVerticalTo(int destinationY, int speed)
  {
    if (posiY == destinationY)
    {
      drawElement();
      return true;
    }
    if (posiY > destinationY)
    {
      posiY -= speed;
      if (posiY < destinationY)
        posiY = destinationY;
    }
    else if (posiY < destinationY)
    {
      posiY += speed;
      if (posiY > destinationY)
        posiY = destinationY;
    }
    drawElement();
    return false;
  }
}

