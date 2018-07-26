//Player object
class Player{
  float x, y;
  float xVel, yVel;
  int xSpawn, ySpawn;
  int coins, lives;
  int[][] grid;
  Events event;
  Block check = new Block();
  boolean canJump;
  int size = 20;
  boolean win = false;
  //Player constructor
  Player(int[][] setGrid, int sx, int sy, Events e){
    x = sx;
    y = sy;
    xSpawn = sx;
    ySpawn = sy;
    
    grid = setGrid;
    
    xVel = 0;
    yVel = 0;
    
    coins = 0;
    lives = 5;
    
    event = e;
    
  }
  
  void draw(){
    fill(0);
    rect(x, y, size - 2, size * 2 - 4);
  }
  
  void update(){
    eventHandle();
    gravity();
    collisions();
    newPosition();
  }
  
  //Control player with the button presses like jumping and moving left or right
  void eventHandle(){
    if(event.getJump()){
      if(yVel == 0 || yVel < 0){
        if(canJump){
          yVel = -8;
        } else {
          yVel -= 0.3;
        }
      }
    }
    
    if(event.getLeft()){
      if(xVel > -6){
        xVel -= 0.5;
      }
    }
    
    if(event.getRight()){
      if(xVel < 6){
        xVel += 0.5; 
      }
    }
  }
  
  //Adds the velocities to the x and y positions to update the player's positions
  void newPosition(){
    
    x += int(xVel);
    y += int(yVel);
    
    if(y > 720 * 2){
      killPlayer(); 
    }
    
  }
  
  //Gravity control, friction, and max speed handle
  void gravity(){
    if(yVel <= 8){
     yVel += 0.6;
    }
    canJump = false;
    
    if(xVel > 0){
      xVel -= 0.25;
    } else if(xVel < 0){
      xVel += 0.25; 
    }
    
    if(abs(xVel) < 0.25){
      xVel = 0; 
    }
    
    if(xVel > 10){
      xVel = 10; 
    } else if(xVel < -10){
      xVel = -10;
    }
    if(yVel < -10){
      yVel = -10; 
    } else if(yVel > 10){
      yVel = 10; 
    }
  }
  
  void collisions(){
    //Check collisions with blocks surrounding the character
    for(int blocky = (int(y + yVel) / 20); blocky < (int(y + 35 + yVel) / 20) + 1; blocky++){
    for(int blockx = (int(x + xVel) / 20); blockx < (int(x + 17 + xVel) / 20) + 1; blockx++){
      //Makes sure the blocks being checked are within the grid's boundaries
      if(!(blockx >= 128 || blocky >= 72 || blockx < 0 || blocky < 0)){
        int block = grid[blockx][blocky];
    
        if(block != 0){
          //Check if collide
          if(isCollide(blockx * size, blocky * size)){
            //React with the side
            whichSide(blockx * size, blocky * size, block);
            
          }
        
        }
      }
    }
    }
    
  }
  
  //Using Axis-Aligned Bounding Box(AABB) to detect collision
  boolean isCollide(int Bx, int By){
    //Player's left, right, top, and bottom sides respectively
    float Ax = x + xVel;
    float Ay = y + yVel;
    float AX = Ax + size - 3;
    float AY = Ay + size * 2 - 5;
        //Box's left for Bx, right for BX, top for Ay, and bottom for AY sides respectively
    int BX = Bx + size;
    int BY = By + size;
    
    //Checks to see if the two objects are not colliding and returns the negated version
    return !(AX <= Bx || Ax >= BX || AY <= By || Ay >= BY);
    
  }
  
  void whichSide(int Bx, int By, int block){
    //Mostly same as check for collisions except...
    float Ax = x + xVel;
    float Ay = y + yVel;
    float AX = Ax + size - 3;
    float AY = Ay + size * 2 - 5;
    //This is the old position for the player without the x and y velocities being added
    float oldAx = x;
    float oldAy = y;
    float oldAX = oldAx + size - 3;
    float oldAY = oldAy + size * 2 - 5;
    
    int BX = Bx + size;
    int BY = By + size;
    
    //Boolean values no necessary but becomes easier to read and handle if I needed to update
    boolean left = false;
    boolean right = false;
    boolean top = false;
    boolean bottom = false;
    
    //If the old coordinate was not colliding but the new one is, then that side is colliding
    if(oldAY <= By && AY >= By){
      top = true;
    }
    if(oldAX <= Bx && AX >= Bx){
      left = true;
    }
    if(oldAx >= BX && Ax <= BX){
      right = true;
    } 
    if(oldAy >= BY && Ay <= BY){
      bottom = true;
    }
    
    //Collides the player respectively using the Block object to check
    if(top){
      check.collideBlock(this, block, 3, Bx, By);
    }  else if(left){
      check.collideBlock(this, block, 1, Bx, By);
    } else if(right){
      check.collideBlock(this, block, 2, Bx, By);
    } else if(bottom){
      check.collideBlock(this, block, 4, Bx, By);
    } else {
      check.collideBlock(this, block, 0, Bx, By);
    }
    
  }
  //Quick call to kill the player and spawn them in the new location
  void killPlayer(){
    changeLives(-1);
    setX(getXSpawn());
    setY(getYSpawn());
    setXVel(0);
    setYVel(0);
  }
  //Setters and getters and change methods to add or subtract values without needing to get value
  void setXVel(float set){
    xVel = set;
  }
  
  void setYVel(float set){
    if(set == 0){
      if(yVel > 0){
        canJump = true;
      }
    }
    
    yVel = set;
  }
  
  void setX(float set){
    x = set;
  }
  
  void setY(float set){
    y = set;
  }
  
  void changeXVel(float set){
    xVel += set;
  }
  
  void changeYVel(float set){
      yVel += set;
  }
  
  void setXSpawn(int set){
    xSpawn = set;
  }
  
  void setYSpawn(int set){
    ySpawn = set;
  }
  
  void addCoins(int set){
    coins += set;
  }
  
  void changeLives(int set){
    lives += set;
  }
  
  void setGrid(int x, int y, int block){
    grid[x][y] = block; 
  }
  
  void setWin(boolean set){
    win = set; 
  }
  
  float getX(){
    return x; 
  }
  
  float getY(){
    return y; 
  }
  
  float getXVel(){
    return xVel; 
  }
  
  float getYVel(){
    return yVel; 
  }
  
  int getXSpawn(){
    return xSpawn; 
  }
  
  int getYSpawn(){
    return ySpawn; 
  }
  
  int getLives(){
    return lives; 
  }
  
  int getCoins(){
    return coins; 
  }
  
  boolean getWin(){
    return win; 
  }
    
}