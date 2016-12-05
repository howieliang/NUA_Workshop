//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Particle {
  // We need to keep track of a Body and a radius
  Body body;
  float density = 1;
  float friction = 0.3;
  float restitution = 0.1;
  
  color cFill = color(127);
  color cStroke = color(0); 
  float strokeW = 2;
  float r = 8;
  
  Particle(float x, float y) {
    init(x, y, r);
  }
  
  Particle(float x, float y, float r_) {
    init(x, y, r_);
  }
  
  void init(float x, float y, float r_){
    r = r_;
    makeBody(new Vec2(x,y));
    body.setUserData(this);
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
  
  void makeBody(Vec2 center){
    Vec2 initlinV_ = new Vec2(random(-5, 5), random(2, 5));
    float initAngV_ = 0;
    makeBody(center, initlinV_, initAngV_);
  }
  
  void makeBody(Vec2 center, Vec2 initlinV_, float initAngV_) {
    
    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;
    
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(center.x,center.y);
    bd.type = BodyType.DYNAMIC;
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
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    stroke(cStroke);
    strokeWeight(strokeW);
    strokeWeight(2);
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    drawCircle(new Vec2(0,0), r, cFill);
    popMatrix();
  }


}