PImage grad;
PShader s;
PGraphics pg;
int w = 1024;
int h = 768;

void setup() {
  //size(640, 480, P3D);
  fullScreen(P3D);
  noCursor();
  noStroke();
  pg = createGraphics(w, h, P3D);
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
}

void keyPressed() {
}
