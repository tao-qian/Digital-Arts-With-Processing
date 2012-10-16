/*
 Basic element used for drawing. By default, a instance of 
 this class only moves randomly on the canvas. 
 However, if setPath() is called, the "bug" will move following a given path.
 And if setPrey() is called, the "bug" will chase after another bug.

 Tao Qian
 ART 160B Exercise 2
 Professor Chaz Evans
*/
class Bug
{

  int canvasX;//The width of the canvas
  int canvasY;//The height of the canvas
  int positionX;//The current x coordinate of the bug
  int positionY;//The current y coordinate of the bug
  int radius;//radius of the bug
  //Color of the bug in RGB
  int colorR;
  int colorG;
  int colorB;
  //Speed at which the bug moves.
  int speed;
  //Determine how likely the bug will chase after the bug
  //A int value from 0 to 100.
  int hungerRate;
  //The bug that was preyed
  Bug preyBug;
  //The arraylist that is used to define a given path for circleMove()
  int[][]path;
  int pathPosition;//Used to locate the current path the bug is on.

  //Constructor
  Bug(int canvasX, int canvasY, int initialX, int initialY, int radius, int colorR, int colorG, int colorB, int speed)
  {
    this.canvasX = canvasX;
    this.canvasY = canvasY;
    positionX = initialX;
    positionY = initialY;
    this.radius = radius;
    this.colorR = colorR;
    this.colorG = colorG;
    this.colorB = colorB;
    this.speed = speed;
    preyBug = null;
    path = null;

    noStroke();
  }

  //Set the prey and hunger rate of the bug
  //This function must be called if the non-random
  //hunting mode is to be used.
  void setPrey(Bug preyBug, int hungerRate)
  {
    this.preyBug = preyBug;
    this.hungerRate = hungerRate;
  }

  //Set the path in which the bug will follow.
  //This function must be called if the pathMove()
  //mode is to be used.
  void setPath(int[][] path)
  {
    this.path = path;
    pathPosition = 0;
    positionX = path[pathPosition][0];
    positionY = path[pathPosition][1];
  }

  //Move the bug with an angle with distance determined by the variable speed.
  void move(float angle)
  {
    fill(colorR, colorG, colorB);

    /*
    //The code below allows the bug to emerge from the opposite side of the
     //canvas when it moves out of one side.
     positionX = (int)((float)positionX+(float)speed*cos(angle));
     positionY = (int)((float)positionY+(float)speed*sin(angle));
     println(speed*cos(angle)+" "+speed*sin(angle)+" "+positionX+" "+positionY);
     if (positionX<0)
     positionX += canvasX;
     if (positionY<0)
     positionY += canvasY;
     positionX %= canvasX;
     positionY %= canvasY;
     */

    //The code below allows the bug to turn around at corners
    float xDifference = ((float)speed)*cos(angle);
    float yDifference = ((float)speed)*sin(angle);
    positionX = (int)(positionX+xDifference);
    positionY = (int)(positionY+yDifference);
    if (positionX<=0 || positionX >= canvasX)
      positionX -= 2*xDifference;
    if (positionY<=0 || positionY>=canvasY)
      positionY -= 2*yDifference;


    ellipse(positionX, positionY, 2*radius, 2*radius);
  }

  //Move at a random direction.
  void randomMove()
  {
    float randomAngle=random(0, 2*PI);
    //Rotate angle is in clockwise!
    move(randomAngle);
  }

  //Go after the prey with the likelihood determined by the hunger rate
  //Will not work if the prey is not set.
  void huntMove()
  {
    if (preyBug == null) {
      randomMove();
      return;
    }
    int hunger = (int)random(100);//Return a value between 0 and 99 (inclusive)
    if (hunger<hungerRate)
    {
      move(getAngle(positionX, positionY, preyBug.positionX, preyBug.positionY));
    }
    else {
      randomMove();
    }
  }
  
  //Follow the points in path.
  void pathMove()
  {
    if (path == null)
    {
      randomMove();
      return;
    }

    int distance = abs(path[pathPosition][0]-positionX)+abs(path[pathPosition][1]-positionY);
    if (distance < 10)
      pathPosition = (pathPosition + 1)%path.length;
    move(getAngle(positionX, positionY, path[pathPosition][0], path[pathPosition][1]));
  }
  
  //Get the angle from two points.
  float getAngle(int positionX, int positionY, int directionX, int directionY)
  {
    Float angle = atan((float)(directionY-positionY)/(directionX-positionX));
    if ((directionX-positionX)<0)
      angle += PI;
    if (angle.isNaN())
      return 0;
    return angle;
  }
  
  //Change the color of the bug
  void setColor(int R, int G, int B)
  {
    colorR = R;
    colorG = G;
    colorB = B;
  }
}

