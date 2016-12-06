int radius = 40;

void setup() {
  size(500,500);
}

void draw() {
  if (mousePressed) {
    fill(0);
  } else {
    fill(255);
  }
  if(keyPressed){
    if(key == 'a'){
      radius = radius + 1;
    }
    if(key == 'z'){
      radius = radius - 1;
    }
  }
  ellipse(mouseX, mouseY, radius*2, radius*2);
}

void keyReleased(){
  if(key == ENTER){
    background(192);
  }
}
