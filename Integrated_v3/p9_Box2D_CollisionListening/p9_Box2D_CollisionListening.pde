//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This Example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Particle> particles;
Boundary wall;

void setup() {
  size(500, 500);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -50);

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Create the particles
  particles = new ArrayList<Particle>();
  // Create the wall
  wall = new Boundary(width/2, height-5, width, 10);
}

void draw() {
  background(255);
  
  box2d.step();
  
  //Add new particles
  if (random(1) < 0.1) {
    float sz = random(4, 8);
    particles.add(new Particle(random(width), 20, sz));
  }

  //Show all particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    if (p.done()) {
      particles.remove(i);
    }
  }
  
  //Show the wall
  wall.display();
}


// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
    println("here");
    Particle p1 = (Particle) o1;
    p1.change();
    Particle p2 = (Particle) o2;
    p2.change();
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}