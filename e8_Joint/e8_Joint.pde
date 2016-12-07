//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PRect> boundaries;
Handle handle;
PCircle tool;

PRect r1; 
PRect r2;
Joint joint;

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity
  
  boundaries = new ArrayList<PRect>();
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
  
  Vec2 anchor = new Vec2(width/2,height/2);
  r1 = new PRect(anchor.x, anchor.y   , 120, 10, false); 
  r2 = new PRect(anchor.x, anchor.y+20, 10 , 40, true);
  joint = new Joint (r1, r2, anchor, false, 4*PI, 40000);
  
  
  //r1 = new PRect(anchor.x, anchor.y   , 120, 10, true); 
  //r2 = new PRect(anchor.x, anchor.y+60, 10 , 120, false);
  //joint = new Joint (r1, r2, anchor, false, 4*PI, 40000);
  
  //joint = new Joint (r1, r2, anchor, false, 4*PI, 40000);
  //joint = new Joint (r1, r2, anchor, false, 4*PI, 40000, true, -PI/4, PI/4);
  joint.setVisual(color(0,255,0), color(0), 2);
}

void draw() {
  background(255);
  box2d.step(); //step through time!
  handle.update(mouseX, mouseY);//update mouse position

  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.display();
  }
  r1.display();
  r2.display();
  
  if (joint.motorOn()){
    joint.setFillColor(color(0,255,0));
  }else{
    joint.setFillColor(color(255,0,0));
  }
  joint.display();
  
  tool.display();

  handle.display();
}

void keyReleased() {
  if (key == ENTER) {
    joint.toggleMotor();  
  }
}

void mouseReleased() {
  handle.destroy();
}

// When the mouse is pressed we. . .
void mousePressed() {
  if (tool.contains(mouseX, mouseY)) {
    // And if so, bind the mouse location to the box with a spring
    handle.bind(mouseX, mouseY, tool, 5, 1);
    handle.setVisual(color(255, 0, 0), 1);
  }
}