int time1 = 2000;
int time2 = 4000;
float x = 0;
void setup() {
  size(480, 240);
  smooth();
}
void draw() {
  int currentTime = millis();
  background(204);
  if (currentTime > time2) {
    x -= 0.5;
  } else if (currentTime > time1) {
    x += 2.5;
  }
  ellipse(x, height/2, 90, 90);
}