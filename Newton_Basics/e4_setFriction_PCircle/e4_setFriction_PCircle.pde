//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PCircle> cList = new ArrayList<PCircle>();
PRect floor;
PImage img;
int itemNum = 2;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity

  img = loadImage(dataPath("v1.png")); //load a png

  for (int i = 0; i < itemNum; i++) { 
    PCircle c = new PCircle((i*2+1)*width/12, height/4, width/12);
    c.setFillColor(color(255, 0));
    c.setStrokeColor(color(255, 0));
    c.addImage(img); //attach the image to a PCircle
    c.setBounce(0); //setDifferentBounciness
    c.setFriction(1-i); //setDifferentBounciness
    cList.add(c);
  }
  floor = new PRect(width/2, height-10/2, 2*width, 10, radians(-2), true); // Add a floor
  floor.setFriction(1);
  floor.setBounce(0);
  //floor.setBounce(1); //setDifferentBounciness
}

void draw() {
  background(255);
  box2d.step(); //step through time!

  //c.display();     //draw ball
  for (PCircle c : cList) {
    c.displayImage();
  }
  floor.display(); //draw floor

  fill(0);
  textSize(14);
  textAlign(CENTER);
  text("Friction=",width/2, height/9);
  for (int i = 0; i < itemNum; i++) { 
    text(1-i, (i*2+1)*width/12, height/6);
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
      PCircle c = new PCircle((i*2+1)*width/12, height/4, width/12);
      c.setFillColor(color(255, 0));
      c.setStrokeColor(color(255, 0));
      c.addImage(img); //attach the image to a PCircle
      c.setBounce(0); //setDifferentBounciness
      c.setFriction(1-i); //setDifferentBounciness
      cList.add(c);
    }
  }
}
