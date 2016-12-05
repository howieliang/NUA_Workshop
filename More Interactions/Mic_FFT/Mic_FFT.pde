import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
Minim minim;
AudioInput in;
FFT fft;

void setup()
{
  size( 640, 480 );
  minim = new Minim( this );
  in = minim.getLineIn( Minim.STEREO, 512 );
  fft = new FFT( in.bufferSize(), in.sampleRate() );
  background( 0 );
}

void draw() {
  fill( 255, 8 );
  noStroke();
  rect( 0, 0, width, height );
  fft.forward( in.mix );
  strokeWeight( 4 );
  strokeCap( SQUARE );
  stroke( 0 );
  for ( int i = 0; i < fft.specSize(); i++ ) {
    line( i*4, height, i*4, height - fft.getBand( i ) * 20 );
  }
  //background(204);
  //strokeWeight(5);
  //float r = 0;
  //for ( int i = 0; i < in.bufferSize(); i++ ) {
  //  r += abs( in.mix.get( i ) ) * 20;
  //}
  //float mx = max(r/3-15, 0); 
  
  //for (int x = 20; x < width; x += 20) {
  //  //float mx = mouseX / 10;
  //  float offsetA = random(-mx, mx);
  //  float offsetB = random(-mx, mx);
  //  line(x + offsetA, 20, x - offsetB, 220);
  //}
}
void stop() {
  in.close();
  minim.stop();
  super.stop();
}