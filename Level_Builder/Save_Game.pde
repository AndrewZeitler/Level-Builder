
import javax.swing.JOptionPane;
import java.util.List;
//Save game object
class Save_Game{
  int grid[][];
  int x, y;
  //Path for the basic saves folder
  String path = "C:/Users/Andrew/Documents/Processing/Culminating_Activity/Saves/";
  //Save game constuctor
  Save_Game(int[][] setGrid, int px, int py){
     grid = setGrid;
     x = px;
     y = py;
  }
  
  void save(){
    boolean created = false;
    String text = "Enter save name.";
    String input;
    File file = new File("");
    //Take input from user for file name
    do{
     input = JOptionPane.showInputDialog(text);
     
       try{
         file = new File(path + input + ".txt");
         created = true;
       } catch (Exception e){
         text = "Error creating file. Please enter another name.";
       }
    }while(!created);
    //Data string array to store all our grid and player data
    String[] data = new String[grid.length * grid[0].length];
    //Iterates through our grid and adds it to the data array
    for(int x = 0; x < grid.length; x++){
      for(int y = 0; y < grid[0].length; y++){
        data[x * grid[0].length + y] = str(grid[x][y]);
      }
    }
    //Add the player's x and y locations to the data array
    data[data.length - 2] = str(x);
    data[data.length - 1] = str(y);
    //If the file exists, let them know they will be overwritting it
    if(file.exists()){
       int choice = JOptionPane.showConfirmDialog(null, "This file already exists. Are you sure you want to overwrite it?");
       if(choice == 0){
         //Save
         createOutput(file);
         saveStrings(file, data);        
       }
    } else {
      //Save
      createOutput(file);
      saveStrings(file, data);   
    }
    
  }
  
}