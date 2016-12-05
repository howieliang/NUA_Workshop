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


void setup() {
  size(400,300);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Add a listener to listen for collisions!
  box2d.world.setContactListener(new CustomListener());

  // Make the box
  box = new Box(width/2,height/2);

  // Create the empty list
  particles = new ArrayList<Particle>();


}

void draw() {
  background(255);

  if (random(1) < 0.2) {
    float sz = random(4,8);
    particles.add(new Particle(width/2,-20,sz));
  }


  // We must always step through time!
  box2d.step();

  //// Make an x,y coordinate out of perlin noise
  float x = mouseX;//noise(xoff)*width;
  float y = mouseY;//noise(yoff)*height;
  box.setLocation(mouseX,mouseY);
  //box.body.setAngularVelocity(0);

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