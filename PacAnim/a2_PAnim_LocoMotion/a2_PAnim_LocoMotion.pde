int radius = 40;
int x = -radius;
int speed = 2;

int mouthAngle = 0;

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
  
  mouthAngle+=1;
  arc(x, 60, radius, radius, radians(0+mouthAngle), radians(360-mouthAngle));
  if (mouthAngle>30){
    mouthAngle=0;
  }
} 