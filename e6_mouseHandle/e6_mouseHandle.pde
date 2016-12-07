//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PCircle> cList = new ArrayList<PCircle>();
ArrayList<PRect> boundaries = new ArrayList<PRect>();
PImage img;
int itemNum = 30;

Handle handle;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity

  img = loadImage(dataPath("v1.png")); //load a png

  for (int i = 0; i < itemNum; i++) {
      Vec2 linear_v = new Vec2(random(-10, 10), random(-10, 10));
      float angle_v = random(-1, 1);
      PCircle c = new PCircle((i%6*2+1)*width/12, ((i/6)+1)*height/8, width/15, 0, linear_v, angle_v);
      c.setFillColor(color(255, 0));
      c.setStrokeColor(color(255, 0));
      c.addImage(img); //attach the image to a PCircle
      c.setBounce(0.2); //setDifferentBounciness
      c.setFriction(1); //setDifferentBounciness
      cList.add(c);
    }
  
  boundaries.add(new PRect(width/2, height-10/2, width, 10, true));
  boundaries.add(new PRect(width/2, 10/2, width, 10, true));
  boundaries.add(new PRect(width-10/2, height/2, 10, height, true));
  boundaries.add(new PRect(10/2, height/2, 10, height, true));
  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.setFriction(1);
    wall.setBounce(0);
  }
  
  handle = new Handle();
}

void draw() {
  background(255);
  box2d.step(); //step through time!
  handle.update(mouseX,mouseY);//update mouse position
  
  for (int i = cList.size()-1; i>=0; i--) {
    PCircle c = cList.get(i);
    c.displayImage();
  }
  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.display();
  }
  
  handle.display();
}

void keyReleased() {
  if (key == ENTER) {
    for (int i = cList.size()-1; i>=0; i--) {
      PCircle c = cList.get(i);
      c.killBody();
      cList.remove(i);
    }
    for (int i = 0; i < itemNum; i++) {
      Vec2 linear_v = new Vec2(random(-10, 10), random(-10, 10));
      float angle_v = random(-1, 1);
      PCircle c = new PCircle((i%6*2+1)*width/12, ((i/6)+1)*height/8, width/15, 0, linear_v, angle_v);
      c.setFillColor(color(255, 0));
      c.setStrokeColor(color(255, 0));
      c.addImage(img); //attach the image to a PCircle
      c.setBounce(0.2); //setDifferentBounciness
      c.setFriction(1); //setDifferentBounciness
      cList.add(c);
    }
  }
}

void mouseReleased() {
  handle.destroy();
}

// When the mouse is pressed we. . .
void mousePressed() {
  // Check to see if the mouse was clicked on the box
  for (PObject obj : cList) {
    if (obj.contains(mouseX, mouseY)) {
      // And if so, bind the mouse location to the box with a spring
      handle.bind(mouseX, mouseY, obj, 50000, 5, 1);
      handle.setVisual(color(255, 0, 0), 1);
    }
  }
}