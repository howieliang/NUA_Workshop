int radius = 40;
int x = radius;
int speed = 0;

int mouthAngle = 0;
int faceAngle = 0;

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
  if (x < 0-radius) {
    x = width+radius;
  }
  
  fill(255, 255, 255);
  for (int i = 0; i < width; i+=30) {
    if (i>x) ellipse(i, 60, bonusRadius*2, bonusRadius*2);
  }

  mouthAngle+=1;
  fill(255, 255, 0);
  if(speed>0) faceAngle = 0;
  if(speed<0) faceAngle = -180;
  
  arc(x, 60, radius, radius, radians(faceAngle+mouthAngle), radians((faceAngle+360)-mouthAngle));
  if (mouthAngle>30) {
    mouthAngle=0;
  }
} 

void keyPressed() {
  if ((key == CODED)) {  // If it’s a coded key
    if (keyCode == RIGHT) {
      speed = 2;
    } else if (keyCode == LEFT) {
      speed = -2;
    }
  }
}

void keyReleased(){
  if ((key == CODED)) {  // If it’s a coded key
    if (keyCode == RIGHT) {
      speed = 0;
    } else if (keyCode == LEFT) {
      speed = 0;
    }
  }
}