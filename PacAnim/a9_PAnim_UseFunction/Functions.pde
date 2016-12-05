void initBonus() {
  for (int i = 0; i < width; i+=30) {
    Bonus b = new Bonus(i, 60, bonusRadius*2);
    bonusList.add(b);
  }
}

void movePacman() {
  x += speed; // Increase the value of x
}

void checkBoundaries() {
  if (x > width+radius) {
    x = -radius;
  }
  if (x < 0-radius) {
    x = width+radius;
  }
}

void showText() {
  fill(255);
  textSize(18);
  text("Bonus Left: " + bonusList.size(), 20, 140);
}

void showPacman() {
  mouthAngle+=1;
  fill(255, 255, 0);
  if (speed>0) faceAngle = 0;
  if (speed<0) faceAngle = -180;
  arc(x, 60, radius, radius, radians(faceAngle+mouthAngle), radians((faceAngle+360)-mouthAngle));
  if (mouthAngle>30) {
    mouthAngle=0;
  }
}