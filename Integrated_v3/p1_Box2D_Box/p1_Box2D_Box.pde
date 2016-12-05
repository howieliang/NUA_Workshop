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


void setup() {
  size(500,500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  // We are setting a custom gravity
  //box2d.setGravity(0, -10);

  // Create ArrayLists  
  boxes = new ArrayList<Box>();
}

void draw() {
  background(255);
  
  // We must always step through time!
  box2d.step();

  // Boxes fall from the top every so often
  if (random(1) < 1) { //generate with 100% posibility
  //if (random(1) < 0.2) { //generate with 20% posibility
  //if (mousePressed){ //generate only if a mouse button is pressed
  //if (mousePressed && (random(1) < 0.2)){ //generate in 20% posibility only if a mouse button is pressed 
    Box p = new Box(width/2, height/4); 
    //Box p = new Box(mouseX, mouseY); 
    //Box p = new Box(mouseX, mouseY, 10, 10);
    //Box p = new Box(mouseX, mouseY, 10, 10, false, new Vec2(0,20), 0);
    color colorBox = color(random(0,255),random(0,255),random(0,255));
    p.setVisual(colorBox, color(0), 1);
    
    boxes.add(p);
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