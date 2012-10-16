/*
 This project is called bug drawing machine because it is made up of many different circles.
 These circles can either move randomly, follow a predefined path or follow one another.
 In this project, I used these "bugs" to draw a flower
 
 Revisions:
 1) Removed background and stick because stationary components do not really fit into the picture.
 2) Support randomized color generation for the bud. Double click to change color. (Single click to pause drawing)
 3) Support preset colors. Press "1" or "2" to use the first and second pre-defined color.
 
 Tao Qian
 ART 160B Exercise 2
 Professor Chaz Evans
 */

BugControl bud;//Draw the bud of the flower
BugControl rightLeaf;//Draw the right leaf of the flower
BugControl leftLeaf;//Draw the left leaf of the flower
Bug branch; //Draw the branch
Bug branchInner; //Draw the shadow of the branch
Bug backgroundDrawer; // Draw the background

//Used to control the drawing of background
//int backgroundCounter;

int[][] budPath;

boolean isDrawing;

void setup()
{
  size(800, 800);
  frameRate(2000);
  background(255);

  //The bugs in bud loops around the points in budPath.
  budPath = new int[][] {
    {
      width/6, height/6
    }
    , {
      width/2, height/6
    }
    , {
      width/6*5, height/6
    }
    , {
      width/6*5, height/2
    }
    , {
      width/6*5, height/6*5
    }
    , {
      width/2, height/6*5
    }
    , {
      width/6, height/6*5
    }
    , {
      width/6, height/2
    }
  };
  int[] randomColor = generateRandomColor();
  bud = new BugControl(budPath, randomColor[0], randomColor[1], randomColor[2], randomColor[3], randomColor[4], randomColor[5], 10, -1, 40, 8, 8, width/5, height/32*9);

  //Bugs in rightLeaf go back and forth between the two points in rightLeafPath.
  int[][] rightLeafPath = new int[][] {
    {
      width/6*5, height/6
    }
    , {
      width/6*4, height
    }
  };
  rightLeaf = new BugControl(rightLeafPath, 17, 85, 0, 0, 17, 0, 2, 0, 50, 8, 4, width/24*19, height/3);

  //Bugs in leftLeaf go back and forth between the two points in leftLeafPath
  int[][] leftLeafPath = new int[][] {
    {
      width/7, height/7*6
    }
    , {
      width/8*7, height/6*5
    }
  };
  leftLeaf = new BugControl(leftLeafPath, 17, 85, 0, 0, 17, 0, 2, 0, 50, 8, 4, width/3, height/24*19);

  /*
  //Branch traces the path specified in branchPath.
   int[][] branchPath = new int[][] {
   {
   width/2, height/5*3
   }
   , {
   width/20*11, height/200*137
   }
   , { 
   width/50*31, height/25*19
   }
   , {
   width/10*7, height/100*81
   }
   , {
   width/100*73, height/100*85
   }
   , {
   width/100*89, height/100*95
   }
   , {
   width/100*73, height/100*85
   }
   , {
   width/10*7, height/100*81
   }
   , { 
   width/50*31, height/25*19
   }
   , {
   width/20*11, height/200*137
   }
   };
   branch = new Bug(width, height, width/2, height/2, 5, 136, 68, 0, 5);
   branchInner = new Bug(width, height, width/2, height/2, 5, 136, 85, 0, 5);//branchInner traces the same path, but translation is applied later.
   branch.setPath(branchPath);
   branchInner.setPath(branchPath);
   
   backgroundCounter = 0;
   backgroundDrawer = new Bug(width, height, width/2, height/2, 10, 187, 255, 221, 300);//backgroundDrawer draws circles randomly.
   */
  isDrawing = true;
}

void draw()
{
  if (!isDrawing)
    return;

  /*
  //Draw the background in the first 1000 calls to draw()
   if (backgroundCounter < 1000)
   {
   backgroundDrawer.randomMove();
   backgroundCounter++;
   }
   //Draw branch
   branch.pathMove();
   translate(5, 0);
   branchInner.pathMove();
   translate(-5, 0);
   */
  //Draw bud and leaves
  bud.nextMove();
  rightLeaf.nextMove();
  leftLeaf.nextMove();
}

int[] generateRandomColor()
{
  int[] result = new int[] {
    (int)random(255), (int)random(100), (int)random(150), 0, 0, 0
  };
  int step = 17;
  int toBeDecreased = (int)random(254-8*step)+8*step;
  int changedColor = (int)random(3);
  result[changedColor] = toBeDecreased;
  result[3+changedColor] = -1 *step;
  return result;
}

/*
Control whether to draw.
 */
void mouseReleased()
{ 
  if (mouseEvent.getClickCount()==1)
    isDrawing = !isDrawing;
  else
  {
    fill(255);
    rect(0, 0, width, height);
    int[] randomColor = generateRandomColor();
    bud = new BugControl(budPath, randomColor[0], randomColor[1], randomColor[2], randomColor[3], randomColor[4], randomColor[5], 10, -1, 40, 8, 8, width/5, height/32*9);
    isDrawing = true;
  }
}

void keyPressed()
{
  if (key == '1')
  {
    fill(255);
    rect(0, 0, width, height);
    bud = new BugControl(budPath, 255, 221, 0, 0, -17, 0, 10, -1, 40, 8, 8, width/5, height/32*9);
    isDrawing = true;
  }
  else if (key == '2')
  {
    fill(255);
    rect(0, 0, width, height);
    int[][] budColor = new int[][] {
      {
        201, 12, 12
      }
      , {
        191, 6, 6
      }
      , {
        170, 5, 5
      }
      , {
        147, 6, 6
      }
      , {
        124, 6, 6
      }
      , {
        93, 2, 2
      }
      , {
        77, 3, 3
      }
      , {
        57, 2, 2
      }
    };
    bud.setColor(budColor);
    isDrawing = true;
  }
  else   if (key == 's') {
    save("capture_"+hour()+minute()+second()+".png");
  }
}

