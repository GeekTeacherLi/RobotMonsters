
int MAX_CODE_ITEM = 32; 
int MAX_INSTRUCTION_TYPE = 5;
int CMD_COUNT_PER_ROW = 16;



class CodeBox
{
  int []codelist;
  int currentIndex;
  PImage[] instructions;
  
  CodeBox()
  {
     codelist = new int[MAX_CODE_ITEM]; 
     currentIndex = 0;
     instructions = new PImage[MAX_INSTRUCTION_TYPE];
   
   
   instructions[0] = loadImage("up.png");  
   
   instructions[1] = loadImage("up.png");     
   instructions[2] = loadImage("down.png");
   instructions[3] = loadImage("left.png");
   instructions[4] = loadImage("right.png");     
   
     
  }
  
  void addInstruction(int instruction)
  {
    if(currentIndex < MAX_CODE_ITEM)
    {
    codelist[currentIndex] = instruction;
    currentIndex++;
    }
  }
  
  void reset()
  {
    currentIndex = 0;
  }
  
  
  void draw()
  {
    rect(50,600,BUTTON_SIZE * 15,BUTTON_SIZE * 2 +10);
    
    // println(currentIndex );
    int row = 0;
    int col = 0;
    
    for(int i = 0;i < currentIndex;i++)
    {
        
        if(i == CMD_COUNT_PER_ROW)
        {
          row=1;
          col = 0;
        }

        stroke(200);

        if(gIsRunningProgram)
        {

          if(gRunCmdIndex == i)
          {
            rect(45 +BUTTON_SIZE *col,620 + row*60,BUTTON_SIZE,BUTTON_SIZE);
          }
        
        }
        
        image(instructions[codelist[i]],45 +BUTTON_SIZE *col,620 + row*60);
        
        col++;
    }
    
    
  }
  
  void run(Player player)
  {
     println("RUN the program");
      

     player.run_program(currentIndex,codelist);
      
  }
  
};