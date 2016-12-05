float angle = 0.0;
float scalar = 40;
float speed = 3;
void setup() {
  size(240, 240);
  smooth();
}
void draw() {
  background(100);
  float y1 = height/2 + sin(radians(angle)) * scalar;
  float y2 = height/2 + sin(radians(angle + 30)) * scalar;
  float y3 = height/2 + sin(radians(angle + 60)) * scalar;
  ellipse( 80, y1, 40, 40);
  ellipse(120, y2, 40, 40);
  ellipse(160, y3, 40, 40);
  angle += speed;
}