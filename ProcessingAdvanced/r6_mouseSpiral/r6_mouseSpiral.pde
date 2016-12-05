float angle = 0.0;
float scalar = 60;
float speed = 0.05;

void setup() {
  size(240, 240);
  smooth();
  ellipseMode(CENTER);
}
void draw() {
  background(100);
  float scalar = dist(mouseX, mouseY, width/2, height/2);
  float x = width/2 + cos(angle) * scalar;
  float y = height/2 + sin(angle) * scalar;
  noFill();
  ellipse(width/2, height/2, scalar*2, scalar*2);
  fill(255);
  ellipse(x, y, 40, 40);
  angle += speed;
}