//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

// A reference to our box2d world
Box2DProcessing box2d;

// A list for all of our rectangles
ArrayList<Box> boxes;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;


void setup() {
  size(500,500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  // We are setting a custom gravity
  box2d.setGravity(0, -50);

  // Create ArrayLists  
  boxes = new ArrayList<Box>();
  
  // Add a bunch of fixed boundaries
  boundaries = new ArrayList<Boundary>();
  
  //Without angle
  boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
  boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));
  
  //With angle
  float angleRad = radians(30); //translate degrees to radian
  //boundaries.add(new Boundary(width/4,height-50,width/2-50,10,-angleRad));
  //boundaries.add(new Boundary(3*width/4,height-100,width/2-50,10,angleRad));
  color colorBoundary = color(random(0,255),random(0,255),random(0,255));
  for(Boundary b: boundaries){
    b.setVisual(colorBoundary,color(0),1);
    //b.setMaterial(1,1,1);
  }
}

void draw() {
  background(255);
  
  // We must always step through time!
  box2d.step();

  // Boxes fall from the top every so often
  if (mousePressed){ //generate only if a mouse button is pressed
    Box p = new Box(mouseX, mouseY, 10, 10);
    color colorBox = color(random(0,255),random(0,255),random(0,255));
    p.setVisual(colorBox, color(0), 1);
    //p.setMaterial(1,1,1);
    boxes.add(p);
  }

   //Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  //// Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}