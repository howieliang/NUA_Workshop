void setup() {
  size(240, 240);
  rectMode(CENTER);
}
void draw() {
  background(100);
  translate(mouseX, mouseY);
  rect(0, 0, 30, 30);
}