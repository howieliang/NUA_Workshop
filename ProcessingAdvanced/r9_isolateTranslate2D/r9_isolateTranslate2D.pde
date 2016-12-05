void setup() {
  size(240, 240);
  rectMode(CENTER);
}
void draw() {
  background(100);
  
  pushMatrix();
  translate(mouseX, mouseY);
  rect(0, 0, 30, 30);
  popMatrix();
  
  translate(width/2, height/2);
  rect(0, 0, 15, 15);
}