class startPage{
  PImage background;
  PImage[] cloud;

  PVector[] cloudVelocity;
  PVector[] cloudPosi;
  int cloudNumber = 3;
  
  startPage(){
    cloud = new PImage[cloudNumber];
    cloudPosi = new PVector[cloudNumber];
    cloudVelocity = new PVector[cloudNumber];
    
     
     cloudPosi[0] = new PVector(20,0); 
     cloudPosi[1] = new PVector(-167,81); 
     cloudPosi[2] = new PVector(195,136);
     
     cloudVelocity[0] = new PVector(0.5,0);
     cloudVelocity[1] = new PVector(0.5,0);
     cloudVelocity[2] = new PVector(0.5,0);
  }
  void init(){
    cloud[0] = loadImage("cloud_shape2_1.png");   
    cloud[1] = loadImage("cloud_shape2_2.png");
    cloud[2] = loadImage("cloud_shape2_3.png");
    
     cloud[0].resize(201,85);
     cloud[1].resize(225,85);
     cloud[2].resize(156,62); 
  }
  void start(){
    background = loadImage("bg.png");
   background.resize(400,400);
   image(background,0,0); 
   
   cloudDisplay();
   cloudMove();
   
   fill(255);
   rect(150,200,100,50);
   fill(255,80,190);
   textSize(52);
   text("Stacking Cakes",45,107);
   fill(0);
   textSize(35);
   text("Play",169,235);
   
   
   
   
   
  }
  
  void cloudDisplay(){
    for(int i = 0; i < cloudNumber;i++){
     image(cloud[i],cloudPosi[i].x,cloudPosi[i].y); 
    }
  }
  
  void cloudMove(){
   for(int i =0; i < cloudNumber; i++){
    cloudPosi[i].add(cloudVelocity[i]); //cloude move to right
    
    if(cloudPosi[i].x>width+50){
      cloudPosi[i].x = -cloud[i].width;//When the cloud exceeds the right boundary, it reappears from the left
    }
   }
  }
}
