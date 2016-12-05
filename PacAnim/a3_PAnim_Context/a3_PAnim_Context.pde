int radius = 40;
int x = -radius;
int speed = 2;

int mouthAngle = 0;

int bonusRadius = 5;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
}

void draw() {
  background(0);

  x += speed; // Increase the value of x
  if (x > width+radius) {
    x = -radius;
  }
  
  fill(255,255,255);
  for (int i = 0; i < width; i+=30) {
    if(i>x) ellipse(i, 60, bonusRadius*2, bonusRadius*2);
  }

  mouthAngle+=1;
  fill(255, 255, 0);
  arc(x, 60, radius, radius, radians(0+mouthAngle), radians(360-mouthAngle));
  if (mouthAngle>30) {
    mouthAngle=0;
  }
} 