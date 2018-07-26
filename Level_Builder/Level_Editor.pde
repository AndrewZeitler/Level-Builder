
class Level_Editor {

  int[][] grid = new int[128][72];

  int mx, my;
  int prevx, prevy = -1;

  int camX = 0;
  int camY = 0;
  int prevCamX = 0;
  int prevCamY = 0;

  int translateX = 0; 
  int translateY = 0;

  int px = 64;
  int py = 36;

  float zoom = 0.5;
  float prevZoom = 0.5;
  int selected = 1;
  int size = 20;
  
  boolean held = false;
  boolean inventory = false;
  boolean setting = false;
  boolean lines = false;
  boolean game = false;
  boolean menu = false;

  //Objects
  Button settings, exit, back, save, load, play;
  Events event;
  Save_Game saveFile;
  Load_Game loadFile;
  
  //Images
  PImage[] invImage = new PImage[32];
  PImage[] image = new PImage[32];
  PImage background = loadImage("Game Images/background4.png");

  PFont invFont;
  
  //Constructor
  Level_Editor(Events setEvent, Textures t) {

    for (int x = 0; x < 128; x++) {
      for (int y = 0; y < 72; y++) {
        grid[x][y] = 0;
      }
    }

    event = setEvent;
    invImage = t.getInvImage();
    image = t.getImage();
    image(background, 0, 0);
  }

  boolean switchState(boolean state) {
    if (state) {
      return false;
    } else {
      return true;
    }
  }

  void update() {
    eventHandle();
    buttons();
    draw();
  }



  //////////////////////////Draw//////////////////////////////////

  void draw() {
    //Control camera
    background(255);
    scale(zoom);
    image(background, camX, camY);
    translate(camX, camY);
    //Lines for if grid is on
    if (lines) {
      stroke(0);
      linesDraw();
    }
    //Loop through grid and display pictures accordingly
    for (int x = 0; x < 128; x++) {
      for (int y = 0; y < 72; y++) {
        int block = grid[x][y];
        if (block != 0 && block != 22) {
          try {
            image(image[block], x * size, y * size);
          } 
          catch (Exception e) {}
        } else if (block == 22) {
          stroke(0);
          strokeWeight(2);
          noFill();
          rect(x * size, y * size, size - 2, size - 2);
          noStroke();
        }
      }
    }
    
    //Draw player
    fill(0);
    rect(px * size, py * size, size, size * 2);

    noStroke();
    
    //If inventory is open
    if (inventory) {
      inventoryDraw();
    }
    //If setting menu is open
    if (setting) {
      settingsDraw();
    }
    //Set previous mouse location after loop is done
    prevx = mouseX;
    prevy = mouseY;
  }
  
  //Draw lines to fit grid sections
  void linesDraw() {
    for (int x = 1; x < 129; x++) {
      line(x * size, 0, x * size, height * 2);
    }
    for (int y = 1; y < 73; y++) {
      line(0, y * size, width * 2, y * size);
    }
  }
  
  //Draw inventory boxes and images accordingly
  void inventoryDraw() {

    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 4; y++) {
        fill(20, 50, 200, 60);
        rect(10 + 320 * x, 10 + 320 * y, 300, 300, 7);
        int block = x + y * 8;
        try {
          image(invImage[block], 20 + 320 * x, 20 + 320 * y);
        } catch(Exception e) {}

        if (block == 22) {
          stroke(0);
          strokeWeight(10);
          noFill();
          rect(20 + 320 * x, 20 + 320 * y, 280, 280, 10);
          noStroke();
        }
      }
    }
    
    //Fill yellow rectangle for the selected block
    int x = selected % 8;
    int y = selected / 8;
    fill(255, 233, 2, 60);
    rect(10 + 320 * x, 10 + 320 * y, 300, 300, 7);

    settings.update();
  }
  
  //Update buttons for the settings
  void settingsDraw() {

    fill(20, 50, 200, 60);
    rect(80, 80, 2400, 1280, 7);

    back.update();
    save.update();
    load.update();
    play.update();
    exit.update();
  }
  
  //Check buttons to see if they are clicked on at some point and act accordingly
  void buttons() {
    
    if (inventory) {

      if (settings.getClicked()) {

        setting = true;
        inventory = false;    
        back = new Button(width, 300, "Back To Game", 80, event);
        save = new Button(width, 500, "Save Level", 80, event);
        load = new Button(width, 700, "Load Level", 80, event);
        play = new Button(width, 900, "Play Level", 80, event);
        exit = new Button(width, 1100, "Exit To Menu", 80, event);
      }
    } 
    if (setting) {

      if (back.getClicked()) {
        setting = false;
      }
      if (save.getClicked()) {
        saveFile = new Save_Game(grid, px, py);
        saveFile.save();
        save.setClicked(false);
      }
      if (load.getClicked()) {
        int choice = JOptionPane.showConfirmDialog(null, "If you load another file then you may lose your progress. Are you sure you want to continue?");

        if (choice == 0) {
          loadFile = new Load_Game();
        }

        load.setClicked(false);
      }

      if (play.getClicked()) {
        game = true;
      }

      if (exit.getClicked()) {
        int choice = JOptionPane.showConfirmDialog(null, "If you quit now then you may lose your progress. Are you sure you want to continue?");
        
        if(choice == 0){
          menu = true;
        }
        
      }
    }
  }

  ////////////////////////////////Events///////////////////////////////////////////////

  void eventHandle() {
    //Checks all events


    mouseWheel();

    if (mousePressed == true) {
      if (mouseButton == LEFT) {
        leftClickHandle();
      } else {
        rightClickHandle();
      }
    }

    if (keyPressed == true && held == false) {
      keyHandle();
    } else if (!keyPressed) {
      held = false;
    }
  }

  void leftClickHandle() {
    try {
      //If neither the inventory or setting menu is open, divide the mouse x and y position accordingly
      if (!inventory && !setting) {
        
        mx = int(mouseX / 20);
        my = int(mouseY / 20);

        mx = int((mouseX - camX * zoom) / (size * zoom));
        my = int((mouseY - camY * zoom) / (size * zoom));

        if (selected == 1) {
          if (grid[mx][my] == 0 && grid[mx][my + 1] == 0) {
            px = mx;
            py = my;
          }
        } else {
          if ((mx == px && my == py) || (mx == px && my == py + 1)) {
          } else {  
            grid[mx][my] = selected;
          }
        }
        //Handles inventory clicking
      } else if (inventory) {
        mx = mouseX / 160;
        my = mouseY / 160;
        
        if (mx + my * 8 < 32) {
          selected = mx + my * 8;
        }
      }
    } 
    catch(Exception e) {
    }
  }
  //Right click for the player to zoom in and control the camera
  void rightClickHandle() {
    mx = mouseX;
    my = mouseY;

    translateX = int((mx - prevx) / zoom);
    translateY = int((my - prevy) / zoom);

    camX += translateX;
    camY += translateY;

    camCheck();
  }
  //Checks what keys are being pressed to open inventory
  void keyHandle() {
    //Opens inventory
    if (event.getEnter()) {
      if (!setting) {

        event.setEnter(false);
        camX = 0; 
        camY = 0; 
        zoom = 0.5;
        settings = new Button(width, height * 2 - 50, "Settings", 80, event);
        inventory = switchState(inventory);
      } else if (setting) {

        event.setEnter(false);
        setting = false;
      }
    }
    //Displays grid lines
    if (event.getGrid()) {
      event.setGrid(false);
      lines = switchState(lines);
      println(lines);
    }

    held = true;
  }
  //Makes sure camera x and y positions are within bounds
  void camCheck() {
    if (-camX < 0) {
      camX = 0;
    } else if (-camX + 1280 / zoom > (1280 * 2)) {
      camX = int((-1280 * 2) + 1280 / zoom);
    }

    if (-camY < 0) {
      camY = 0;
    } else if (-camY + 720 / zoom > (720 * 2)) {
      camY = int((-720 * 2) + 720 / zoom);
    }
  }
  //Zooms if the mousewheel is being scrolled
  void mouseWheel() {
    float e = event.getWheel() / 4.0;
    event.setWheel(0);
    if (!inventory && !setting) {
      zoom = zoom + e;
      if (zoom < 0.5) {
        zoom = 0.5;
      } else if (zoom > 5) {
        zoom = 5;
      }

      camCheck();
    }
  }
  //Setters and getters
  void setGrid(int[][] set) {
    grid = set;
  }

  int[][] getGrid() {
    return grid;
  }

  boolean getMenu() {
    return menu;
  }

  boolean getGame() {
    return game;
  }

  int getPX() {
    return px;
  }

  int getPY() {
    return py;
  }

  void setPX(int set) {
    px = set;
  }

  void setPY(int set) {
    py = set;
  }
}