//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<Box> boxes;
Surface surface;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // We are setting a custom gravity
  box2d.setGravity(0, -50);

  // Create ArrayLists  
  boxes = new ArrayList<Box>();

  // Create the surface
  ArrayList<Vec2> vertices = new ArrayList<Vec2>();
  vertices.add(new Vec2(0, height/2));
  vertices.add(new Vec2(width/2, height/2+50));
  vertices.add(new Vec2(width, height/2));
  vertices.add(new Vec2(width, height));
  vertices.add(new Vec2(0, height));
  surface = new Surface(vertices);
  color colorSurface = color(random(0,255),random(0,255),random(0,255));
  surface.setVisual(colorSurface, color(0),1);
  surface.setMaterial(1,1,1);
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

  // Draw the surface
  surface.display();

  //// Display all the boxes
  for (Box b : boxes) {
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