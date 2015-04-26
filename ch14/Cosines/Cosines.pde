Segment segment0;
Segment segment1;
float cycle;
float offset = - PI/2;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  
  segment0 = new Segment(100, 20);    
  segment1 = new Segment(100, 20);
  segment1.x = width/2;
  segment1.y = height/2;
}

void draw() {
  background(255);

  float dx = mouseX - segment1.x;
  float dy = mouseY - segment1.y;
  float dist = sqrt(dx * dx + dy * dy);
      
  float a = 100;
  float b = 100;
  float c = min(dist, a + b);
      
  float B = acos((b * b - a * a - c * c) / (-2 * a * c));
  float C = acos((c * c - a * a - b * b) / (-2 * a * b));
  float D = atan2(dy, dx);
  float E = D + B + PI + C;
      
  segment1.rotation = (D + B) * 180 / PI;
  segment0.x = segment1.getPin().x;
  segment0.y = segment1.getPin().y;
  segment0.rotation = E * 180 / PI;
      
  segment0.update();
  segment1.update();
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


