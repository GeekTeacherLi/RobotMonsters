

int moving_tile_millis = 1000;  //  define how long player move from one tile to the other

class Player
{
  
  PImage player;
  PImage SayBox;
  int sx,sy;    //  start postion
  int cw,ch;    //  one tile size
  int curTileX,curTileY;  //  
  int tile_max_x;
  int tile_max_y;
  int saytimer;
  String speech;
  int pw,ph;  //  player size
  
  boolean running_program;
  
  int run_start = 0;
  int prev_tile_time;
  
  int [] cmdList;
  int cmdCount;
  int curCmdIndex;
  int curCmd;
  
  int initX,initY;
  
  int nextTileX,nextTileY;
  
  
  Player(int startx,int starty,int cell_width,int cell_height,int cell_count_x,int cell_count_y,int Px,int Py)
  {
      sx = startx;
      sy = starty;
      cw = cell_width;
      ch = cell_height;
      
      initX = nextTileX = curTileX = Px;
      initY = nextTileY = curTileY = Py;
      
      tile_max_x = cell_count_x;
      tile_max_y = cell_count_y;      
      player = loadImage("monster1.png");
      SayBox = loadImage("images/SpeechBubble.png");
      saytimer = 0;
      running_program = false;
      
      
      
      
  }
  
  int GetTileX()
  {
    return curTileX;
  }
  
  int GetTileY()
  {
    return curTileY;
  }  
  
  void left()
  {
    if(nextTileX > 0)
    {
      nextTileX--;
    }
  }
  
  void right()
  {
    if(nextTileX < tile_max_x-1)
    {
      nextTileX++;
    } 
  }
  
  void up()
  {
    
    if(nextTileY > 0)
    {
      nextTileY--;
    }
    
    
  }
  
  void down()
  {
    if(nextTileY < tile_max_y-1)
    {
      nextTileY++;
    }     
  }
  
  void say(String text)
  {
    speech = text;
    saytimer = 100;
  }
  
  void reset()
  {
       nextTileX = curTileX = initX;
       nextTileY = curTileY = initY;   
       running_program = false;
       cmdCount = 0;
  }
  
  void display()
  {
    
    int px,py;
    
     // not run program
   

     int ox = 0,oy = 0;
   
   if(running_program) //<>//
   {
      // println("run program-----------------"+nextTileX + "---"+nextTileY);
     
      int run_time = millis() - prev_tile_time; //<>//
      
      int distX = 0;
      int distY = 0;
      

      distX = (nextTileX - curTileX)*cw;
      distY = (nextTileY - curTileY)*ch;
       
      
      if( run_time > moving_tile_millis)
      {
        //get next command
        prev_tile_time = millis();
        curCmdIndex++;
        curCmd = cmdList[curCmdIndex];
        curTileX = nextTileX;
        curTileY = nextTileY;
        
        px = (sx + curTileX*cw) - player.width/2;
        py = (sy + curTileY*ch) - int(player.height*0.8);            
        
        if(curCmdIndex < cmdCount)
        {
          exec_single_cmd(curCmd);
        
        }
        else
        {
          running_program = false;
          
        }
        
        println("pos:" + curTileX +" : " + curTileY);
        
      }
      else
      {
       ox = int(run_time/(1.0*moving_tile_millis) * distX);
       oy = int(run_time/(1.0*moving_tile_millis) * distY);
       
       px = (sx + curTileX*cw) - int(player.width/2) + ox;
       py = (sy + curTileY*ch) - int(player.height*0.8) + oy;
      }
      
   }
   else
   {
     // not run program
    px = (sx + curTileX*cw) - player.width/2;
    py = (sy + curTileY*ch) - int(player.height*0.8);     
     
   }
   
   
   

    
    if(saytimer > 0)
    {saytimer--;
    image(SayBox,px + 80,py - 120);  
    textSize(11);   
    text(speech,px + 45,py - 80);
    }
    
   image(player, px, py);   
   
   
  }
  
  void exec_single_cmd(int cmd)
  {
    if(cmd == CODE_UP)
      up();
    if(cmd == CODE_DOWN)
      down();
    if(cmd == CODE_LEFT)
      left();
    if(cmd == CODE_RIGHT)
      right();   
  }
  
  
  
  void run_program(int count,int [] cmdlist)
  {

     println("run_program: cmdCount:"+count);
    
     reset();
     running_program = true;

     run_start = millis();
     prev_tile_time = run_start;

    cmdList = cmdlist;
    cmdCount = count;
    curCmdIndex = 0;
    curCmd = cmdList[0];
    
    exec_single_cmd(curCmd);
    
      
  }
  
  
};