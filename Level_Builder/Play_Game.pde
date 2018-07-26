class Play_Game{
  int[][] grid;
  int[][] oldGrid;
  int oldPX, oldPY;
  Player player;
  int camX, camY;
  PImage[] image = new PImage[32];
  boolean quit = false;
  int size = 20;
  
  PFont font = createFont("Impact", 20);
  PImage background = loadImage("Game Images/background4.png");
  PImage back;
  
  //Play game object
  Play_Game(int[][] setGrid, int px, int py, Events e, Textures t){
    grid = setGrid;
    oldGrid = new int[grid.length][grid[0].length];
    
    for(int x = 0; x < grid.length; x++){
      for(int y = 0; y < grid[0].length; y++){
        
       oldGrid[x][y] = grid[x][y];
        
      }
    }
      background.resize(1520, 900);

    oldPX = px;
    oldPY = py;
    
    player = new Player(grid, px, py, e);
    camX = px;
    camY = py;
    image = t.getImage();
  }
  
  void update(){
    
    
    draw();
    player.update();
    
    //If the player quits or dies
    if(event.getEnter() || player.getLives() == 0){
      quit = true;
    }
    //If the player gets 100 coins
    if(player.getCoins() >= 100){
      player.addCoins(-100);
      player.changeLives(1);
    }
    //If the player wins, just quit. Could add a victory screen but ran out of time
    if(player.getWin()){
      quit = true; 
    }
    
  }
  
  void draw(){
    background(255);
    scale(3);
    //Change location of the camera
    camControl();
    image(background, camX / 2, camY / 2);
    translate(camX, camY);
    
    //Only draw blocks in view
    for (int x = -camX / 20; x < (-camX + 430) / 20 + 1; x++) {
      for (int y = -camY / 20; y < (-camY + 240) / 20 + 1; y++) {
        
        //If statement to avoid the use of a try/catch statment
        //This is because the try/catch statement seemed to reduce the framerate a lot
        if(!(x >= 128 || y >= 72 || x < 0 || y < 0)){
          int block = grid[x][y];
          
          if(block != 0 && !(block > 24) && block != 22){
            image(image[block], x * size, y * size);
          }  
        }
        
      }
    }
    
    
    //Draw lives and coins counter
    fill(255, 0, 0);
    textFont(font);
    text("Lives: " + player.getLives(), -camX + 40, -camY + 40);
    
    fill(200, 200, 10);
    textFont(font);
    text("Coins: " + player.getCoins(), -camX + width / 3 - 40, -camY + 40);
    //Draw player
    player.draw();
  }
  
  void camControl(){
    //Focus camera on player...
    camX = int((width / 3) / 2 - int(player.getX()) - 9);
    camY = int((height / 3) / 2 - int(player.getY()) - 18);
    
    //Unless the camera would go out of the level, in which case stop following the player
    if (-camX + 1280 / 3 > (1280 * 2)){
      camX = int((-1280 * 2) + 1280 / 3);
    } else if (camX > 0){
      camX = 0;
      }
    if (-camY + 720 / 3 > (720 * 2)){
      camY = int((-720 * 2) + 720 / 3);
    } else if (camY > 0){
      camY = 0;
    }
  }
  //Setters and getters
  boolean getQuit(){
    return quit; 
  }
  
  int getOldPX(){
    return oldPX;
  }
  
  int getOldPY(){
    return oldPY; 
  }
  
  int[][] getGrid(){
    return oldGrid; 
  }
}