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
}

void draw() {
  background(255);
  box2d.step(); //step through time!

  for (int i = cList.size()-1; i>=0; i--) {
    PCircle c = cList.get(i);
    c.displayImage();
  }

  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.display();
  }
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