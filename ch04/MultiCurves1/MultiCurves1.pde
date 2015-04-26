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
}

void draw() {
  background(255);
  stroke(0, 0, 0);
  noFill(); 
  beginShape();
  vertex(points[0].x, points[0].y);
  for (int i = 1; i < numPoints; i += 2){
    bezierVertex(points[i-1].x, points[i-1].y, points[i].x, points[i].y, points[i+1].x, points[i+1].y);
  }
  endShape();
}

////////////////////////////////

class Point {
  float x, y;
  
  Point() {
    x = 0;
    y = 0;
  }
}
