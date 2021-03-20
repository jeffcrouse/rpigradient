PImage grad;
PShader s;


void setup() {
  size(640, 480, P2D);
  //fullScreen(P2D);
  noCursor();
  grad = loadImage("gradient-01.png");
  s = loadShader("shader.glsl");
  s.set("srcSampler", grad);
}

void draw() {
  s.set("resolution", width, height);
  s.set("millis", millis());
  shader(s);
  rect(0, 0, width, height);
}
