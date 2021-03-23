//import processing.video.*; //<>//
import java.time.*;
//Movie vid;

int MILLIS_IN_DAY = 86400000;

PImage grad;
PShader s;
PFont font;
PGraphics pg;
int w, h;
float frac = .4;
Polyline timeline = new Polyline();



class Polyline {

  ArrayList<Float> x = new ArrayList<Float>();
  ArrayList<Float> y = new ArrayList<Float>();

  void add(float _x, float _y) {
    x.add(_x);
    y.add(_y);
  }

  float getValueAt(float x) {
    return 1.0;
  }

  void draw(float x_scale, float y_scale) {
    // Draw Brightness Timeline
    strokeWeight(4);  // Thicker
    stroke(255);
    beginShape(LINES);
    for (int i=0; i<x.size()-1; i++) {
      vertex(x.get(i) * x_scale, height-(y.get(i) * y_scale));
      vertex(x.get(i+1) * x_scale, height-(y.get(i+1) * y_scale));
    }
    endShape();
  }
}


void setup() {
  size(1920, 1080, P3D);
  //fullScreen(P3D);
  //noCursor();
  //frameRate(60);
  smooth();
  font = createFont("Arial Bold", 48);

  w = (int)(displayWidth * frac);
  h = (int)(displayHeight * frac);

  timeline.add(0, 0.1);
  timeline.add(getDaystamp(6, 0), 0.1);    // 5am - full brightness
  timeline.add(getDaystamp(6, 30), 1);    // 5am - full brightness
  timeline.add(getDaystamp(22, 30), 1);  // 10:30pm - still at full
  timeline.add(getDaystamp(23, 0), 0.1);  // 11pm - 0 brightness
  timeline.add(1, 0.1);

  //vid = new Movie(this, "dating.mp4");
  //vid.loop();
  //vid.volume(0);
  //vid.speed(0.5);
  //vid.play();

  pg = createGraphics(w, h, P3D);
  grad = loadImage("gradient-01.png");
  s = loadShader("shader.glsl");
  s.set("srcSampler", grad);
}

float getDaystamp(int hours, int min) {
  Duration d = Duration.between(LocalTime.of(0, 0), LocalTime.of(hours, min)) ;
  return d.toMillis() / (float)MILLIS_IN_DAY;
}

float now() {
  Duration d = Duration.between(LocalTime.of(0, 0), LocalTime.now()) ;
  return d.toMillis() / (float)MILLIS_IN_DAY;
}


void draw() {
  background(0);
  drawGradient();

  timeline.draw(width, 100);

  // Draw 
  stroke(255, 100, 100);
  float x = now() * width;
  line(x, height-120, x, height);

  textFont(font, 36);
  fill(255);
  text(frameRate, 20, 45);
}

void drawGradient() {

  pg.beginDraw();
  s.set("resolution", w, h);
  s.set("millis", millis());
  s.set("brightness", timeline.getValueAt(now()));
  //s.set("movie", vid);

  pg.noStroke();
  pg.shader(s);
  pg.beginShape(QUAD);
  pg.vertex(0, 0, 0, 0);
  pg.vertex(w, 0, 1, 0);
  pg.vertex(w, h, 1, 1);
  pg.vertex(0, h, 0, 1);
  pg.endShape();
  pg.endDraw();
  image(pg, 0, 0, width, height);
}

//void movieEvent(Movie m) {
//  m.read();
//}

void keyPressed() {
}
