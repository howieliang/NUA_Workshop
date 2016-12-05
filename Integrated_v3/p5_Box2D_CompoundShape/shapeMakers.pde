//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

CircleShape makeCircle (Vec2 centroid, float radius) {
  CircleShape circle = new CircleShape();
  circle.m_radius = box2d.scalarPixelsToWorld(radius);
  Vec2 offset = centroid;
  offset = box2d.vectorPixelsToWorld(offset);
  circle.m_p.set(offset.x, offset.y);
  return circle;
}


PolygonShape makeRect (Vec2 centroid, float w, float h, float angle) {
  PolygonShape rect = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(w/2);
  float box2dH = box2d.scalarPixelsToWorld(h/2);
  Vec2 offset = new Vec2(centroid.x, centroid.y);
  offset = box2d.vectorPixelsToWorld(offset);
  rect.setAsBox(box2dW, box2dH, offset, angle);
  return rect;
}

PolygonShape makeShape (Vec2[] edgeVertices) {
  PolygonShape shape = new PolygonShape();
  Vec2[] newVertices = new Vec2[edgeVertices.length];
  for (int i = 0; i < edgeVertices.length; i++) {
    float box2dW = box2d.scalarPixelsToWorld(edgeVertices[i].x);
    float box2dH = box2d.scalarPixelsToWorld(edgeVertices[i].y);
    newVertices[i] = new Vec2(box2dW, -box2dH);
  }
  shape.set(newVertices, newVertices.length);
  return shape;
}