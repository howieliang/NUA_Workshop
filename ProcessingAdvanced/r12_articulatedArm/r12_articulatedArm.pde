float angle = 0.0;
float angleDirection = 1;
float speed = 0.005;
void setup() {
  size(240, 240);
  rectMode(CENTER);
  //frameRate(500);
}
void draw() {
  background(204);
  pushMatrix();
  //scale(2);
  rect(60,60,120,120);
  
  translate(20, 25);  // Move to start position
  rotate(angle);
  strokeWeight(12);
  line(0, 0, 40, 0);
  
  translate(40, 0);   // Move to next joint
  rotate(angle * 2.0);
  strokeWeight(6);
  line(0, 0, 30, 0);
  
  translate(30, 0);   // Move to next joint
  rotate(angle * 2.5);
  strokeWeight(3);
  line(0, 0, 20, 0);
  
  angle += speed * angleDirection;
  if ((angle > QUARTER_PI) || (angle < 0)) {
    angleDirection *= -1;
  }
  popMatrix();
}