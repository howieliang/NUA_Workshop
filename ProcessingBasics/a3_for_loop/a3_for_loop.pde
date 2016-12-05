size(480, 120);
background(0);
smooth();
noStroke();
fill(255, 140);
//No loop
ellipse(0, 60, 40, 40);
ellipse(40, 60, 40, 40);
ellipse(80, 60, 40, 40);
ellipse(120, 60, 40, 40);
ellipse(160, 60, 40, 40);

//Loop1
//for (int x = 0; x <= width; x += 40) {
//  ellipse(x, 60, 40, 40);
//}

////Loop2
//for (int y = 0; y <= height; y += 40) {
//  for (int x = 0; x <= width; x += 40) {
//    ellipse(x, y, 40, 40);
//  }
//}

////Loop3
//for (int y = 0; y < height+45; y += 40) {
//  ellipse(0, y, 40, 40);
//}
//for (int x = 0; x < width+45; x += 40) {
//  ellipse(x, 0, 40, 40);
//}