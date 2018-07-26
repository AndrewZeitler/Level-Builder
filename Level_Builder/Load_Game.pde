
class Load_Game{
  //Load game object just to save code space  
  Load_Game(){
    //Create file object and display the select file menu
    File file = new File("C:/Users/Andrew/Documents/Processing/Culminating_Activity/Saves/ ");
    selectInput("Select your file:", "fileSelected", file);
  }
  
}