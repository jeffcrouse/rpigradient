import processing.video.*;
Movie vid;


PImage grad;
PShader s;
PFont font;
PGraphics pg;
int w, h;
float frac = .4;


void setup() {
  fullScreen(P3D);
  noCursor();
  noStroke();
  frameRate(60);
  smooth();
  font = createFont("Arial Bold", 48);

  w = (int)(displayWidth * frac);
  h = (int)(displayHeight * frac);

  vid = new Movie(this, "dating.mp4");
  vid.loop();
  vid.volume(0);
  vid.speed(0.5);
  vid.play();

  pg = createGraphics(w, h, P3D);
  grad = loadImage("gradient-01.png");
  s = loadShader("shader.glsl");
  s.set("srcSampler", grad);
}

void draw() {

  drawGradient();

  textFont(font, 36);
  fill(255);
  text(frameRate, 20, 45);
}

void drawGradient() {
  pg.beginDraw();
  s.set("resolution", w, h);
  s.set("millis", millis());
  s.set("movie", vid);

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

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
}
