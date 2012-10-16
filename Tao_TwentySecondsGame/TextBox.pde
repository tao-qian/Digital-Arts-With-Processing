/*
Used to display texts

 Author: Tao Qian
 */
class TextBox
{
  int posiX;
  int posiY;
  int framePerChar;
  String boxText;
  int currentChar;
  int currentFrame;
  color RGBColor;


  PFont font;

  TextBox(int posiX, int posiY, int framePerChar, String boxText, color RGBColor)
  {
    this.framePerChar = framePerChar;
    this.RGBColor = RGBColor;
    font = loadFont("Chiller-Regular-48.vlw");
    setText(posiX, posiY, boxText);
  }


  void drawTextBox()
  {
    if (currentChar == boxText.length())
      return;
    currentFrame++;
    if (currentFrame % framePerChar == 0)
    {
      currentChar++;
      currentFrame = 0;
    }
    pushStyle();
    fill(RGBColor);
    textFont(font, 20);
    text(boxText.substring(0, currentChar), posiX, posiY);
    popStyle();
  }

  void setText(int posiX, int posiY, String boxText)
  {
    this.boxText = boxText;
    this.posiX = posiX;
    this.posiY = posiY;
    currentChar = -1;
    currentFrame = -1;
  }

  boolean isFinished()
  {
    return currentChar == boxText.length();
  }
  
  void skip()
  {
    currentChar = boxText.length();
  }

  void reset()
  {
    currentChar = 0;
  }
}

