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

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world
  
  box2d.setGravity(0, -50); //a custom gravity

  c = new PCircle(width/2, height/4, width/10);
  //c.setFillColor(color(255,0,0));
  //c.setStrokeColor(color(0));
  //c.setStrokeWeight(1);

  floor = new PRect(width/2, height-10/2, width, 10, true); // Add a floor
  //floor.setFillColor(color(255,0,0));
  //floor.setStrokeColor(color(0));
  //floor.setStrokeWeight(1);
}

void draw() {
  background(255);
  box2d.step(); //step through time!
  
  c.display();     //draw ball
  floor.display(); //draw floor
}

void keyReleased() {
  if (key == ENTER) {
    c.killBody();
    c = new PCircle(width/2, height/4, width/10);
  }
}