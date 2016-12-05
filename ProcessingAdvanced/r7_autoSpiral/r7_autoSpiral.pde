float angle = 0.0;
float offset = 60;
float scalar = 2;
float speed = 0.15;
void setup() {
  size(240,240);
  fill(0);
  smooth();
}
void draw() {
  float x = width/2 + cos(angle) * scalar;
  float y = height/2 + sin(angle) * scalar;
  ellipse( x, y, 2, 2);
  angle += speed;
  scalar += speed;
}