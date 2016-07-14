import controlP5.*;

ControlP5 cp5;

int BUTTON_SIZE = 60;

color [] codes;


 int CODE_UP = 1;
 int CODE_DOWN = 2;
 
  int CODE_LEFT = 3;
  int CODE_RIGHT = 4;  
  
  int CODE_LASER = 5;

class Toolbox
{


  
  
  Toolbox(PApplet p)
  {
   cp5 = new ControlP5(p);   
    
   codes = new color[4]; 
    codes[0] = color(204, 102, 0);
    codes[1] = color(0, 102, 200);   
   codes[2] = color(0, 202, 0);  
   codes[3] = color(204, 202, 0); 
   
   PImage[] imgs1 = {loadImage("up.png"),loadImage("up2.png"),loadImage("up3.png")};
  cp5.addButton("add_up")
     .setValue(128)
     .setPosition(800,100)
     .setImages(imgs1)
     .updateSize()
     ;  
     
     
     PImage[] imgs2 = {loadImage("down.png"),loadImage("down2.png"),loadImage("down3.png")};
  cp5.addButton("add_down")
     .setValue(128)
     .setPosition(800,180)
     .setImages(imgs2)
     .updateSize()
     ;        
     
   PImage[] imgs3 = {loadImage("left.png"),loadImage("left2.png"),loadImage("left3.png")};
  cp5.addButton("add_turnleft")
     .setValue(128)
     .setPosition(800,260)
     .setImages(imgs3)
     .updateSize()
     ;       
     
    PImage[] imgs4 = {loadImage("right.png"),loadImage("right2.png"),loadImage("right3.png")};
  cp5.addButton("add_turnright")
     .setValue(128)
     .setPosition(800,340)
     .setImages(imgs4)
     .updateSize()
     ;        
     
     
     
    PImage[] imgs5 = {loadImage("play.png"),loadImage("play.png"),loadImage("play.png")};
  cp5.addButton("run_program")
     .setValue(128)
     .setPosition(30,520)
     .setImages(imgs5)
     .updateSize()
     ;         
   
     
   
   println("ToolBox Loaded!");
  }
  

  
  void draw()
  {

  }
  
 
  

  
  
};