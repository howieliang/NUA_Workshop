import processing.serial.*;

Serial port;  // Create object from Serial class
int data_Num = 60;
int[] serialData = new int[data_Num];

int circleR = 50;

int i = 0;
float[] data = new float[400];
void setup()
{
  size(240, 240);
  //println(Serial.list());
  String portName = Serial.list()[Serial.list().length-1];
  port = new Serial(this, portName, 115200);
  port.write('a');
  ellipseMode(CENTER);
  textMode(CENTER);

}

void draw()
{
  getSerialMsg();
  background(192);
  float mx = max((getAmplitude(serialData)-15), 0);
  data[i%data.length] = mx;
  println(data[i%data.length]);
  i++;
  strokeWeight(5);
  for (int x = 20; x < width; x += 20) {
    //float mx = mouseX / 10;
    float offsetA = random(-mx, mx);
    float offsetB = random(-mx, mx);
    line(x + offsetA, 20, x - offsetB, 220);
  }
  //barGraph(data);
}

float getAmplitude(int[] serialData) {
  float[] d = {0, 0, 0};
  for (int i = 3; i < serialData.length; i+=3) {
    float x1 = map(serialData[i], 0, 255, 0, height);
    float x0 = map(serialData[i-3], 0, 255, 0, height);
    float y1 = map(serialData[i+1], 0, 255, 0, height);
    float y0 = map(serialData[i-2], 0, 255, 0, height);
    float z1 = map(serialData[i+2], 0, 255, 0, height);
    float z0 = map(serialData[i-1], 0, 255, 0, height);
    d[0] += abs(x1-x0);
    d[1] += abs(y1-y0);
    d[2] += abs(z1-z0);
  }
  return max(d);
}


void barGraph(float[] data) {
  // set up plot dimensions relative to screen size float x = width*0.1;
  float x = 0;
  float y = height*0.9;
  float delta = width*0.8/data.length;
  float w = delta*0.8;
  for (float i : data) {
    float h = map(i, 0, 100, 0, height);
    fill(0);
    rect(x, y-h, w, h);
    x = x + delta;
  }
}