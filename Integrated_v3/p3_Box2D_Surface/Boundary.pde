//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  color cFill = color(0);
  color cStroke = color(0); 
  float strokeW = 2;
  float x;
  float y;
  float w;
  float h;
  
  PolygonShape ps;
  FixtureDef fd;
  BodyDef bd;
  
  float density = 1;
  float friction = 0.1;
  float restitution = 0.1;

  // But we also have to make a body for box2d to know about it
  Body body;
  Vec2 boundaryCentroid = new Vec2(0, 0);

  Boundary(float x_, float y_, float w_, float h_) {
    init(x_, y_, w_, h_, 0, cFill, cStroke, strokeW);
  }

  Boundary(float x_, float y_, float w_, float h_, float a_) {
    init(x_, y_, w_, h_, a_, cFill, cStroke, strokeW);
  }

  void init(float x_, float y_, float w_, float h_, float a_, color cFill_, color cStroke_, float strokeW_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
    makeBody(new Vec2(x, y), w_, h_, a_);
    body.setUserData(this);
  }

  void makeBody(Vec2 center, float w_, float h_) {
    makeBody(center, w_, h_, 0);
  }
  
  void setVisual(color cFill_, color cStroke_, float strokeW_){
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  void setMaterial(float density_, float friction_, float restitution_){
    Fixture f = body.getFixtureList();
    f.setDensity(density_);
    f.setFriction(friction_);
    f.setRestitution(restitution_);
  }
  
  void makeBody(Vec2 center, float w_, float h_, float a_) {
    // Define a polygon (this is what we use for a rectangle)
    ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    ps.setAsBox(box2dW, box2dH);
    
    // Define a fixture
    fd = new FixtureDef();
    fd.shape = ps;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;

    // Create the body
    bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.setPosition(box2d.coordPixelsToWorld(center));
    bd.setAngle(a_);
    body = box2d.createBody(bd);
    body.createFixture(fd);
    

    // Attached the shape to the body using a Fixture
    //body.createFixture(ps, 1);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    stroke(cStroke);
    strokeWeight(strokeW);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    drawRect(boundaryCentroid, w, h, cFill);
    popMatrix();
  }
}