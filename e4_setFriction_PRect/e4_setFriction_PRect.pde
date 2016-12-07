//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PRect> rList = new ArrayList<PRect>();
PRect floor;
PImage img;
int itemNum = 6;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity

  img = loadImage(dataPath("v6.png")); //load a png

  for (int i = 0; i < itemNum; i++) { 
    PRect r = new PRect((i*2+1)*width/12, height/4, width/9, width/9);
    r.setFillColor(color(255, 0));
    r.setStrokeColor(color(255, 0));
    r.addImage(img); //attach the image to a PCircle
    r.setBounce(0); //setDifferentBounciness
    r.setFriction(1-i*.2); //setDifferentBounciness
    rList.add(r);
  }
  //floor = new PRect(width/2, height-10/2, 2*width, 10, radians(-2), true); // Add a floor
  floor = new PRect(width/2, height-10/2, 2*width, 10, radians(-10), true); // Add a floor
  floor.setFriction(1);
  floor.setBounce(0);
  //floor.setBounce(1); //setDifferentBounciness
}

void draw() {
  background(255);
  box2d.step(); //step through time!

  //c.display();     //draw ball
  for (PRect r : rList) {
    r.displayImage();
  }
  floor.display(); //draw floor

  fill(0);
  textSize(14);
  textAlign(CENTER);
  text("Friction=", width/2, height/9);
  for (int i = 0; i < itemNum; i++) { 
    text(nf(1-i*.2,1,1), (i*2+1)*width/12, height/6);
  }
}

void keyReleased() {
  if (key == ENTER) {
    for (int i = rList.size()-1; i>=0; i--) {
      PRect r = rList.get(i);
      r.killBody();
      rList.remove(i);
    }
    for (int i = 0; i < itemNum; i++) {
      PRect r = new PRect((i*2+1)*width/12, height/4, width/9, width/9);
      r.setFillColor(color(255, 0));
      r.setStrokeColor(color(255, 0));
      r.addImage(img); //attach the image to a PCircle
      r.setBounce(0); //setDifferentBounciness
      r.setFriction(1-i*.2); //setDifferentBounciness
      rList.add(r);
    }
  }
}