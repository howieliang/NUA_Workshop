//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  Vec2 boxCentroid = new Vec2(0, 0);
  color cFill = color(127);
  color cStroke = color(0); 
  float strokeW = 2;
  float w;
  float h;
  
  float density = 1;
  float friction = 0.3;
  float restitution = 0.5;

  // Constructor
  Box(float x, float y) {
    w = random(4, 16);
    h = random(4, 16);
    init(x, y, w, h, false, cFill, cStroke, strokeW);
  }

  Box(float x, float y, float w_, float h_) {
    init(x, y, w_, h_, false, cFill, cStroke, strokeW);
  }
  
  Box(float x, float y, float w_, float h_, color cFill_, color cStroke_) {
    init(x, y, w_, h_, false, cFill_, cStroke_, strokeW);
  }
  
  Box(float x, float y, float w_, float h_, color cFill_, color cStroke_, float strokeW_) {
    init(x, y, w_, h_, false, cFill_, cStroke_, strokeW_);
  }
  
  Box(float x, float y, float w_, float h_, color cFill_, color cStroke_, float strokeW_, Vec2 initlinV_, float initAngV_){
    init(x, y, w_, h_, false, cFill_, cStroke_, strokeW_, initlinV_, initAngV_);
  }
  
  Box(float x, float y, float w_, float h_, boolean lock) {
    init(x, y, w_, h_, lock, cFill, cStroke, strokeW);
  }
  
  Box(float x, float y, float w_, float h_, boolean lock, color cFill_, color cStroke_) {
    init(x, y, w_, h_, lock, cFill_, cStroke_, strokeW);
  }
  
  Box(float x, float y, float w_, float h_, boolean lock, color cFill_, color cStroke_, float strokeW_) {
    init(x, y, w_, h_, lock, cFill_, cStroke_, strokeW_);
  }
  
  Box(float x, float y, float w_, float h_, boolean lock, color cFill_, color cStroke_, float strokeW_, Vec2 initlinV_, float initAngV_){
    init(x, y, w_, h_, lock, cFill_, cStroke_, strokeW_, initlinV_, initAngV_);
  }
  
  void init(float x, float y, float w_, float h_, boolean lock, color cFill_, color cStroke_, float strokeW_){
    init(x, y, w_, h_, lock, cFill_, cStroke_, strokeW_, new Vec2(random(-5, 5), random(2, 5)), random(-5, 5));
  }
  
  void init(float x, float y, float w_, float h_, boolean lock, color cFill_, color cStroke_, float strokeW_, Vec2 initlinV_, float initAngV_){
    w = w_;
    h = h_;
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h, initlinV_, initAngV_, lock);
    body.setUserData(this);
  }
  
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }


  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    stroke(cStroke);
    strokeWeight(strokeW);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    drawRect(boxCentroid, w, h, cFill);
    popMatrix();
  }
  
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_, boolean lock) {
    Vec2 initlinV_ = new Vec2(random(-5, 5), random(2, 5));
    float initAngV_ = random(-5, 5);
    makeBody(center, w_, h_, initlinV_, initAngV_, lock);
  }
  
  // This function adds the rectangle to the box2d world with initial linear and angular velocities
  void makeBody(Vec2 center, float w_, float h_, Vec2 initlinV_, float initAngV_, boolean lock) {
    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    if (lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.setPosition(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(initlinV_);
    body.setAngularVelocity(initAngV_);
  }
}