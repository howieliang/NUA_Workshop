int radius = 40;
int x = -radius;
int speed = 2;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
}

void draw() {
  background(0);
  fill(255, 255, 0);
  x += speed; // Increase the value of x
  if (x > width+radius) {
    x = -radius;
  }
  arc(x, 60, radius, radius, radians(30), radians(330));
} 