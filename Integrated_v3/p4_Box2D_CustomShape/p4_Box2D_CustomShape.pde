//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<CustomShape> polygons;
ArrayList<Vec2> edgeVertices;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // We are setting a custom gravity
  box2d.setGravity(0, -50);

  // Create ArrayLists  
  boundaries = new ArrayList<Boundary>();
  polygons = new ArrayList<CustomShape>();
  edgeVertices = new ArrayList<Vec2>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10, 0));
  boundaries.add(new Boundary(3*width/4, height-50, width/2-50, 10, 0));
  boundaries.add(new Boundary(width-5, height/2, 10, height, 0));
  boundaries.add(new Boundary(5, height/2, 10, height, 0));
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  //Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the shapes
  for (CustomShape cs : polygons) {
    cs.display();
  }
  
  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = polygons.size()-1; i >= 0; i--) {
    CustomShape cs = polygons.get(i);
    if (cs.done()) {
      polygons.remove(i);
    }
  }
  
  //Preview the drawing
  beginShape();
  fill(127,127);
  stroke(0);
  strokeWeight(2);
  for (int i = 0; i< edgeVertices.size(); i++) {
    vertex(edgeVertices.get(i).x, edgeVertices.get(i).y);
  }
  endShape();
}

void mouseDragged() {
  if (mouseX < width && mouseY < height) {
    Vec2 lastPoint = edgeVertices.get(edgeVertices.size()-1);
    if (dist(mouseX, mouseY, lastPoint.x, lastPoint.y)>30 &&  edgeVertices.size()<8) {
      edgeVertices.add(new Vec2(mouseX, mouseY));
    }
  }
}

void mousePressed() {
  edgeVertices.add(new Vec2(mouseX, mouseY));
}

void mouseReleased() {
  if (edgeVertices.size()>2) {
    float cx = 0;
    float cy = 0;
    for (int i = 0; i< edgeVertices.size(); i++) {
      cx += edgeVertices.get(i).x;
      cy += edgeVertices.get(i).y;
    }
    cx /= edgeVertices.size();
    cy /= edgeVertices.size();
    float kx = 0;
    float ky = 0;
    ArrayList<Vec2> edgeVertices_local = new ArrayList<Vec2>();
    for (int i = 0; i< edgeVertices.size(); i++) {
      kx = edgeVertices.get(i).x-cx;
      ky = edgeVertices.get(i).y-cy;
      edgeVertices_local.add(new Vec2(kx, ky));
    }
    
    color colorCustomShape = color(random(0,255),random(0,255),random(0,255));
    CustomShape cs = new CustomShape(cx, cy, edgeVertices_local);
    cs.setVisual(colorCustomShape, color(0), 1);
    //cs.setMaterial(1,1,1);
    polygons.add(cs);
    edgeVertices.clear();
  }
}