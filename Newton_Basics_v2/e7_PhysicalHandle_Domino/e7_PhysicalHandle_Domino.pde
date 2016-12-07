//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PRect> rList = new ArrayList<PRect>();
ArrayList<PRect> boundaries = new ArrayList<PRect>();
PImage img;
int itemNum = 15;

Handle handle;
PCircle tool;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity

  img = loadImage(dataPath("v1.png")); //load a png

  for (int i = 0; i < itemNum; i++) { 
    PRect r = new PRect((i*2+1)*width/35, (height-10/2)-height/20, width/40, height/10);
    r.setBounce(0); //setDifferentBounciness
    r.setFriction(1); //setDifferentBounciness
    rList.add(r);
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
  tool = new PCircle(width-10, (height-10/2)-height/20, 30);
}

void draw() {
  background(255);
  box2d.step(); //step through time!
  handle.update(mouseX, mouseY);//update mouse position

  for (int i = rList.size()-1; i>=0; i--) {
    PRect r = rList.get(i);
    r.display();
  }

  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.display();
  }

  tool.display();

  handle.display();
}

void keyReleased() {
  if (key == ENTER) {
    for (int i = rList.size()-1; i>=0; i--) {
      PRect r = rList.get(i);
      r.killBody();
      rList.remove(i);
    }
    for (int i = 0; i < itemNum; i++) {
      PRect r = new PRect((i*2+1)*width/(itemNum*2), (height-10/2)-height/20, width/40, height/10);
      //r.setFillColor(color(255, 0));
      //r.setStrokeColor(color(255, 0));
      r.setBounce(0); //setDifferentBounciness
      r.setFriction(1); //setDifferentBounciness
      rList.add(r);
    }
  }
}

void mouseReleased() {
  handle.destroy();
}

// When the mouse is pressed we. . .
void mousePressed() {
  if (tool.contains(mouseX, mouseY)) {
    // And if so, bind the mouse location to the box with a spring
    handle.bind(mouseX, mouseY, tool, 50000, 5, 1);
    handle.setVisual(color(255, 0, 0), 1);
  }
}