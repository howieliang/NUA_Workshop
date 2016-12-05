//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Surface {
  
  Body body;
  
  ArrayList<Vec2> surface;
  color cFill = color(0);
  color cStroke = color(0); 
  float strokeW = 2;
  Vec2[] surfaceVertices;
  
  float density = 1;
  float friction = 1;
  float restitution = 0.1;

  Surface(ArrayList<Vec2> surface_) {
    init(surface_, cFill, cStroke, strokeW);
  }
  
  //Surface(ArrayList<Vec2> surface_, color cFill_, color cStroke_) {
  //  init(surface_, cFill_, cStroke_, strokeW);
  //}
  
  //Surface(ArrayList<Vec2> surface_, color cFill_, color cStroke_, float strokeW_) {
  //  init(surface_, cFill_, cStroke_, strokeW_);
  //}
  
  void init(ArrayList<Vec2> surface_, color cFill_, color cStroke_, float strokeW_){
    surface = surface_;
    cFill = cFill_;
    cStroke = cStroke_; 
    strokeW = strokeW_;
    surfaceVertices = new Vec2[surface.size()];
    for (int i = 0; i < surfaceVertices.length; i++) {
      surfaceVertices[i] = surface.get(i);
    }
    makeBody(surface);
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

  void makeBody(ArrayList<Vec2> surface_) {
    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();
    // We can add 3 vertices by making an array of 3 Vec2 objects
    Vec2[] vertices = new Vec2[surface_.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface_.get(i));
    }
    chain.createChain(vertices, vertices.length);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = chain;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;
    
    // The edge chain is now a body!
    BodyDef bd = new BodyDef();
    body = box2d.world.createBody(bd);
    body.createFixture(fd);
  }

  // A simple function to just draw the edge chain as a series of vertex points
  void display() {
    stroke(cStroke);
    strokeWeight(strokeW);
    drawShape(surfaceVertices, cFill);
  }
}