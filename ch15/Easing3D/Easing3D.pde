Ball3D ball;
float tx, ty, tz;
float easing = 0.1;
float fl = 250;
float vpX = 0;
float vpY = 0;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  vpX = width/2;
  vpY = height/2;
  ball = new Ball3D(50);
  ball.setFillColor(color(255, 0, 0));
  tx = random(500) - 250;
  ty = random(500) - 250;
  tz = random(500);    
}

void draw() {
  background(255);

  float dx = tx - ball.xpos;
  float dy = ty - ball.ypos;
  float dz = tz - ball.zpos;
  ball.xpos += dx * easing;
  ball.ypos += dy * easing;
  ball.zpos += dz * easing;
      
  float dist = sqrt(dx*dx + dy*dy + dz*dz);
  if(dist < 1) {
    tx = random(500) - 250;
    ty = random(500) - 250;
    tz = random(500);
  }
    
  if(ball.zpos > -fl) {
    float scale = fl / (fl + ball.zpos);
    ball.scaleX = ball.scaleY = scale;
    ball.x = vpX + ball.xpos * scale;
    ball.y = vpY + ball.ypos * scale;
    ball.visible = true;
  }else{
    ball.visible = false;
  }
  ball.update();
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

class Ball3D extends Sprite {
  float radius;
  float xpos = 0;
  float ypos = 0;
  float zpos = 0;
  float vx = 0;
  float vy = 0;
  float vz = 0;
  float mass = 1;
  
  Ball3D(float radius){
    super();
    this.radius = radius;
  }
  
  void draw(){
    if(dist(mouseX, mouseY, x, y) < radius) {
      isRollOver = true;
    }else{
      isRollOver = false;
    }
    ellipse(0, 0, radius*2, radius*2);
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


