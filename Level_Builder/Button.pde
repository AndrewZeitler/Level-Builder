class Button{
  Events event;
  
  int x, y, fontSize;
  String text;
  PFont font;
  
  boolean clicked;
  
  //Constructor
  Button(int setX, int setY, String setText, int setFontSize, Events setEvent){
    x = setX;
    y = setY;
    text = setText;
    
    fontSize = setFontSize;
    font = createFont("Impact", fontSize);
    
    event = setEvent;
  }
  
  //Update method for calling
  void update(){
     checkClick();
     draw();
  }
  
  void draw(){
    textFont(font);
    
    fill(0);
    if(hoverButton()){
      fill(255, 233, 0);
    }
    
    if(clickButton()){
      fill(216, 219, 30);
    }
    
   textAlign(CENTER);
    text(text, x, y);
  }
  
  //If the mouse is fully clicked within area
  void checkClick(){
    if(event.getPressed()){
      if(hoverButton()){
        clicked = true;
        event.setPressed(false);
      }
    }
  }
  
  //If the mouse is being held within area
  boolean clickButton(){
    if(hoverButton()){
      if(mousePressed){
        return true; 
      }
    }
    
    return false;
  }
  
  //If you hover mouse over the button
  boolean hoverButton(){
    //Scale accomates for the screen scale being at 0.5 during level editting
    int scale = fontSize / 40;
    if(mouseX > x / scale - textWidth(text) / 2 / scale && mouseX < x / scale + textWidth(text) / 2){
      if(mouseY > y / scale - fontSize / scale && mouseY < y / scale){
        return true;
      }
    }
    
    return false;
  }
  
  //Setters and getters
  
  boolean getClicked(){
    return clicked; 
  }
  
  void setClicked(boolean set){
    clicked = set;
  }
  
  
}