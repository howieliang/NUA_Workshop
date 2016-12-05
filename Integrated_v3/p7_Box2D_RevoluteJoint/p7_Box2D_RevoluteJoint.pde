//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
Joint joint;
ArrayList<Particle> particles;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // We are setting a custom gravity
  box2d.setGravity(0, -50);

  // Make the windmill at an x,y location
  Vec2 anchor = new Vec2(width/2,height/2);
  Box box1 = new Box(anchor.x, anchor.y   , 120, 10, false); 
  Box box2 = new Box(anchor.x, anchor.y+20, 10 , 40, true);
  //joint = new Joint (box1, box2, anchor);
  joint = new Joint (box1, box2, anchor, true, 4*PI, 4000);
  joint.setVisual(color(0,255,0), color(0), 2);

  // Create the empty list
  particles = new ArrayList<Particle>();

}

void draw() {
  background(255);

  if (random(1) < 0.1) {
    float sz = random(4,8);
    particles.add(new Particle(random(width/2-100,width/2+100),-20,sz));
  }


  // We must always step through time!
  box2d.step();

  // Look at all particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }

  // Draw the windmill
  joint.display();
  
  String status = "OFF";
  if (joint.motorOn()){ status = "ON";
    joint.setVisual(color(0,255,0), color(0), 2);
  }else{
    joint.setVisual(color(255,0,0), color(0), 2);
  }
  
  fill(0);
  text("Click mouse to toggle motor.\nMotor: " + status,10,height-30);

}

void mousePressed() {
  joint.toggleMotor();
}