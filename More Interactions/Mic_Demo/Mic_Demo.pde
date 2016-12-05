import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
Minim minim;
AudioInput in;

void setup()
{
  size( 640, 480 );
  smooth();
  minim = new Minim( this );
  in = minim.getLineIn( Minim.STEREO, 512 );
  background( 0 );
}

void draw() {
  background(204);
  strokeWeight(5);
  float r = 0;
  for ( int i = 0; i < in.bufferSize(); i++ ) {
    r += abs( in.mix.get( i ) ) * 20;
  }
  float mx = max(r/3-15, 0); 
  
  for (int x = 20; x < width; x += 20) {
    //float mx = mouseX / 10;
    float offsetA = random(-mx, mx);
    float offsetB = random(-mx, mx);
    line(x + offsetA, 20, x - offsetB, 220);
  }
}
void stop() {
  in.close();
  minim.stop();
  super.stop();
}