PImage grad;
PShader s;
PFont font;
PGraphics pg;
int w, h;
float frac=20;


void setup() {
  //size(640, 480, P3D);
  fullScreen(P3D);
  noCursor();
  //noStroke();
  frameRate(120);
  smooth();
  font = createFont("Arial Bold", 48);

  w = (int)(displayWidth/frac);
  h = (int)(displayHeight/frac);

  pg = createGraphics(w/2, h/2, P3D);
  grad = loadImage("gradient-01.png");
  s = loadShader("shader.glsl");
  s.set("srcSampler", grad);
}

void draw() {

  pg.beginDraw();
  s.set("resolution", w, h);
  s.set("millis", millis());

  pg.shader(s);
  pg.beginShape(QUAD);
  pg.vertex(0, 0, 0, 0);
  pg.vertex(w, 0, 1, 0);
  pg.vertex(w, h, 1, 1);
  pg.vertex(0, h, 0, 1);
  pg.endShape();
  pg.endDraw();

  image(pg, 0, 0, width, height);


  textFont(font, 36);
  fill(255);
  text(frameRate, 20, 45);
}

void keyPressed() {
}
