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
  line(centroid.x, centroid.y,centroid.x, centroid.y+r);
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