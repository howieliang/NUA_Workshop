//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class CustomShape {

  // We need to keep track of a Body and a width and height
  Body body;
  ArrayList<Vec2> surface;
  color cFill = color(127);
  color cStroke = color(0); 
  float strokeW = 2;
  Vec2[] shapeVertices;
  
  float density = 1;
  float friction = 1;
  float restitution = 0.1;

  //Constructor
  CustomShape(float x, float y, ArrayList<Vec2> surface_) {
    init(new Vec2(x, y), surface_, cFill, cStroke, strokeW);
  }
  
  //CustomShape(float x, float y, ArrayList<Vec2> surface_, color cFill_, color cStroke_) {
  //  init(new Vec2(x, y), surface_, cFill_, cStroke_, strokeW);
  //}
  
  //CustomShape(float x, float y, ArrayList<Vec2> surface_, color cFill_, color cStroke_, float strokeW_) {
  //  init(new Vec2(x, y), surface_, cFill_, cStroke_, strokeW_);
  //}
  
  void init(Vec2 center, ArrayList<Vec2> surface_, color cFill_, color cStroke_, float strokeW_){
    surface = surface_;
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
    shapeVertices = new Vec2[surface.size()];
    for (int i = 0; i < shapeVertices.length; i++) {
      shapeVertices[i] = surface.get(i);
    }
    makeBody(center);
    body.setUserData(this);
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
    if (pos.y > height) {
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

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    stroke(cStroke);
    strokeWeight(strokeW);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    drawShape(shapeVertices, cFill);
    popMatrix();
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
  
  void makeBody(Vec2 center) {
    Vec2 initlinV_ = new Vec2(random(-5, 5), random(2, 5));
    float initAngV_ = random(-5, 5);
    makeBody(center, initlinV_, initAngV_);
  }
  
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, Vec2 initlinV_, float initAngV_) {
    // Define a polygon (this is what we use for a rectangle)
    PolygonShape ps = new PolygonShape();
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.vectorPixelsToWorld(surface.get(i));
    }
    ps.set(vertices, vertices.length);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;
    
    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC; //a DYNAMIC one!
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(initlinV_);
    body.setAngularVelocity(initAngV_);
  }
}