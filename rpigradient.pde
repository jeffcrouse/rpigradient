PImage grad;
PShader s;


void setup() {
  size(640, 480, P3D);
  //fullScreen(P3D);
  noCursor();
  noStroke();
  grad = loadImage("gradient-01.png");
  s = loadShader("shader.glsl");
  s.set("srcSampler", grad);
}

void draw() {

  s.set("resolution", width, height);
  s.set("millis", millis());
  shader(s);
  
  beginShape(QUAD);
  vertex(0, 0, 0, 0);
  vertex(width, 0, 1, 0);
  vertex(width, height, 1, 1);
  vertex(0, height, 0, 1);
  endShape();
}

void keyPressed() {
}
