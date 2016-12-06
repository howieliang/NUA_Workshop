//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Handle {
  // This is the box2d object we need to create
  MouseJoint mouseJoint;
  float maxForceFactor = 1000.0;
  float frequencyHz = 5.0;
  float dampingRatio = 0.9;

  color cStroke = color(0); 
  float strokeW = 2;

  Handle() {
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
      pushStyle();
      Vec2 v1 = new Vec2(0, 0);
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = new Vec2(0, 0);
      mouseJoint.getAnchorB(v2);
      // Convert them to screen coordinates
      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      // And just draw a line
      stroke(cStroke);
      strokeWeight(strokeW);
      line(v1.x, v1.y, v2.x, v2.y);
      popStyle();
    }
  }

  void bind(float x, float y, Object obj) {
    mouseJoint = makeMouseJoint(x, y, obj);
  }

  void bind(float x, float y, Object obj, float frequencyHz_, float dampingRatio_) {
    mouseJoint = makeMouseJoint(x, y, obj, frequencyHz_, dampingRatio_);
  }

  MouseJoint makeMouseJoint(float x, float y, Object obj) {
    return makeMouseJoint(x, y, obj, frequencyHz, dampingRatio);
  }
  
  void setStrokeWeight(float strokeW_) {
    strokeW = strokeW_;
  }
  
  void setStrokeColor(color cStroke_) {
    cStroke = cStroke_;
  }
  
  void setVisual(color cStroke_, float strokeW_) {
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }

  MouseJoint makeMouseJoint(float x, float y, Object obj, float frequencyHz_, float dampingRatio_) {
    MouseJointDef md = new MouseJointDef();
    md.bodyA = box2d.getGroundBody();
    md.bodyB = obj.body;
    Vec2 mp = box2d.coordPixelsToWorld(x, y);
    md.target.set(mp);
    md.maxForce = maxForceFactor * obj.body.m_mass;
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