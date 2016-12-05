//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

// A reference to our box2d world
Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Pair> pairs;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -50);

  // Create ArrayLists  
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10, 0));
  boundaries.add(new Boundary(3*width/4, height-50, width/2-50, 10, 0));
  boundaries.add(new Boundary(width-5, height/2, 10, height, 0));
  boundaries.add(new Boundary(5, height/2, 10, height, 0));

  // Create ArrayLists  
  pairs = new ArrayList<Pair>();
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Display all the boxes
  for (Pair p : pairs) {
    p.display();
  }

  //Display all the boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }
}

void mousePressed() {
  Particle p1 = new Particle(mouseX, mouseY);
  p1.setVisual(color(random(0, 255), random(0, 255), random(0, 255)), color(0), 1);
  //p1.setMaterial(1,1,1);
  Particle p2 = new Particle(mouseX, mouseY);
  p2.setVisual(color(random(0, 255), random(0, 255), random(0, 255)), color(0), 1);
  //p2.setMaterial(1,1,1);
  Pair p = new Pair(p1, p2, 50);
  p.setVisual(color(255,0,0), 1);
  pairs.add(p);
  
  Particle p3 = new Particle(mouseX, mouseY);
  //p3.setVisual(color(random(0, 255), random(0, 255), random(0, 255)), color(0), 1);
  //p3.setMaterial(1,1,1);
  //pairs.add(new Pair(p1, p3, 50));
  //pairs.add(new Pair(p3, p2, 50));
}