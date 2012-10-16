/*
 This class is an aggregation of bug. It controls a number of bugs and make them follow a given path.

 Tao Qian
 ART 160B Exercise 2
 Professor Chaz Evans
*/
class BugControl
{
  Bug[] bugs;
  Bug invisibleBug;//The bug that is followed by other bugs.

  BugControl(int[][] path, int baseR, int baseG, int baseB, int intervalR, int intervalG, int intervalB, int baseRadius, int intervalRadius, int baseHungerRate, int intervalHungerRate, int bugNum, int startingX, int startingY)
  {
    int baseSpeed = 5;
    int intervalSpeed = 0;

    bugs = new Bug[bugNum];

    invisibleBug = new Bug(width, height, width/2, height/2, 0, 255, 255, 255, baseSpeed);
    invisibleBug.setPath(path);

    for (int i = 0 ;i < bugs.length;i++)
    {
      bugs[i] = new Bug(width, height, startingX, startingY, baseRadius, baseR, baseG, baseB, baseSpeed);
      if (i == 0)
        bugs[i].setPrey(invisibleBug, baseHungerRate);
      else
        bugs[i].setPrey(bugs[i-1], baseHungerRate);
      baseR += intervalR;
      baseG += intervalG;
      baseB += intervalB;
      baseRadius += intervalRadius;
      baseHungerRate += intervalHungerRate;
      baseSpeed += intervalSpeed;
    }
  }
  
  //Change the color of the bugs.
  //RGBs is two dimensional array with each entry being a three element array specifying the R,G,B.
  //User is responsible for making sure that RGBs has the same length as the bugs.
  void setColor(int[][] RGBs)
  {
    for(int i = 0 ; i< bugs.length;i++)
    bugs[i].setColor(RGBs[i][0],RGBs[i][1],RGBs[i][2]);
  }

  void nextMove()
  {
    invisibleBug.pathMove();
    for (int i = bugs.length-1;i>=0;i--)
      bugs[i].huntMove();
  }
}
