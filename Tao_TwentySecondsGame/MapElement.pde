/*
super class for all map elements.

 Author: Tao Qian
 */
public class MapElement
{
  int canvasX;
  int canvasY;
  int posiX;
  int posiY;

  MapElement(int canvasX, int canvasY, int posiX, int posiY)
  {
    this.canvasX = canvasX;
    this.canvasY = canvasY;
    this.posiX = posiX;
    this.posiY = posiY;
  }

  void moveLeft(int distance)
  {
    posiX -= distance;
  }

  void moveRight(int distance)
  {
    posiX += distance;
  }

  void moveUp(int distance)
  {
    posiY -= distance;
  }

  void moveDown(int distance)
  {
    posiY += distance;
  }

  void drawElement()
  {
  }
}

