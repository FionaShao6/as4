ArrayList<Rect> down;//Rectangles that have fallen and stacked together
 ArrayList<Rect> allRects;

int rectWidth= 200;//Initial rectangle width
int maxRectCount = 100;//Generate up to 100 rectangles

boolean dropping = false;//Whether rect is in the falling state
boolean gameOver = false;//Determine if the game is over
boolean hintText = false;//Hint text, disappears after the game ends
boolean screenDwon = false;//Determine the statement of the screen down
boolean startPage = true;//determine the start page.
startPage page;
boolean restartPressed = false;//Determine whether the restart button is clicked
float iniSpeed = 3;//Set up initial speed, the speed behind is getting faster and faster
PImage restart;
PImage photo;
Rect currentRect;//The rect currently moving

void setup(){
 size(400,400); 
 
 restart = loadImage("26.png");//This is the restart button
 restart.resize(100,100);
 
 page = new startPage();
 page.init();
 photo = loadImage("bk2.jpg");
 noStroke();
 
 
 down = new ArrayList<Rect>();
 currentRect = new Rect(0,0,rectWidth,iniSpeed);//Creat initial rect
 
 allRects = new ArrayList<Rect>();


 
}
void shiftRectsDown(){
  for(int i =0; i<down.size(); i++){
    Rect rect = down.get(i);
    rect.pos.y +=30;//move down 30
  }
  if(dropping){
   currentRect.pos.y +=30; 
  }
 }

void draw(){
  if(startPage){
  page.start();
  }else{
     background(106,151,188);
  image(photo,0,0);
  photo.resize(400,400);
  image(photo,0,0);
  for(int i=0;i<down.size();i++)  {  //This loop show the rect that has fallen
  Rect rect = down.get(i);
  rect.display(); 
   }
  for (int i = 0; i < down.size(); i++) {
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
      
     if(down.size()>=7){
        allRects.add(down.remove(0));//delete the first rect,
        shiftRectsDown();
        
      }
      
      down.add(currentRect);//Current rect add to already dropped list
      dropping = false; 
      
      if(down.size() >=maxRectCount || currentRect.w <=0){   //If the number of rects exceeds 10 or the width is less than 0, 
      gameOver = true;                                      //that is, it fails to overlap the previous rectangle, the game ends.
     //noLoop(); 
     
  }
  else{
    rectWidth = (int)currentRect.w;//Use the new rect (after being cut off)
    iniSpeed += 0.4;  //Move faster
    currentRect = new Rect(0,0,rectWidth,iniSpeed);//Creat new rect through class Rect
   
   }
  }
 }
  if(gameOver){ //If the game is over, display the new background of the game and the text of the game over
   gameResult();
   fill(0);
   textSize(24);
   int topCakeCount = down.size()+allRects.size();//Rect count
   
   text(topCakeCount +" Layer Cake! ", 120, height / 8);

  }
 }
}
void mousePressed(){
  if(startPage){
   if(mouseX>150 && mouseX<250&&mouseY>200 &&mouseY<250){//the rect area
    startPage = false;//close the start page, begin to play
    dropping = false;
   }
  } else if(!dropping&&!gameOver){//If you are not on the start page and the game is not over
   dropping = true; //Start dropping
  }else if(gameOver){
   if (mouseX >150 && mouseX < 250 && mouseY >300 && mouseY < 400){
    restartGame(); 
   }
  }
}
void gameResult(){

 float totalHeight = 30 * down.size(); 
 float scaleFactor = 1;
if (totalHeight > 200) {
  scaleFactor = 300 / totalHeight; 
}

for (int i = 0; i < down.size(); i++) {
  Rect rect = down.get(i);
  rect.w *= scaleFactor; 
  rect.rectHeight *= scaleFactor;
}


totalHeight = 30 * down.size() * scaleFactor;


float startY = 200 - totalHeight / 2;


for (int i = 0; i < down.size(); i++) {
  Rect rect = down.get(i); 

  rect.pos.y = startY; 
  startY += -rect.rectHeight * scaleFactor; 
  rect.display(); 
}


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
 
 //Draw stars
 for(int i = 0; i < 6; i++){   //Using for loop
   
  float starX = random(width);  //The positions of the stars appear randomly
  float starY = random(height);
  float size = random(10,30);//The size is also random
  
  drawStar(starX,starY,size); 
 }
 image(restart,150,300);
}

void hintText(){  //The text after the game ends, used to explain the player's game results
  textSize(20);
  String s ="Click the mouse to drop the cake, and see how big the cake can be.";
  fill(0);
  text(s,68,40,280,415);
  
}

void drawStar(float x, float y, float size){
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

void restartGame(){
  allRects.clear();  // Clear all rectangles
   down.clear();  // Clear the dropped rectangle
  
  rectWidth = 200;  // Reset the initial width of the rectangle
  iniSpeed = 3;  // Reset initial speed
  
  gameOver = false;  // Reset game over flag
  dropping = false;  // Reset the rectangle drop flag
  
  currentRect = new Rect(0, 0, rectWidth, iniSpeed); 
  
}
