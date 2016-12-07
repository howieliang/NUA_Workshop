//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<PRect> cList = new ArrayList<PRect>();
ArrayList<PRect> boundaries = new ArrayList<PRect>();
PImage img;
PImage photo;
int itemNum = 10;
int grid_r = 10;
int grid_h = 10;
int[] px; //storing the pixels of a image

void setup() {
  size(500, 500);
  box2d = new Box2DProcessing(this); //Initialize box2d physics
  box2d.createWorld(); //Create the world

  box2d.setGravity(0, -50); //a custom gravity

  img = loadImage(dataPath("v6.png")); //load a png
  photo = loadImage(dataPath("v6.png"));
  photo.resize(itemNum, itemNum);
  photo.loadPixels();
  px = photo.pixels;

  for (int i = 0; i < itemNum; i++) {
    for (int j = 0; j < itemNum; j++) {
      PRect c = new PRect((i%itemNum+0.5)*(width/itemNum)+5, (j%itemNum+0.5)*(width/itemNum)+5, (width-10)/(itemNum), (width-10)/(itemNum));
      c.setFillColor(px[j*itemNum+i]);
      c.setStrokeColor(color(px[j*itemNum+i],0));
      c.setStrokeWeight(1);
      //c.addImage(img); //attach the image to a PCircle
      c.setBounce(0); //setDifferentBounciness
      c.setFriction(1); //setDifferentBounciness
      cList.add(c);
    }
  }

  boundaries.add(new PRect(width/2, height-10/2, width, 10, true));
  //boundaries.add(new PRect(width/2, 10/2, width, 10, true));
  //boundaries.add(new PRect(width-10/2, height/2, 10, height, true));
  //boundaries.add(new PRect(10/2, height/2, 10, height, true));
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
    PRect c = cList.get(i);
    //c.displayImage();
    c.display();
  }

  for (int i = boundaries.size()-1; i>=0; i--) {
    PRect wall = boundaries.get(i);
    wall.display();
  }
}

void keyReleased() {
  if (key == ENTER) {
    for (int i = cList.size()-1; i>=0; i--) {
      PRect c = cList.get(i);
      c.killBody();
      cList.remove(i);
    }
    for (int i = 0; i < itemNum; i++) {
      for (int j = 0; j < itemNum; j++) {
        //Vec2 linear_v = 0;//new Vec2(random(-10, 10), random(-10, 10));
        //float angle_v = 0;//random(-1, 1);
        PRect c = new PRect((i%itemNum+1)*width/(itemNum+2), (j%itemNum+1)*width/(itemNum+2), width/(itemNum+2), width/(itemNum+2));
        c.setFillColor(px[j*itemNum+i]);
        c.setStrokeColor(color(px[j*itemNum+i],0));
        c.setStrokeWeight(1);
        //c.addImage(img); //attach the image to a PCircle
        c.setBounce(0); //setDifferentBounciness
        c.setFriction(1); //setDifferentBounciness
        cList.add(c);
      }
    }
  }
  if (key == 'a') {
    box2d.setGravity(0, 2); //a custom gravity
  }
  if (key == 'z') {
    box2d.setGravity(0, -50); //a custom gravity
  }
  if (key == 's') {
    box2d.setGravity(20, 2); //a custom gravity
  }
}