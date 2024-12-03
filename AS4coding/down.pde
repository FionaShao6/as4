//import processing.sound.*;//https://processing.org/reference/libraries/sound/SoundFile.html


class Rect{
  PVector pos;//Rect's x and y(position)
  PVector velocity;//Left and right movement speed
  float w;//rect's width
 
  float rectHeight=30;//I fixed the each rect's height=30
  color  randColor; //Set random color
  
  // SoundFile dropMusic;
  
  
  Rect(float tempX,float tempY, float tempW,float tempSpeed){
    pos = new PVector(tempX, tempY);//Use PVector to store the site
   velocity = new PVector(tempSpeed,0);
   w=tempW;
   
   randColor= color(random(217,255), random(1,164), random(112,195));//Setting color(pink)
   
 }
void move(){ //The rect at the top moves left and right, hits the border and bounces back
  if(!dropping){
   pos.add(velocity);
   if(pos.x>width-w || pos.x <0){
    velocity.x*=-1; 
   } 
  }
}
 void display(){
   fill(randColor);
    rect(pos.x,pos.y,w,rectHeight);
   
   //draw cream on the cake
   strokeWeight(1);
   stroke(255);
   beginShape();
    for (int i = 0; i < 9; i++) {
   float arcX = pos.x +i*(w/9)+10; //Divide arc into 9
   float arcY = pos.y+10;
   
   float arcRightEdge = arcX+10;// The right edge of arc
   if ( arcRightEdge >pos.x+w){
    arcX-= 11;
   }
   
    fill(255);
    arc(arcX,arcY,20,10,0,PI); 
    
    noStroke();
    rect(pos.x,pos.y,w,10);
    } 
     endShape();
 }




 
  void drop(int stackCount){
    pos.y +=velocity.y;
    velocity.y =5; //Drop speed
   if(pos.y > height - (stackCount+1)*30){/////if a rect exceeds the height of the previous rect during the falling process
    pos.y = height - (stackCount+1)*30;     //then fix its position to the height of the previous rect - 30
    velocity.y=0;
    //dropMusic.play();
  }
     
 }
  
 void trimExcess(Rect previousRect){   //https://processing.org/reference/Table_trim_.html
   float preLeftEdge = previousRect.pos.x;   //Indicates the leftmost and rightmost sides of previous rect
   float preRightEdge = previousRect.pos.x + previousRect.w;
   
   float  currentLeftEdge= pos.x;  //Indicates the leftmost and rightmost sides of current rect
   float  currentRightEdge= pos.x + w;
   //Declaring variables
   
   if(currentLeftEdge< preLeftEdge){     //If the left side of the current rect exceeds the left side of the previous rect, trim it
     float excessLeft = preLeftEdge- currentLeftEdge; 
     pos.x +=excessLeft;  //Change x
     w-=excessLeft;   //Reduce Width, so that looks like the extra part has been cut off
     
   }
   if(currentRightEdge> preRightEdge){    //Same as left way
     float excessRight =  currentRightEdge-preRightEdge;
     w-=excessRight;
     
   }
   if(w<0)w = 0;//Avoid w being negative
  }
  
}


  
