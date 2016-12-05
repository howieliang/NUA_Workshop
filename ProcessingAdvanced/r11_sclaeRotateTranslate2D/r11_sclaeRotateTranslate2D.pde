float angle = 0.0;
void setup() {
  size(240, 240);
  rectMode(CENTER);
}
void draw() {
  background(100);

  pushMatrix();
  translate(mouseX, mouseY);
  float scalar = sin(angle) + 2;
  scale(scalar);
  //strokeWeight(1.0 / scalar);
  rotate(angle);
  rect(0, 0, 30, 30);
  angle += 0.1;
  popMatrix();

  translate(width/2, height/2);
  rect(0, 0, 15, 15);
}