Point[] points;
final static int numPoints = 9;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  points = new Point[numPoints];
  
  for(int i=0; i<numPoints; i++){
    points[i] = new Point();
    points[i].x = random(width);
    points[i].y = random(height);
  }
  points[0].x = 0;
  points[0].y = 0;
}

void draw() {
  background(255);
  stroke(0, 0, 0);
  //fill(255, 0, 0);
  noFill();
  beginShape();
  int i;
  curveVertex(0, 0);
  curveVertex(0, 0);
  for(i=1; i<numPoints; i++){
    curveVertex(points[i].x, points[i].y);
  
  }
  curveVertex(0, 0);
  curveVertex(0, 0);
  endShape(CLOSE);
}

////////////////////////////////

class Point {
  float x, y;
  
  Point() {
    x = 0;
    y = 0;
  }
}
