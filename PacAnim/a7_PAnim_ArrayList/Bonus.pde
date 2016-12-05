class Bonus{
  int x;
  int y;
  int radius;
  
  Bonus(int x_, int y_, int radius_){
    x = x_;
    y = y_;
    radius = radius_;
  }
  
  void update(int x_, int y_, int radius_){
    x = x_;
    y = y_;
    radius = radius_;
  }
  
  void display(){
    pushStyle();
    ellipseMode(CENTER);
    fill(255, 255, 255);
    ellipse(x,y,radius,radius);
    popStyle();
  }
}