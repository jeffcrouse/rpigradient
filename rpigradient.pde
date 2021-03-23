//import processing.video.*; //<>//
import java.time.*;
import java.util.Comparator;
import java.util.Collections;
//Movie vid;

int MILLIS_IN_DAY = 86400000;

PImage grad;
PShader s;
PFont font;
PGraphics pg;
int w, h;
float frac = .4;
Polyline timeline = new Polyline();
Boolean debug = false;

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  noCursor();

  //frameRate(60);
  smooth();
  font = createFont("Arial Bold", 48);

  w = (int)(displayWidth * frac);
  h = (int)(displayHeight * frac);

  timeline.add(0, 0.1);
  timeline.add(ntime(LocalTime.of(6, 0)), 0.1);    // 5am - full brightness
  timeline.add(ntime(LocalTime.of(6, 30)), 1);    // 5am - full brightness
  timeline.add(ntime(LocalTime.of(22, 30)), 1);  // 10:30pm - still at full
  timeline.add(ntime(LocalTime.of(23, 0)), 0.1);  // 11pm - 0 brightness
  timeline.add(1, 0.1);
  timeline.printPts();

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


// Get the normalized time of the day
float ntime(LocalTime t) {
  Duration d = Duration.between(LocalTime.of(0, 0), t) ;
  return d.toMillis() / (float)MILLIS_IN_DAY;
}


void draw() {
  background(0);
  float now = ntime(LocalTime.now());

  pg.beginDraw();
  s.set("resolution", w, h);
  s.set("millis", millis());
  s.set("brightness", timeline.getValueAt(now));
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

  if (debug) {
    strokeWeight(4);  // Thicker
    stroke(255);
    timeline.draw(100);

    // Draw 
    stroke(255, 100, 100);
    float x = now * width;
    line(x, height-120, x, height);
    text(timeline.getValueAt(now), x, height-160);


    textFont(font, 24);
    fill(255);
    text(frameRate, 20, 45);
  }
}

//void movieEvent(Movie m) {
//  m.read();
//}

void keyPressed() {
}
