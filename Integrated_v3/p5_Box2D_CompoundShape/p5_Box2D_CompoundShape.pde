//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Baby> babies;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);

  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  babies = new ArrayList<Baby>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4,height-5,width/2-50,10,0));
  boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the people
  for (Baby b: babies) {
    b.display();
  }
  
  // people that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = babies.size()-1; i >= 0; i--) {
    Baby b = babies.get(i);
    if (b.done()) {
      babies.remove(i);
    }
  }
}

void mousePressed() {
  Baby b = new Baby(mouseX,mouseY);
  babies.add(b);
}