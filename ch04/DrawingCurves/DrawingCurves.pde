float x0 = 100;
float y0 = 200;
float x1;
float y1;
float x2 = 300;
float y2 = 200;

void setup() {
  size(960, 540);
  frameRate(30);
}

void draw() {
  background(255);
  stroke(0);
  noFill();
  
  x1 = mouseX;
  y1 = mouseY;
  
  beginShape();
  vertex(x0, y0);
  bezierVertex(x0, y0, x1, y1, x2, y2);
  endShape();
}

