Segment[] segments;
static final int numSegments = 6;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  segments = new Segment[numSegments];
  for(int i=0; i<numSegments; i++) {
    segments[i] = new Segment(50, 10); 
  }
  segments[numSegments-1].x = width/2;
  segments[numSegments-1].y = height/2;
}

void draw() {
  background(255);

  Point target = reach(segments[0], mouseX, mouseY);
  for(int i=1; i<numSegments; i++){
    Segment segment = segments[i];
    target = reach(segment, target.x, target.y);
  }
  
  for(int i = numSegments - 1; i > 0; i--){
    Segment segmentA = segments[i];
    Segment segmentB = segments[i - 1];
    position(segmentB, segmentA);
  }
  
  for(int i=0; i<numSegments; i++){
    segments[i].update();
  }
}

Point reach(Segment segment, float xpos, float ypos) {
  float dx = xpos - segment.x;
  float dy = ypos - segment.y;
  float angle = atan2(dy, dx);
  segment.rotation = angle * 180 / PI;
  float w = segment.getPin().x - segment.x;
  float h = segment.getPin().y - segment.y;
  float tx = xpos - w;
  float ty = ypos - h;
  return new Point(tx, ty);
}

void position(Segment segmentA, Segment segmentB) {
  segmentA.x = segmentB.getPin().x;
  segmentA.y = segmentB.getPin().y;
}

////////////////////////////////

class Segment extends Sprite {
  float segmentWidth, segmentHeight;
  float vx, vy;
  
  Segment(float segmentWidth, float segmentHeight) {
    super();
    this.segmentWidth = segmentWidth;
    this.segmentHeight = segmentHeight;
  }
  
  void draw() {
    rect(-segmentHeight / 2,  -segmentHeight / 2, segmentWidth + segmentHeight, segmentHeight, segmentHeight, segmentHeight, segmentHeight, segmentHeight);
    ellipse(0, 0, 2, 2);
    ellipse(segmentWidth, 0, 2, 2);
  }
  
  Point getPin() {
    float angle = rotation * PI / 180;
    float xPos = x + cos(angle) * segmentWidth;
    float yPos = y + sin(angle) * segmentWidth;
    return new Point(xPos, yPos);  
  }
}

////////////////////////////////

class Sprite extends Object {
  float x, y;
  float scaleX, scaleY;
  float width, height;
  float rotation;
  boolean visible;
  color strokeColor;
  color fillColor;
  Boolean isStroke;
  Boolean isFill;
  Boolean isRollOver;
  Boolean locked;
  float xoff, yoff;
 
  Sprite() {
    super();
    scaleX = 1.0;
    scaleY = 1.0;
    strokeColor = color(0);
    fillColor = color(0);
    isStroke = false;
    isFill = false;
    isRollOver = false;
    locked = false;
    visible = true;
  }
  
  void update() {
    if(! visible) return;
    pushMatrix();
    if(locked){
      x = mouseX - xoff;
      y = mouseY - yoff;
    }  
    translate(x, y);
    scale(scaleX, scaleY);
    rotate(rotation * PI / 180.0);
    if(isStroke) stroke(strokeColor);
    if(isFill) fill(fillColor);
    draw();
    popMatrix();
  }
  
  void setStrokeColor(color strokeColor) {
    this.strokeColor = strokeColor;
    isStroke = true;
  }
  
  void setFillColor(color fillColor) {
    this.fillColor = fillColor;
    isFill = true;
  }
  
  void startDrag() {
    if(isRollOver){
      locked = true;
      xoff = mouseX - x;
      yoff = mouseY - y;
    }
  }
  
  void stopDrag() {
    locked = false;
  }
  
  void draw() {}
}

////////////////////////////////

class Point extends Object {
  float x, y;
  
  Point(float x, float y) {
    super();
    this.x = x;
    this.y = y;
  }
}

////////////////////////////////

class Object {
  Object() {}
}


