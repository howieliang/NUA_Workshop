JitterBug bug;  // Declare object

void setup() {
  size(480, 480);
  smooth();
  // Create object and pass in parameters
  bug = new JitterBug(width/2, height/2, 20);
}
void draw() {
  background(100);
  bug.move();
  bug.display();
}