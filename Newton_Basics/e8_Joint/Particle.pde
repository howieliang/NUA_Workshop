
//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class PCircle extends Object {
  // We need to keep track of a Body and a radius
  float r = 10;
  CircleShape cs;

  PCircle(float x, float y) {
    super(x, y);
    init(r);
  }

  PCircle(float x, float y, float r_) {
    super(x, y);
    init(r_);
  }

  PCircle(float x, float y, float r_, boolean lock_) {
    super(x, y, lock_);
    init(r_);
  }

  PCircle(float x, float y, float r_, float a_, boolean lock_) {
    super(x, y, a_, lock_);
    init(r_);
  }

  PCircle(float x, float y, float r_, float a_) {
    super(x, y, a_);
    init(r_);
  }

  PCircle(float x, float y, float r_, float a_, Vec2 initlinV_, float initAngV_) {
    super(x, y, a_, initlinV_, initAngV_);
    init(r_);
  }

  void init(float r_) {
    this.r = r_;
    makeBody(centroid, r, a, lock, initlinV, initAngV);
    body.setUserData(this);
  }

  void addImage(PImage img_) {
    PImage pCopy = img_.copy();
    pCopy.resize((int)r*2, (int)r*2);
    imgList.add(pCopy);
  }

  void setImageList(ArrayList<PImage> imgList_) {
    imgList.clear();
    for ( PImage p : imgList_) {
      PImage pCopy = p.copy();
      pCopy.resize((int)r*2, (int)r*2);
      imgList.add(pCopy);
    }
  }

  void makeBody(Vec2 center, float r_, float a, boolean lock, Vec2 initlinV_, float initAngV_) {

    // Make the body's shape a circle
    cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;

    // Define a body
    BodyDef bd = new BodyDef();
    if (lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.setPosition(box2d.coordPixelsToWorld(center));
    bd.setAngle(a);
    body = box2d.world.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(initlinV_);
    body.setAngularVelocity(initAngV_);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Change color when hit
  void change() {
    cFill = color(255, 0, 0);
  }

  // Change image when hit
  void changeImage() {
    if (imgList.size()>0) {
      int i = (++imgIndex)%imgList.size();
      changeImage(i);
      println(i);
    }
  }

  // Change image to index i when hit
  void changeImage(int i) {
    if (imgList != null) {
      if (i<imgList.size()) {
        imgIndex = i;
      } else {
        println("[ERROR] Out of range.");
      }
    } else {
      println("[ERROR] No image assigned.");
    }
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    displayImage(false);
  }

  void displayImage() {
    displayImage(true);
  }

  void displayImage(boolean showImage) {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushStyle();
    stroke(cStroke);
    strokeWeight(strokeW);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    ellipseMode(CENTER);
    fill(cFill);
    ellipse(0,0, r*2, r*2);
    line(0,0,0,r);
    if (showImage) {
      imageMode(CENTER);
      image(imgList.get(imgIndex), 0, 0);
    }
    popMatrix();
    popStyle();
  }
}