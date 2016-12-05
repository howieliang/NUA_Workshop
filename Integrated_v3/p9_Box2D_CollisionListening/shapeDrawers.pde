//*********************************************
// Easy Box2D for Processing (v1)
// Rong-Hao Liang: r.liang@tue.nl
// This example is based on the examples of 
// The Nature of Code (by Daniel Shiffman)
// http://natureofcode.com
//*********************************************

void drawCircle(Vec2 centroid, float r, color cCircle) {
  pushStyle();
  ellipseMode(CENTER);
  fill(cCircle);
  ellipse(centroid.x, centroid.y, r*2, r*2);
  line(centroid.x, centroid.y, centroid.x, centroid.y+r);
  popStyle();
}

void drawRect(Vec2 centroid, float w, float h, color cRect) {
  pushStyle();
  rectMode(CENTER);
  fill(cRect);
  rect(centroid.x, centroid.y, w, h);
  popStyle();
}

void drawShape(Vec2[] shapeVertices, color cShape) {
  pushStyle();
  fill(cShape);
  beginShape();
  for (int i = 0; i < shapeVertices.length; i++) {
    vertex(shapeVertices[i].x, shapeVertices[i].y);
  }
  endShape(CLOSE);
  popStyle();
}

void drawMouseJoint(MouseJoint mouseJoint, color cJoint, float strokeW_) {
  // We can get the two anchor points
  pushStyle();
  Vec2 v1 = new Vec2(0, 0);
  mouseJoint.getAnchorA(v1);
  Vec2 v2 = new Vec2(0, 0);
  mouseJoint.getAnchorB(v2);
  // Convert them to screen coordinates
  v1 = box2d.coordWorldToPixels(v1);
  v2 = box2d.coordWorldToPixels(v2);
  // And just draw a line
  stroke(cJoint);
  strokeWeight(strokeW_);
  line(v1.x, v1.y, v2.x, v2.y);
  popStyle();
}