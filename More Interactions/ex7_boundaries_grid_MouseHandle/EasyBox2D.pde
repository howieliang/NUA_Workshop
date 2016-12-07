//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

//##class PObject
class PObject {
  // We need to keep track of a Body and a radius
  Body body;
  Vec2 centroid = new Vec2(0, 0);
  float a = 0;
  Vec2 initlinV = new Vec2(0, 0);
  float initAngV = 0;
  boolean lock = false;

  color cFill = color(127);
  color cStroke = color(0); 
  float strokeW = 2;

  float density = 1;
  float friction = 0.5;
  float restitution = 0.2;

  ArrayList<PImage> imgList = new ArrayList<PImage>();
  int imgIndex = 0;

  PObject(float x, float y) {
    init(new Vec2(x, y), a, lock, initlinV, initAngV);
  }

  PObject(float x, float y, boolean lock_) {
    init(new Vec2(x, y), a, lock_, initlinV, initAngV);
  }

  PObject(float x, float y, float a_) {
    init(new Vec2(x, y), a_, lock, initlinV, initAngV);
  }

  PObject(float x, float y, float a_, boolean lock_) {
    init(new Vec2(x, y), a_, lock_, initlinV, initAngV);
  }

  PObject(float x, float y, float a_, Vec2 initlinV_, float initAngV_) {
    init(new Vec2(x, y), a_, lock, initlinV_, initAngV_);
  }

  void init(Vec2 c_, float a_, boolean lock_, Vec2 initlinV_, float initAngV_) {
    centroid = c_;
    a = a_;
    lock = lock_;
    initlinV = initlinV_;
    initAngV = initAngV_;
  }
  
  void setFillColor(color cFill_){
    cFill = cFill_;
  }
  
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  
  void setStrokeWeight(float strokeW_) {
    strokeW = strokeW_;
  }
  
  void setStrokeColor(color cStroke_) {
    cStroke = cStroke_;
  }
  
  void setVisual(color cFill_, color cStroke_, float strokeW_) {
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  boolean contains(float x, float y) {
    
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    println(x,y,inside);
    return inside;
  }
  
  void setDensity (float density_){
    if (body!=null) {
      Fixture f = body.getFixtureList();
      if (f!=null) {
        f.setDensity(density_);
      } else {
        println("[ERROR:] No fixture");
      }
    } else {
      println("[ERROR:] No body");
    }
  }
  
  void setFriction (float friction_){
    if (body!=null) {
      Fixture f = body.getFixtureList();
      if (f!=null) {
        f.setFriction(friction_);
      } else {
        println("[ERROR:] No fixture");
      }
    } else {
      println("[ERROR:] No body");
    }
  }
  
  void setBounce (float bounce_){
    if (body!=null) {
      Fixture f = body.getFixtureList();
      if (f!=null) {
        f.setRestitution(bounce_);
      } else {
        println("[ERROR:] No fixture");
      }
    } else {
      println("[ERROR:] No body");
    }
  }
  
  void setMaterial(float density_, float friction_, float restitution_) {
    if (body!=null) {
      Fixture f = body.getFixtureList();
      if (f!=null) {
        f.setDensity(density_);
        f.setFriction(friction_);
        f.setRestitution(restitution_);
      } else {
        println("[ERROR:] No fixture");
      }
    } else {
      println("[ERROR:] No body");
    }
  }

  // This function removes the Object from the box2d world
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
  
  void display(){
  }
}

//##class PCircle extends PObject

class PCircle extends PObject {
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

//##class PRect extends PObject

class PRect extends PObject {
  // We need to keep track of a Body and a radius
  float w = 20;
  float h = 20;
  PolygonShape sd;

  PRect(float x, float y, float w_, float h_) {
    super(x, y);
    init(w_, h_);
  }

  PRect(float x, float y, float w_, float h_, float a_) {
    super(x, y, a_);
    init(w_, h_);
  }

  PRect(float x, float y, float w_, float h_, boolean lock_) {
    super(x, y, lock_);
    init(w_, h_);
  }

  PRect(float x, float y, float w_, float h_, float a_, boolean lock_) {
    super(x, y, a_, lock_);
    init(w_, h_);
  }

  PRect(float x, float y, float w_, float h_, float a_, Vec2 initlinV_, float initAngV_) {
    super(x, y, a_, initlinV_, initAngV_);
    init(w_, h_);
  }

  void init(float w_, float h_) {
    this.w = w_;
    this.h = h_;
    makeBody(centroid, w, h, a, lock, initlinV, initAngV);
    body.setUserData(this);
  }

  void setImageList(ArrayList<PImage> imgList_) {
    imgList.clear();
    for ( PImage p : imgList_) {
      PImage pCopy = p.copy();
      pCopy.resize((int)w, (int)h);
      imgList.add(pCopy);
    }
  }

  void addImage(PImage img_) {
    PImage pCopy = img_.copy();
    pCopy.resize((int)w, (int)h);
    imgList.add(pCopy);
  }

  void makeBody(Vec2 center, float w_, float h_, float a, boolean lock, Vec2 initlinV_, float initAngV_) {

    // Make the body's shape a circle
    sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
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
    if (pos.y > height+(w+h)) {
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
    rectMode(CENTER);
    fill(cFill);
    rect(0, 0, w, h);
    if (showImage) {
      imageMode(CENTER);
      image(imgList.get(imgIndex), 0, 0);
    }
    popMatrix();
  }
}

//##class Handle

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

  void bind(float x, float y, PObject obj) {
    mouseJoint = makeMouseJoint(x, y, obj, maxForceFactor, frequencyHz, dampingRatio);
  }

  void bind(float x, float y, PObject obj, float maxForceFactor_) {
    mouseJoint = makeMouseJoint(x, y, obj, maxForceFactor_, frequencyHz, dampingRatio);
  }
  
  void bind(float x, float y, PObject obj, float maxForceFactor_, float frequencyHz_, float dampingRatio_) {
    mouseJoint = makeMouseJoint(x, y, obj, maxForceFactor_, frequencyHz_, dampingRatio_);
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

  MouseJoint makeMouseJoint(float x, float y, PObject obj, float maxForceFactor_, float frequencyHz_, float dampingRatio_) {
    MouseJointDef md = new MouseJointDef();
    md.bodyA = box2d.getGroundBody();
    md.bodyB = obj.body;
    Vec2 mp = box2d.coordPixelsToWorld(x, y);
    md.target.set(mp);
    md.maxForce = maxForceFactor_ * obj.body.m_mass;
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

//##class Joint

class Joint {
  PObject obj1;
  PObject obj2;
  Vec2 anchor;
  RevoluteJoint rj;

  color cFill = color(0);
  color cStroke = color(0); 
  float strokeW = 2;

  float motorSpeed = PI*2;       // how fast?
  float maxMotorTorque = 1000.0; // how powerful?

  Joint (PObject obj1_, PObject obj2_, Vec2 anchor_, boolean isOn_, float motorSpeed_, float maxMotorTorque_) {
    // Initialize locations of two boxes
    init (obj1_, obj2_, anchor_, isOn_, motorSpeed_, maxMotorTorque_);
  }

  Joint (PObject obj1_, PObject obj2_, Vec2 anchor_) {
    init (obj1_, obj2_, anchor_, false, motorSpeed, maxMotorTorque);
  }

  void init (PObject obj1_, PObject obj2_, Vec2 anchor_, boolean isOn_, float motorSpeed_, float maxMotorTorque_) {
    obj1 = obj1_;
    obj2 = obj2_;
    anchor = anchor_;
    rj = makeRevoluteJoint(obj1, obj2, isOn_, motorSpeed_, maxMotorTorque_);
  }

  // Turn the motor on or off
  void toggleMotor() {
    rj.enableMotor(!rj.isMotorEnabled());
  }

  boolean motorOn() {
    return rj.isMotorEnabled();
  }

  void setVisual(color cFill_, color cStroke_, float strokeW_) {
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  void setFillColor(color cFill_){
    cFill = cFill_;
  }
  
  void setStrokeWeight(float strokeW_) {
    strokeW = strokeW_;
  }
  
  void setStrokeColor(color cStroke_) {
    cStroke = cStroke_;
  }
  
  void display() {
    obj2.display();
    obj1.display();
    // Draw anchor just for debug
    Vec2 a = anchor;//obj1.body.getWorldCenter());
    fill(cFill);
    stroke(cStroke);
    strokeWeight(strokeW);
    ellipse(a.x, a.y, 8, 8);
  }

  RevoluteJoint makeRevoluteJoint(PObject obj1, PObject obj2, boolean isOn_, float motorSpeed_, float maxMotorTorque_) {
    // Define joint as between two bodies
    RevoluteJointDef rjd = new RevoluteJointDef();

    rjd.initialize(obj1.body, obj2.body, obj1.body.getWorldCenter());
    // Turning on a motor (optional)
    rjd.motorSpeed = motorSpeed_;       // how fast?
    rjd.maxMotorTorque = maxMotorTorque_; // how powerful?
    rjd.enableMotor = isOn_;      // is it on?

    return (RevoluteJoint) box2d.world.createJoint(rjd);
  }
}

//##class Link

class Link {
  PObject p1;
  PObject p2;
  DistanceJoint dj;
  color cStroke = color(0); 
  float strokeW = 2;

  float len = 32;
  float frequencyHz = 5;  // Try a value less than 5 (0 for no elasticity)
  float dampingRatio = 0.1; // Ranges between 0 and 1 (1 for no springiness)

  // Chain constructor
  Link(PObject p1_, PObject p2_, float distance) {
    init(p1_, p2_, distance, frequencyHz, dampingRatio);
  }
  
  Link(PObject p1_, PObject p2_, float distance, float frequencyHz_, float dampingRatio_) {
    init(p1_, p2_, distance, frequencyHz_, dampingRatio_);
  }
  
  void init(PObject p1_, PObject p2_, float len_, float frequencyHz_, float dampingRatio_){
    p1 = p1_;
    p2 = p2_;
    dj = makeDistanceJoint(p1_, p2_, len_, frequencyHz_, dampingRatio_);
  }

  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    stroke(cStroke);
    strokeWeight(strokeW);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    
    p1.display();
    p2.display();
  }
  
  void setStrokeWeight(float strokeW_) {
    strokeW = strokeW_;
  }
  
  void setStrokeColor(color cStroke_) {
    cStroke = cStroke_;
  }
  
  void setVisual(color cStroke_, float strokeW_){
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  DistanceJoint makeDistanceJoint(PObject p1, PObject p2, float len_, float frequencyHz_, float dampingRatio_) {
    DistanceJointDef djd = new DistanceJointDef();
    // Connection between previous particle and this one
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
    // Equilibrium length
    djd.length = box2d.scalarPixelsToWorld(len_);
    djd.frequencyHz = frequencyHz_;  // Try a value less than 5 (0 for no elasticity)
    djd.dampingRatio = dampingRatio_; // Ranges between 0 and 1 (1 for no springiness)
    return (DistanceJoint) box2d.world.createJoint(djd);
  }
}