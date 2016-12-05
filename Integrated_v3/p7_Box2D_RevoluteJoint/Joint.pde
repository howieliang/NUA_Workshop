//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Joint {
  Box box1;
  Box box2;
  Vec2 anchor;
  RevoluteJoint rj;
  
  color cFill = color(0);
  color cStroke = color(0); 
  float strokeW = 2;

  float motorSpeed = PI*2;       // how fast?
  float maxMotorTorque = 1000.0; // how powerful?

  Joint (Box box1_, Box box2_, Vec2 anchor_, boolean isOn_, float motorSpeed_, float maxMotorTorque_) {
    // Initialize locations of two boxes
    init (box1_, box2_, anchor_, isOn_, motorSpeed_, maxMotorTorque_);
  }
  
  Joint (Box box1_, Box box2_, Vec2 anchor_) {
    init (box1_, box2_, anchor_, false, motorSpeed, maxMotorTorque);
  }
  
  void init (Box box1_, Box box2_, Vec2 anchor_, boolean isOn_, float motorSpeed_, float maxMotorTorque_){
    box1 = box1_;
    box2 = box2_;
    anchor = anchor_;
    rj = makeRevoluteJoint(box1, box2, isOn_, motorSpeed_, maxMotorTorque_);
  }

  // Turn the motor on or off
  void toggleMotor() {
    rj.enableMotor(!rj.isMotorEnabled());
  }

  boolean motorOn() {
    return rj.isMotorEnabled();
  }
  
  void setVisual(color cFill_, color cStroke_, float strokeW_){
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  void display() {
    box2.display();
    box1.display();
    // Draw anchor just for debug
    Vec2 a = anchor;//box1.body.getWorldCenter());
    fill(cFill);
    stroke(cStroke);
    strokeWeight(strokeW);
    ellipse(a.x, a.y, 8, 8);
  }

  RevoluteJoint makeRevoluteJoint(Box box1, Box box2, boolean isOn_, float motorSpeed_, float maxMotorTorque_) {
    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(box1.body, box2.body, box1.body.getWorldCenter());
    // Turning on a motor (optional)
    rjd.motorSpeed = motorSpeed_;       // how fast?
    rjd.maxMotorTorque = maxMotorTorque_; // how powerful?
    rjd.enableMotor = isOn_;      // is it on?

    return (RevoluteJoint) box2d.world.createJoint(rjd);
  }
}