// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An uneven surface boundary

class Surface {
  // We'll keep track of all of the surface points
  ArrayList<Vec2> surface;

  float bowlW = 50;
  float bowlH = 50;
  int objID = -1;
  
  Surface(float w, float h, int objID) {
    surface = new ArrayList<Vec2>();
    this.objID = objID;
    // Here we keep track of the screen coordinates of the chain
    surface.add(new Vec2(w-bowlW, h));
    surface.add(new Vec2(w-bowlW, h+bowlH));
    surface.add(new Vec2(w+bowlW, h+bowlH));
    surface.add(new Vec2(w+bowlW, h));

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    // We can add 3 vertices by making an array of 3 Vec2 objects
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    chain.createChain(vertices, vertices.length);

    // The edge chain is now a body!
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    // Shortcut, we could define a fixture if we
    // want to specify frictions, restitution, etc.
    body.createFixture(chain, 1);
    
    body.setUserData(this);
  }

  // A simple function to just draw the edge chain as a series of vertex points
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    beginShape();
    for (Vec2 v: surface) {
     vertex(v.x, v.y);
    }
    //vertex(width, height);
    //vertex(0, height);
    endShape();
  }
}