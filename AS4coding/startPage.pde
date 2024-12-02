class startPage{
  PImage background;
  void start(){
    background = loadImage("bg.png");
   image(background,0,0);
   background.resize(400,400);
   image(background,0,0); 
   
   fill(255);
   rect(150,200,100,50);
   fill(255,80,190);
   textSize(52);
   text("Stacking Cakes",45,107);
   fill(0);
   textSize(35);
   text("Play",169,235);
  }
}
