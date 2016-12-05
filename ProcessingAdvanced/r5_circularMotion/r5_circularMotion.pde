float angle = 0.0;
float scalar = 60;
float speed = 0.05;

void setup() {
  size(240, 240);
  smooth();
}
void draw() {
  background(100);
  float x = width/2 + cos(angle) * scalar;
  float y = height/2 + sin(angle) * scalar;
  ellipse( x, y, 40, 40);
  angle += speed;
}