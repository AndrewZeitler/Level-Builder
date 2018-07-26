
Level_Editor editor;
Events event;
Load_Game load;
Play_Game play;
Textures texture;

Button newGame, loadGame, exitGame;

boolean menu = true;
boolean edit = false;
boolean game = false;

PFont font;

void setup() {
  size(1280, 720);
  
  //Create objects for later use
  event = new Events();
  texture = new Textures();
  //Create button objects for menu system
  newGame = new Button(width / 2, 400, "New Game", 40, event);
  loadGame = new Button(width / 2, 500, "Load Game", 40, event);
  exitGame = new Button(width / 2, 600, "Exit Game", 40, event);
  font = createFont("Impact", 80);
  
  smooth(6);
  frameRate(60);
}

void draw() {
  //Main loop with entire game
  if (menu) {
    background(169, 251, 252);
    drawMain();
  } else if (edit) {
    editor.update();
    
    //If they exit to menu...
    if(editor.getMenu()){
      edit = false;
      menu = true;
    }
    //If they begin game...
    if(editor.getGame()){
      edit = false;
      game = true;
      play = new Play_Game(editor.getGrid(), editor.getPX() * 20, editor.getPY() * 20 , event, texture);
    }
  } else if(game){
    //If they quit or die...
    if(play.quit){
      edit = true;
      game = false;
      editor = new Level_Editor(event, texture);
      editor.setPX(play.getOldPX() / 20);
      editor.setPY(play.getOldPY() / 20);
      editor.setGrid(play.getGrid());
    }
    
    play.update();
  }

  event.setPressed(false);
}

void drawMain() {
  //Draws and updates menu
  newGame.update();
  loadGame.update();
  exitGame.update();

  if (newGame.getClicked()) {
    editor = new Level_Editor(event , texture);
    menu = false;
    edit = true;
    newGame.setClicked(false);
  }
  
  if(loadGame.getClicked()){
    load = new Load_Game();
    loadGame.setClicked(false);
  }
  
  if(exitGame.getClicked()){
    exit();
  }
  
  fill(0);
  textFont(font);
  text("Wonder World Builder", width / 2, 200);
}

void mouseWheel(MouseEvent e) {
  event.setWheel(-e.getCount() / 4.0);
}

void mousePressed() {

  event.setPressed(true);
}

  //Reads values for event object with key

void keyPressed() {
  switch(key) {
    case ENTER:
      event.setEnter(true);
      break;
    case 'g':
      event.setGrid(true);
      break;
    case ' ':
      event.setJump(true);
      break;
    case 'a':
      event.setLeft(true);
      break;
    case 'd':
      event.setRight(true);
      break;
    }  
  
}

void keyReleased(){
  switch(key) {
    case ' ':
      event.setJump(false);
      break;
    case 'a':
      event.setLeft(false);
      break;
    case 'd':
      event.setRight(false);
      break;
  }
}
  //File selected method for when load game gets called
  void fileSelected(File selected){
    
    if(selected != null){
      String[] data = loadStrings(selected);
      editor = new Level_Editor(event, texture);
      editor.setGrid(loadGrid(data));
      editor.setPX(loadX(data));
      editor.setPY(loadY(data));
      menu = false;
      edit = true;
    }
    
  }
  //Returns the grid after it has been retrieved from a file
  int[][] loadGrid(String[] data){
    int[][] grid = new int[128][72];
    //Loads data into the grid array we made
    for(int x = 0; x < grid.length; x++){
      for(int y = 0; y < grid[0].length; y++){
        if(data[x * grid[0].length + y] == null || int(data[x * grid[0].length + y]) > 31){
          grid[x][y] = 0; 
        } else {
          grid[x][y] = int(data[x * grid[0].length + y]); 
        }
      }
    }
    return grid;
  }
  //Getters for the loading of our player's information
  int loadX(String[] data){
    return int(data[data.length - 2]); 
  }
  
  int loadY(String[] data){
    return int(data[data.length - 1]); 
  }