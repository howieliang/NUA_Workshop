//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Pair {
  Particle p1;
  Particle p2;
  DistanceJoint dj;
  color cStroke = color(0); 
  float strokeW = 2;

  float len = 32;
  float frequencyHz = 5;  // Try a value less than 5 (0 for no elasticity)
  float dampingRatio = 0.1; // Ranges between 0 and 1 (1 for no springiness)

  // Chain constructor
  Pair(Particle p1_, Particle p2_, float distance) {
    init(p1_, p2_, distance, frequencyHz, dampingRatio);
  }
  
  Pair(Particle p1_, Particle p2_, float distance, float frequencyHz_, float dampingRatio_) {
    init(p1_, p2_, distance, frequencyHz_, dampingRatio_);
  }
  
  void init(Particle p1_, Particle p2_, float len_, float frequencyHz_, float dampingRatio_){
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
  
  void setVisual(color cStroke_, float strokeW_){
    cStroke = cStroke_; 
    strokeW = strokeW_;
  }
  
  DistanceJoint makeDistanceJoint(Particle p1, Particle p2, float len_, float frequencyHz_, float dampingRatio_) {
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