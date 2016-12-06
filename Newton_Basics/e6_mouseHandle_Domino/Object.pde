
//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Object {
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

  Object(float x, float y) {
    init(new Vec2(x, y), a, lock, initlinV, initAngV);
  }

  Object(float x, float y, boolean lock_) {
    init(new Vec2(x, y), a, lock_, initlinV, initAngV);
  }

  Object(float x, float y, float a_) {
    init(new Vec2(x, y), a_, lock, initlinV, initAngV);
  }

  Object(float x, float y, float a_, boolean lock_) {
    init(new Vec2(x, y), a_, lock_, initlinV, initAngV);
  }

  Object(float x, float y, float a_, Vec2 initlinV_, float initAngV_) {
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