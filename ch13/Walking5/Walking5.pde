Segment segment0;
Segment segment1;
Segment segment2;
Segment segment3;
SimpleSlider speedSlider;
SimpleSlider thighRangeSlider;
SimpleSlider thighBaseSlider;
SimpleSlider calfRangeSlider;
SimpleSlider calfOffsetSlider;
float cycle;


void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();

  segment0 = new Segment(100, 30);
  segment0.x = 200;
  segment0.y = 100;
      
  segment1 = new Segment(100, 20);
  segment1.x = segment0.getPin().x;
  segment1.y = segment0.getPin().y;

  segment2 = new Segment(100, 30);
  segment2.x = 200;
  segment2.y = 100;
      
  segment3 = new Segment(100, 20);
  segment3.x = segment2.getPin().x;
  segment3.y = segment2.getPin().y;
}

void draw() {
  background(255);

  walk(segment0, segment1, cycle);
  walk(segment2, segment3, cycle + PI);
  cycle += 0.05;
      
  segment0.update();
  segment1.update();
  segment2.update();
  segment3.update(); 
}

void walk(Segment segA, Segment segB, float cyc) {
  float angleA = sin(cyc) * 45 + 90;
  float angleB = sin(cyc + offset) * 45 + 45;
  segA.rotation = angleA;
  segB.rotation = segA.rotation + angleB;
  segB.x = segA.getPin().x;
  segB.y = segA.getPin().y;
}

////////////////////////////////

class SimpleSlider extends Sprite {
  float _width = 16;
  float _height = 100;
  float _value;
  float _max = 100;
  float _min = 0;
  
  SimpleSlider() {
    super();
  }
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


