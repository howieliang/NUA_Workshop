int radius = 40;
int x = radius;
int speed = 0;

int mouthAngle = 0;
int faceAngle = 0;

int bonusRadius = 5; 
ArrayList<Bonus> bonusList;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);

  bonusList = new ArrayList<Bonus>();
  initBonus();
}

void draw() {
  background(0);
  movePacman();
  checkBoundaries();

  for (int i = bonusList.size()-1; i>=0; i--) {
    Bonus b = bonusList.get(i);
    if ((x-b.x)<bonusRadius && (x-b.x)>-bonusRadius) bonusList.remove(i);
  }
  
  for (Bonus b : bonusList) {
    b.display();
  }

  showPacman();  
  showText();
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

void keyReleased() {
  if ((key == CODED)) {  // If it’s a coded key
    if (keyCode == RIGHT) {
      speed = 0;
    } else if (keyCode == LEFT) {
      speed = 0;
    }
  }
}