/*
Exercise 3 TwentySecondGame
 Author: Tao Qian
 
 Game objective: control the animals with mouse to help them escape Earth.
 
 Resource used:
 UFO and animal icons:    http://www.bestfreeicons.com
 Start and ending screen: http://arcturi.com/AncientAliens/MarsAncientOrbit.html
 Background music:        http://freemusicarchive.org/music/The_Lothars/Live_at_WFMU_on_Storks_Show_271999/Scary_Boat_Ride
 Door sound effect:       http://www.freesound.org/people/pagancow/sounds/15419/
 Disappear sound effect:  http://www.freesound.org/people/Ch0cchi/sounds/15348/
 
 Revision: 
 Additional comments added. 
 Added text skipping for the long intro when starting the game for the first time. Mouse click to skip.
 
 */
int begin;               // Time the event/game begins

//Used to identify which stage the game is in.
static final int SPLASH = 0;//Initial splash screen.
static final int FIRST_STARTING = 1;//Starting animation for first time
static final int SECOND_STARTING = 2;//Starting animation for second, third...time
static final int ACTIVE = 3;//Game running
static final int ENDING = 4;//Ending animation
static final int DONE = 5;//Ending screen
int stage;//Used to indicate the current stage

PImage beginImage;       // Start with this image
PImage endImage;         // End with this image


float animalx; // x position of follow-object
float animaldx; //delta x
float speed = 70; //character of animation/type of stalker

//Musicplayers for music and sound effects
MusicPlayer backgroundMusic;
MusicPlayer doorSound;
MusicPlayer disappearSound;

//TextBoxes used in different stages of the game.
TextBox[] firstStartTextBoxes;
TextBox[] endingTextBoxes;
TextBox[] secondStartTextBoxes;
Boolean skipText;

//Store the animals that are rescued, used for display of score
ArrayList<PImage> rescuedAnimals;

//Background
BackgroundAnimation backgroundImage;
//File path of animal images.
String[] animalImageNames;

UFO ufo;
Animal animal;
int groundLevel;//Ground level(level of animal)
int ufoLevel;//The level of the ufo
int ufoLevelHorizontal;//Initial horizontal position of ufo

int textSpeedFast;
int textSpeedSlow;

void setup() 
{
  noCursor();
  frameRate(60);
  size(1000, 600);
  groundLevel = height*5/6;
  ufoLevel = height/15*2;
  ufoLevelHorizontal = width/40*24;

  beginImage = loadImage("splash_screen.jpg");
  endImage = loadImage("splash_screen.jpg");
  animalImageNames = new String[] {
    "bear", "bull", "bulldog", "cat", "cow", "crocodile", "dear", "donkey", "elephant"
  };

  backgroundImage = new BackgroundAnimation(0, 0, width, height, "background_", "jpg", 5);
  backgroundImage.setFramePerImage(10);
  backgroundImage.setCurrentImage(backgroundImage.images.length-1);

  Minim m = new Minim(this);
  backgroundMusic = new MusicPlayer(m, "Scary_Boat_Ride.mp3");
  doorSound = new MusicPlayer(m, "door_sound.wav");
  disappearSound = new MusicPlayer (m, "pop.wav");

  textSpeedFast = 2;
  textSpeedSlow = 3;

  firstStartTextBoxes = new TextBox[8];

  firstStartTextBoxes[0] = new TextBox(ufoLevelHorizontal+width/6, ufoLevel, textSpeedFast, "Why do we come to this dirty planet?\nEarth is too dangerous!\nLet's go back to Mars.    ", color(187, 0, 0));
  firstStartTextBoxes[1] = new TextBox(ufoLevelHorizontal-width/5, ufoLevel, textSpeedSlow, "Wait! Wait!\nLook at those poor creatures! \nThey are dying in this \npoisonous atmosphere...\nWe should save them.    ", color(17, 187, 0));
  firstStartTextBoxes[2] = new TextBox(ufoLevelHorizontal+width/5, ufoLevel, textSpeedFast, "No!\nLet them die!\nThey ruined this place and \nthey should die with it!    ", color(187, 0, 0));
  firstStartTextBoxes[3] = new TextBox(ufoLevelHorizontal-width/5, ufoLevel, textSpeedSlow, "Didn't you remember a thing from our \nhigh school Earth history class? \nThe builders of that shabby \nhouse destroyed this planet \nin the process of \ndestroying themselves. \nThose creatures are innocent!    ", color(17, 187, 0));
  firstStartTextBoxes[4] = new TextBox(ufoLevelHorizontal+width/5, ufoLevel, textSpeedFast, "Okay okay.\nThat reminds me of something,\nbut anyway, we cannot pick \nthem up because we have \nlittle control over\nour spaceship in the \nstrong gravitational field here!    ", color(187, 0, 0));
  firstStartTextBoxes[5] = new TextBox(ufoLevelHorizontal-width/5, ufoLevel, textSpeedSlow, "No excuses.\nAt least we could drift around.\nThen we might be able to \nsave some of the \npoor desperate animals!    ", color(17, 187, 0));
  firstStartTextBoxes[6] = new TextBox(ufoLevelHorizontal+width/5, ufoLevel, textSpeedFast, "Fine.\nJust 20 Earth seconds,\nbefore the high concentration of \ncardon dioxide\ndamage our \noxygen generation system.    ", color(187, 0, 0));
  firstStartTextBoxes[7] = new TextBox(ufoLevelHorizontal-width/5, ufoLevel, textSpeedSlow, "That I agree.\n20 seconds\nStart working!", color(17, 187, 0));

  secondStartTextBoxes = new TextBox[2];
  secondStartTextBoxes[0]  = new TextBox(ufoLevelHorizontal-width/5, ufoLevel, textSpeedSlow, "Wow, we are back!\nLet's save more lives!    ", color(17, 187, 0));
  secondStartTextBoxes[1] = new TextBox(ufoLevelHorizontal+width/5, ufoLevel, textSpeedFast, "What?\nNot again!            ", color(187, 0, 0));

  endingTextBoxes = new TextBox[1];
  endingTextBoxes[0] = new TextBox(ufoLevelHorizontal-width/5, ufoLevel-height/12, 2, "I could not stand this place any more!!!!!!!!!!!!!!!!!!!!\n         Let's get out of here!!!!!!!!!!!!!!!!!!!!!!    ", color(187, 0, 0));
  
  skipText = false;

  stage = SPLASH;
}

void draw() 
{
  //Call different functions for different stages.
  switch(stage)
  {
  case SPLASH:
    splash();
    break;
  case FIRST_STARTING:
    firstStarting();
    break;
  case SECOND_STARTING:
    secondStarting();
    break;
  case ACTIVE:
    eventGame();         // Run the event/game
    timer();             // Time the event/game
    break;
  case ENDING:
    ending();
    break;
  case DONE:
    done();
    break;
  }
}

void eventGame() 
{
  if (animal.rescued)
  {
    disappearSound.start();
    rescuedAnimals.add(loadImage(animal.getImageName()));
    animal = getNewAnimal();
    doorSound.start();
    backgroundImage.setDoorOpen();
  }
  backgroundImage.display();
  if (!backgroundImage.doorOpen)
  {
    animal.drawElement();
    if (!backgroundImage.doorClose)
    {
      animal.setMovable(true);
      animaldx = mouseX - animalx;
      animalx = animaldx/speed + animalx;
      animal.setPosiX((int)animalx);
    }
  }
  ufo.randomHorizontalMove();
  drawScore(10, 10, 50);
}

void newGame()
{
  backgroundImage.setCurrentImage(backgroundImage.images.length-1);
  backgroundImage.setDoorOpen();
  ufo = new UFO (width, height, ufoLevelHorizontal, ufoLevel, 140);
  ufo.setLight(groundLevel-100, ufo.ufoWidth, 2);
  animal =getNewAnimal();
  doorSound.start();
  animal.setMovable(false);

  rescuedAnimals = new ArrayList<PImage>();

  begin = millis();
}

void splash() {
  image(beginImage, 0, 0);
}

void firstStarting()
{
  backgroundImage.display();
  if (!ufo.moveVerticalTo(ufoLevel, 3))
    return;
  for (int i = 0;i< firstStartTextBoxes.length;i++)
  {
    if (!firstStartTextBoxes[i].isFinished())
    {
      if(skipText)
      {
        skipText = false;
        firstStartTextBoxes[i].skip();
        continue;
      }
      firstStartTextBoxes[i].drawTextBox();
      return;
    }
  }
  newGame();
  stage = ACTIVE;
}

void secondStarting()
{
  backgroundImage.display();
  if (!ufo.moveVerticalTo(ufoLevel, 3))
    return;
  for (int i = 0;i< secondStartTextBoxes.length;i++)
  {
    if (!secondStartTextBoxes[i].isFinished())
    {
      secondStartTextBoxes[i].drawTextBox();
      return;
    }
  }
  newGame();
  stage = ACTIVE;
}

void ending()
{
  backgroundImage.display();
  animal.drawElement();
  for (int i = 0;i< endingTextBoxes.length;i++)
  {
    if (!endingTextBoxes[i].isFinished())
    {
      endingTextBoxes[i].drawTextBox();
      ufo.drawElement();
      return;
    }
  }
  if (!ufo.moveVerticalTo(-100, 3))
    return;
  stage = DONE;
}

void done() {
  image(endImage, 0, 0);
  drawScore(width-400, height-100, 50);
  for (TextBox tb: secondStartTextBoxes)
    tb.reset();
  for (TextBox tb:endingTextBoxes)
    tb.reset();
}

void mousePressed() 
{
  switch(stage)
  {
    case(SPLASH):
    stage = FIRST_STARTING;
    ufo = new UFO (width, height, ufoLevelHorizontal, -100, 140);
    backgroundMusic.start();
    break;
    case(DONE):
    stage = SECOND_STARTING;
    ufo = new UFO (width, height, ufoLevelHorizontal, -100, 140);
    break;
    case(FIRST_STARTING):
    skipText = true;
    break;
  }
}

void stop()
{
  backgroundMusic.stop();
  doorSound.stop();
  disappearSound.stop();
}

void timer() 
{
  int curTime = millis();
  if (curTime > begin + 20000) {
    stage = ENDING;
    animal.setAttractable(false);
    ufo.setLight(0, 0, 0);
  }
  ufo.setTintLevel((curTime-begin)*200/20000);
  /*
  noStroke();
   fill(255);
   rect(0, height-5, width, 5);
   fill(0);
   rect(0, height-5, (curTime-begin)/50, 5);
   */
}

Animal getNewAnimal()
{
  int randomInt = (int)random(animalImageNames.length-0.0001);
  animalx = width/10*2;
  return  new Animal(width, height, width/10*2, 500, 500, 50, animalImageNames[randomInt]+".png", ufo);
}

void drawScore(int posiX, int posiY, int scoreHeight)
{
  int spacing = 10;
  int nextX = posiX;
  for (int i = 0;i<rescuedAnimals.size();i++)
  {
    int scoreWidth = (int)((float)rescuedAnimals.get(i).width/(float)rescuedAnimals.get(i).height*scoreHeight);
    image(rescuedAnimals.get(i), nextX, posiY, scoreWidth, scoreHeight);
    nextX = nextX + scoreWidth + spacing;
  }
}

