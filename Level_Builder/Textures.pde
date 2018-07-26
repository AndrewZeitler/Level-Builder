class Textures{
  PImage[] invImage = new PImage[32];
  PImage[] image = new PImage[32];
  
  String text = "Game Images/";
  
  Textures(){
    createTextures();
  }
  
  //Creates all the images for the game to use
  void createTextures(){
    addPictures(text + "Eraser.png", 0);
    addPictures(text + "Cursor.png", 1);
    addPictures(text + "Coin.png", 2);
    addPictures(text + "RedCoin.png", 3);
    addPictures(text + "Live.png", 4);
    addPictures(text + "Block.png", 5);
    addPictures(text + "BreakableBlock.png", 6);
    addPictures(text + "SideSpring.png", 7);
    addPictures(text + "UpSpring.png", 8);
    addPictures(text + "LeftSpeed.png", 9);
    addPictures(text + "RightSpeed.png", 10);
    addPictures(text + "UpSpeed.png", 11);
    addPictures(text + "DownSpeed.png", 12);
    addPictures(text + "LeftDoor.png", 13);
    addPictures(text + "RightDoor.png", 14);
    addPictures(text + "UpDoor.png", 15);
    addPictures(text + "DownDoor.png", 16);
    addPictures(text + "LeftSpike.png", 17);
    addPictures(text + "RightSpike.png", 18);
    addPictures(text + "UpSpike.png", 19);
    addPictures(text + "DownSpike.png", 20);
    addPictures(text + "AllSpike.png", 21);
    addPictures(text + "Checkpoint.png", 23);
    addPictures(text + "Goal.png", 24);

  }
  
  //Method to create the image, resize it, and add it to image array
  void addPictures(String text, int index){
    PImage i = loadImage(text);
    i.resize(280, 280);
    invImage[index] = i;
    PImage I = loadImage(text);
    I.resize(20, 20);
    image[index] = I;
    
  }
  //Getters
  PImage[] getInvImage(){
    return invImage; 
  }
  
  PImage[] getImage(){
    return image; 
  }
  
}