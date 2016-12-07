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
int itemNum = 6;

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
    c.setBounce(i*0.2); //setDifferentBounciness
    cList.add(c);
  }
  floor = new PRect(width/2, height-10/2, width, 10, true); // Add a floor
  //floor.setBounce(1); //setDifferentBounciness
}

void draw() {
  background(255);
  box2d.step(); //step through time!

  for (int i = cList.size()-1; i>=0; i--) {
    PCircle c = cList.get(i);
    c.displayImage();
  }
  floor.display(); //draw floor

  fill(0);
  textSize(14);
  textAlign(CENTER);
  text("Bounciness=",width/2, height/9);
  for (int i = 0; i < itemNum; i++) { 
    text(nf(i*.2, 0, 1), (i*2+1)*width/12, height/6);
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
      c.setBounce(i*0.2); //setDifferentBounciness
      cList.add(c);
    }
  }
}