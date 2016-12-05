//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

class Baby {
  // We need to keep track of a Body and a width and height
  Body body;
  ArrayList<Shape> shapeList;
  float density = 1;
  float friction = 0.3;
  float restitution = 0.5;

  color cFill = color(0);
  color cStroke = color(0); 
  float strokeW = 2;
  
  color colorBody = color(random(0, 255), random(0, 255), random(0, 255));
  color colorHead = color(random(0, 255), random(0, 255), random(0, 255));

  float w = 8;
  float h = 24;
  float r = 8;

  Vec2 headCentroid = new Vec2(0, -h/2);
  Vec2 handsCentroid = new Vec2(0, -h/4);
  Vec2[] clothVertices = {new Vec2(-w/2, -h/2), new Vec2(-w, h/2), new Vec2(w, h/2), new Vec2(w/2, -h/2)};

  // Constructor
  Baby (float x, float y) {
    shapeList = new ArrayList<Shape>();

    //Make your shape here
    CircleShape head = makeCircle (headCentroid, r);    
    PolygonShape hands = makeRect (handsCentroid, w*4, h/4, 0);
    PolygonShape cloth = makeShape (clothVertices);
    shapeList.add(head);
    shapeList.add(hands);
    shapeList.add(cloth);

    // Add the box to the box2d world
    makeBody(new Vec2(x, y));
    body.setUserData(this);
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center) {
    Vec2 initlinV_ = new Vec2(random(-5, 5), random(2, 5));
    float initAngV_ = random(-5, 5);
    makeBody(center, initlinV_, initAngV_);
  }

  void makeBody(Vec2 center, Vec2 initlinV_, float initAngV_) {

    // Define a fixture
    FixtureDef[] fd = new FixtureDef[shapeList.size()];
    for (int i=0; i < shapeList.size(); i++) {
      fd[i] = new FixtureDef();
      fd[i].shape = shapeList.get(i);
      // Parameters that affect physics
      fd[i].density = density;
      fd[i].friction = friction;
      fd[i].restitution = restitution;
    }

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Add shapes to the body
    for (int i=0; i < shapeList.size(); i++) {
      body.createFixture(fd[i]);
    }

    // Give it some initial random velocity
    body.setLinearVelocity(initlinV_);
    body.setAngularVelocity(initAngV_);
  }

  // Drawing the lollipop
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    strokeWeight(strokeW);
    stroke(cStroke);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);    

    drawRect(handsCentroid, w*4, h/4, colorHead);
    drawShape(clothVertices, colorBody);
    drawCircle(headCentroid, r, colorHead);

    popMatrix();
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
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }
}