
class Events{
  float wheel;
  boolean enter; 
  boolean grid;
  boolean pressed;
  boolean escape;
  boolean jump;
  boolean right;
  boolean left;
  
  Events(){
    wheel = 0;
    enter = false;
    grid = false;
    pressed = false;
    escape = false;
    jump = false;
    right = false;
    left = false;
  }
  
  //Setters and getters to store events for other objects to handle
  
  void setEnter(boolean set){
    enter = set;
  }
  
  void setGrid(boolean set){
     grid = set;
  }
  
  void setWheel(float set){
    wheel = set;
  }
  
  void setPressed(boolean set){
    pressed = set; 
  }
  
  void setJump(boolean set){
    jump = set;
  }
  
  void setLeft(boolean set){
    left = set; 
  }
  
  void setRight(boolean set){
    right = set; 
  }
  
  boolean getEscape(){
    return escape; 
  }
  
  boolean getEnter(){
    return enter;
  }
  
  boolean getGrid(){
     return grid;
  }
  
  float getWheel(){
    return wheel;
  }
  
  boolean getPressed(){
    return pressed; 
  }
  
  boolean getJump(){
    return jump; 
  }
  
  boolean getLeft(){
    return left;
  }
  
  boolean getRight(){
     return right;
  }

}