void setup() {
  size(240, 240);
}
void draw() {
  background(204);
  strokeWeight(5);
  for (int x = 20; x < width; x += 20) {
    float mx = mouseX / 10;
    float offsetA = random(-mx, mx);
    float offsetB = random(-mx, mx);
    line(x + offsetA, 20, x - offsetB, 220);
  }
}