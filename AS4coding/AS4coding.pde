ArrayList<Rect> down;//Rectangles that have fallen and stacked together

int rectWidth= 200;//Initial rectangle width
int maxRectCount = 10;//Generate up to 10 rectangles

boolean dropping = false;//Whether rect is in the falling state
boolean gameOver = false;//Determine if the game is over
boolean hintText = false;//Hint text, disappears after the game ends
float iniSpeed = 3;//Set up initial speed, the speed behind is getting faster and faster

Rect currentRect;//The rect currently moving

void setup(){
 size(400,400); 
 noStroke();
 

 down = new ArrayList<Rect>();
 currentRect = new Rect(0,0,rectWidth,iniSpeed);//Creat initial rect
}

void draw(){
background(106,151,188);

for(int i=0;i<down.size();i++)  {  //This loop show the rect that has fallen
  Rect rect = down.get(i);
  rect.display();
}

 if(!gameOver){ // If the game is not over, 
   hintText();  //display the prompt text,
  currentRect.move();  //display and move the current rect
  currentRect.display();
  
 }
  //Let rects drop down
  if(dropping){  
    currentRect.drop(down.size()); //rect start dropping
    if(currentRect.pos.y >= 400 - (down.size()+1)*30){ //Check whether the current rect falls to the position where it should be stacked
      if(!down.isEmpty()){  ////https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html//Check if have any dropped rect
        Rect previousRect = down.get(down.size()-1);
        currentRect.trimExcess(previousRect);//cut the excess part
      }
      down.add(currentRect);//Current rect add to already dropped list
      dropping = false; 
      
      if(down.size() >=maxRectCount || currentRect.w <=0){   //If the number of rects exceeds 10 or the width is less than 0, 
      gameOver = true;                                      //that is, it fails to overlap the previous rectangle, the game ends.
     //noLoop(); 
     
  }
  else{
    rectWidth = (int)currentRect.w;//Use the new rect (after being cut off)
    iniSpeed += 0.7;  //Move faster
    currentRect = new Rect(0,0,rectWidth,iniSpeed);//Creat new rect through class Rect
   
   }
  }
 }
  if(gameOver){ //If the game is over, display the new background of the game and the text of the game over
   gameResult();
   fill(0);
   textSize(24);
   int topCakeCount = down.size();//Rect count
   float finalWidth = down.get(down.size()-1).w;
   text(topCakeCount +"Layer Cake! "+"Final Width:"+ finalWidth+"!", 60, height / 8);

 }
 
}

void mousePressed(){
  if(!dropping&&!gameOver){
   dropping = true; //Start dropping
  }

}
void gameResult(){
  
  //Drawed rainbaow curtain
  fill(253,90,109);
 arc(0,0,400,140,0,PI/2); 
 arc(400,0,400,140,PI/2,PI);
 fill(253,153,109);
 arc(0,0,346,100,0,PI/2); 
 arc(400,0,346,100,PI/2,PI);
 fill(253,234,109);
 arc(0,0,280,60,0,PI/2); 
 arc(400,0,280,60,PI/2,PI); 
 fill(168,255,109);
 arc(0,0,211,28,0,PI/2); 
 arc(400,0,201,29,PI/2,PI);  
 
 //Draw starts
 for(int i = 0; i < 6; i++){   //Using for loop
   
  float startX = random(width);  //The positions of the stars appear randomly
  float startY = random(height);
  float size = random(10,30);//The size is also random
  
  drawStart(startX,startY,size); 
 }
 
}
void hintText(){  //The text after the game ends, used to explain the player's game results
  textSize(20);
  String s ="Click the mouse to drop the cake, and see how big the cake can be.";
  fill(0);
  text(s,68,40,280,415);
  
}

void drawStart(float x, float y, float size){
  //I set the center coordinates of the star to (x, y) and the overall size to float size.
  
  beginShape();  //This is the formula for the positions of the vertices and the center of a star
  fill(255,255,0);
  vertex(x, y - size / 2);     
  vertex(x + 0.15 * size, y - 0.15 * size);  
  vertex(x + size / 2, y);          
  vertex(x + 0.15 * size, y + 0.15 * size); 
  vertex(x, y + size / 2);  
  vertex(x - 0.15 * size, y + 0.15 * size);  
  vertex(x - size / 2, y); 
  vertex(x - 0.15 * size, y - 0.15 * size); 
  endShape(CLOSE); 

}
