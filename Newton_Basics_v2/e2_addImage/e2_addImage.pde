//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
PCircle c;
PRect floor;
PImage img;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world
  
  box2d.setGravity(0, -50); //a custom gravity
  
  img = loadImage(dataPath("v1.png")); //load a png
  
  c = new PCircle(width/2, height/4, width/10);
  //c.setFillColor(color(255,0));
  //c.setStrokeColor(color(255,0));
  
  c.addImage(img); //attach the image to a PCircle 

  floor = new PRect(width/2, height-10/2, width, 10, true); // Add a floor
}

void draw() {
  background(255);
  box2d.step(); //step through time!
  
  //c.display();     //draw ball
  c.displayImage();
  floor.display(); //draw floor
}

void keyReleased() {
  if (key == ENTER) {
    c.killBody();
    c = new PCircle(width/2, height/4, width/10);
    c.addImage(img); //attach the image to a PCircle 
  }
}
