/*

*/
import net.java.games.input.*;
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;


import ptmx.*;
import controlP5.*;


import ddf.minim.*;

Minim minim;

AudioPlayer bgm;
AudioPlayer sndFairy;
AudioPlayer sndCheer;





Ptmx map;


int x , y;
int tile_width = 80;
int tile_height = 64;

int offsetx = 100;
int offsety = 50;
int start_center_x = tile_width/2 + offsetx;
int start_center_y = tile_height/2 + offsety;

int TileCountX = 0;
int TileCountY = 0;

boolean GamePadReleased = true;

boolean initDone = false;
boolean gamePadOK = false;

Player player;



ControlIO control;
Configuration config;
ControlDevice gpad;
int MaxKeyePad = 16;
float init_val = 0;

int PLAYER_TILE_TYPE = 12;



int eatCount = 0;
 Toolbox toolbox;
 CodeBox codebox;

void setup() {

  size(1024, 768);
  map = new Ptmx(this, "stage01.tmx");

  TileCountX = int(map.getMapSize().x);
  TileCountY = int(map.getMapSize().y);  
 
  map.setDrawMode(CENTER);
  map.setPositionMode("MAP");
  x = int(map.getMapSize().x / 2);
  y = int(map.getMapSize().y / 2);
  imageMode(CORNER);
   map.setDrawMode(CORNER);

  map.setPositionMode("CANVAS");//Default Position Mode  


  PVector pos = getMapPlayer();

  player = new Player(start_center_x,start_center_y,tile_width,tile_height,TileCountX,TileCountY,int(pos.x),int(pos.y));

  x = -offsetx;
  y = -offsety;
  
  codebox = new CodeBox();
  toolbox = new Toolbox(this);  
  
  minim = new Minim(this);  
  bgm =  minim.loadFile("BGM1.mp3");
  sndFairy =  minim.loadFile("fairy.mp3");
  sndCheer =  minim.loadFile("cheer.mp3");  
  bgm.play();
  
  
  init_gamepad();
  
  
  initDone = true;
  
  player.say("I'm Sunshine!");
}


PVector getMapPlayer()
{
    PVector pos = new PVector();
    int w = int(map.getMapSize().x);
    int h = int(map.getMapSize().y);
    
    for(int x = 0;x < w;x++)
    for(int y = 0;y < h;y++)
    {
      int idx = map.getTileIndex(1, x, y);   
      if(idx == PLAYER_TILE_TYPE)
      {
        pos.x = x;
        pos.y = y;
        map.setTileIndex(1,x, y,-1);       
        break;
      }
    }

    return pos;

}

void init_gamepad()
{
    // Initialise the ControlIO
 try{   
    
  control = ControlIO.getInstance(this);

  gpad = control.getDevice("ePad");
  
  if (gpad == null) {
    println("No suitable device configured");
  }
    
  init_val = gpad.getSlider(0).getValue();  
  
  gamePadOK = true;
 }
 catch(Exception e)
 {
   println("gamepad NOT found!");
 }
 
}

void draw(){
  background(map.getBackgroundColor());
  map.draw(x, y);

  textSize(24);
  fill(128);


  int idx = map.getTileIndex(1, player.GetTileX(), player.GetTileY());
  
  
  
  if(idx != -1)
  {
    println("eat idx:" + idx);
    
    eatCount ++;
    sndFairy.rewind();
    sndFairy.play();
    map.setTileIndex(1,player.GetTileX(), player.GetTileY(),-1);
  
  if(eatCount >= 4)
  {
    sndCheer.rewind();
    sndCheer.play();
    eatCount =0;
  }

  }
  
  player.display();

  if(bgm.length()  - bgm.position()  < 100)
  {
    bgm.rewind();
    bgm.play();
  }  
 
 if(gamePadOK)
 {
   handle_gamepad();
 }
 
  toolbox.draw();
  codebox.draw();  

}

void keyPressed(){
  if(keyCode == LEFT) player.left();
  if(keyCode == RIGHT) player.right();
  if(keyCode == UP) player.up();
  if(keyCode == DOWN) player.down();
  
  if(keyCode == 32)
  {
    reset_game();
  }
  

  
 
  
  //PVector overTile = map.canvasToMap(x, y);
  

}


void reset_game()
{
  codebox.reset();
  player.reset();
 
  map =  new Ptmx(this, "stage01.tmx");
  System.gc();
}

void mousePressed()
{

}


public void add_up(int theValue) {

  if(!initDone)
  return;
  
  println("a button event from add_forward: "+theValue);
  codebox.addInstruction(CODE_UP);

}

public void add_down(int theValue) {
  
  if(!initDone)
  return;
  
  println("a button event from add_turnright: "+theValue);
  codebox.addInstruction(CODE_DOWN);
}  
  
public void add_turnleft(int theValue) {
  
  if(!initDone)
  return;
  
  println("a button event from add_turnleft: "+theValue);
  codebox.addInstruction(CODE_LEFT);
}  
 
  
public void add_turnright(int theValue) {
  
  if(!initDone)
  return;
  
  println("a button event from add_turnright: "+theValue);
  codebox.addInstruction(CODE_RIGHT);
}  


public void run_program(int theValue)
{
  
  if(!initDone)
  return;
  
  
  codebox.run(player);


}  


public void controlEvent(ControlEvent theEvent) {
 // println(theEvent.getController().getName());

} 


void handle_gamepad()
{
/*  
0:forward
1:backward
2:left
3:right
8:select
9:start
6,7,4,5:function keys  left up,right up,left down,right down
*/
 float val = gpad.getSlider(0).getValue();
  
  
  if(abs(init_val - val) > 0.5)
  {

  }
  
  
  int pressCount = 0;
  int pressIndex = -1;

  for(int i = 0;i < MaxKeyePad;i++)
  {
  
    boolean dilated = gpad.getButton(i).pressed();
  
    if(dilated)
    {
       pressCount++;
       pressIndex = i;
    }
    else
    {
      
    }

 
 
  }//end for
  
  
  if(pressCount == 0)
  {
    GamePadReleased = true;
  }
  else if(pressCount == 1 && GamePadReleased)
  {
    switch(pressIndex)
    {
      case 0:
      codebox.addInstruction(CODE_UP);
      break;
      case 1:
      codebox.addInstruction(CODE_DOWN);
      break;
      case 2:
      codebox.addInstruction(CODE_LEFT);
      break;
      case 3:
      codebox.addInstruction(CODE_RIGHT);
      break;   
      case 9:
      codebox.run(player);
      break;
    }
    
    GamePadReleased = false;
  }
    
}