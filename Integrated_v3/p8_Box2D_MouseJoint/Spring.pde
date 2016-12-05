//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Spring {
  // This is the box2d object we need to create
  MouseJoint mouseJoint;
  float maxForceFactor = 1000.0;
  float frequencyHz = 5.0;
  float dampingRatio = 0.9;
  
  color cStroke = color(0); 
  float strokeW = 2;

  Spring() {
    // At first it doesn't exist
    mouseJoint = null;
  }

  // If it exists we set its target to the mouse location 
  void update(float x, float y) {
    if (mouseJoint != null) {
      // Always convert to world coordinates!
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x, y);
      mouseJoint.setTarget(mouseWorld);
    }
  }

  void display() {
    if (mouseJoint != null) {
      drawMouseJoint(mouseJoint, cStroke, strokeW);
    }
  }

  // This is the key function where
  // we attach the spring to an x,y location
  // and the Box object's location
  void bind(float x, float y, Box box) {
    mouseJoint = makeMouseJoint(x, y, box);
  }
  
  void bind(float x, float y, Box box, float frequencyHz_, float dampingRatio_) {
    mouseJoint = makeMouseJoint(x, y, box, frequencyHz_, dampingRatio_);
  }
  
  MouseJoint makeMouseJoint(float x, float y, Box box) {
    return makeMouseJoint(x, y, box, frequencyHz, dampingRatio);
  }
  
  void setVisual(color cStroke_, float strokeW_){
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  MouseJoint makeMouseJoint(float x, float y, Box box, float frequencyHz_, float dampingRatio_) {
    MouseJointDef md = new MouseJointDef();
    md.bodyA = box2d.getGroundBody();
    md.bodyB = box.body;
    Vec2 mp = box2d.coordPixelsToWorld(x, y);
    md.target.set(mp);
    md.maxForce = maxForceFactor * box.body.m_mass;
    md.frequencyHz = frequencyHz_;
    md.dampingRatio = dampingRatio_;
    return (MouseJoint) box2d.world.createJoint(md);
  }
  
  void destroy() {
    // We can get rid of the joint when the mouse is released
    if (mouseJoint != null) {
      box2d.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }
}