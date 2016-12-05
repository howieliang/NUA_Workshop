// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Basic example of controlling an object with our own motion (by attaching a MouseJoint)
// Also demonstrates how to know which object was hit

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;

// Just a single box this time
Box box;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
Surface[] surfaces = new Surface[2];

void setup() {
  size(400,600);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Add a listener to listen for collisions!
  box2d.world.setContactListener(new CustomListener());

  // Make the box
  box = new Box(width/2,height/2);

  // Create the empty list
  particles = new ArrayList<Particle>();
  
  // Create the surface
  surfaces[0] = new Surface(width/4,2*height/3, 0);
  surfaces[1] = new Surface((3*width)/4,2*height/3, 1);

}

void draw() {
  background(255);

  if (random(1) < 0.02) {
    float sz = random(5,15);
    int id = (random(0,99)>50 ? 0 : 1);
    particles.add(new Particle(width/2,-20,sz,id));
  }

  // We must always step through time!
  box2d.step();

  //// Make an x,y coordinate out of perlin noise
  float x = mouseX;//noise(xoff)*width;
  float y = mouseY;//noise(yoff)*height;
  box.setLocation(mouseX,mouseY);
  if(mousePressed)
  box.setRotation(PI/4);
  else
  box.setRotation(-PI/4);
  
  // Draw the surface
  for(Surface s: surfaces){
    s.display();
  }

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
  // Draw the box
  box.display();
}