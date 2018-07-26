
class Block {

  Block() {
  }

  //side 1 is left, 2 is right, 3 is top, 4 is bottom

  void collideBlock(Player player, int block, int side, int bx, int by) {
   
    switch(block) {
      //Coin
    case 2: 
      player.addCoins(1);
      player.setGrid(bx / 20, by / 20, 0);
      break;
      //Red coin
    case 3: 
      player.addCoins(5);
      player.setGrid(bx / 20, by / 20, 0);
      break;
      //Extra life
    case 4:
      player.changeLives(1);
      player.setGrid(bx / 20, by / 20, 0);
      break;
      //Wall
    case 5:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Breakable Block
    case 6:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
        player.setGrid(bx / 20, by / 20, 0);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Left to Right Spring
    case 7:
      if (side == 1) {
        player.setXVel(-8);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(8);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Up to down Spring
    case 8:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(-10);
      } else if (side == 4) {
        player.setYVel(10);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Left Speed
    case 9:
      player.changeXVel(-0.5);
      break;
      //Right Speed
    case 10:
      player.changeXVel(0.5);
      break;
      //Up Speed
    case 11:
      player.changeYVel(-0.5);
      break;
      //Down Speed
    case 12:
      player.changeYVel(0.5);
      break;
      //One way left
    case 13:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      }
      break;
      //One way  right
    case 14:
      if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      }
      break;
      //One way top
    case 15:
      if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      }
      break;
      //One way bottom
    case 16:
      if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      }
      break;
      //Left Spike
    case 17:
      if (side == 1) {
        player.killPlayer();
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Right spike
    case 18:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.killPlayer();
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Up spike
    case 19:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.killPlayer();
      } else if (side == 4) {
        player.setYVel(player.getYVel() * -0.25);
        player.setY(by + 21);
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //Down spike
    case 20:
      if (side == 1) {
        player.setXVel(0);
        player.setX(bx - 17);
      } else if (side == 2) {
        player.setXVel(0);
        player.setX(bx + 20);
      } else if (side == 3) {
        player.setYVel(0);
        player.setY(by - 35);
      } else if (side == 4) {
        player.killPlayer();
      } else if(side == 0){
        player.setYVel(0);
        player.setY(by + 21); 
      }
      break;
      //All spike
    case 21:
      player.killPlayer();
      break;
      //Invisible block
    case 22:
      if(side == 4){
        player.setYVel(0);
        player.setY(by + 21); 
        player.setGrid(bx / 20, by / 20, 5);
      }
      break;
      //Checkpoint
    case 23:
      player.setXSpawn(bx);
      player.setYSpawn(by - 20);
      break;
    case 24:
      //End game
      player.setWin(true);
      break;
    case 25:

      break;
    case 26:

      break;
    case 27:

      break;
    case 28:

      break;
    case 29:

      break;
    case 30:

      break;
    case 31:

      break;
  }
}
}