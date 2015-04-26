Segment[] segments;
static final int numSegments = 6;
float gravity = 0.5;
float bounce = -0.9;
Ball ball;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  ball = new Ball(20);
  ball.vx = 10;
  ball.setFillColor(color(255, 0, 0));
  
  segments = new Segment[numSegments];
  for(int i=0; i<numSegments; i++) {
    segments[i] = new Segment(50, 10); 
    segments[i].setFillColor(color(255, 255, 255));
  }
  segments[numSegments-1].x = width/2;
  segments[numSegments-1].y = height;
}

void draw() {
  background(255);

  moveBall();
  Point target = reach(segments[0], ball.x, ball.y);
  for(int i=1; i<numSegments; i++){
    Segment segment = segments[i];
    target = reach(segment, target.x, target.y);
  }
      
  for(int i=numSegments - 1; i>0; i--){
    Segment segmentA = segments[i];
    Segment segmentB = segments[i - 1];
    position(segmentB, segmentA);
  }
      
  checkHit();
  stroke(0);
  for(int i=0; i<numSegments; i++){
    segments[i].update();
  }
  noStroke();
  ball.update();
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

void moveBall() {
  ball.vy += gravity;
  ball.x += ball.vx;
  ball.y += ball.vy;
  if(ball.x + ball.radius > width){
    ball.x = width - ball.radius;
    ball.vx *= bounce;
  }else if(ball.x - ball.radius < 0){
    ball.x = ball.radius;
    ball.vx *= bounce;
  }
      
  if(ball.y + ball.radius > height){
    ball.y = height - ball.radius;
    ball.vy *= bounce;
  }else if(ball.y - ball.radius < 0){
    ball.y = ball.radius;
    ball.vy *= bounce;
  }
}

void checkHit() {
  Segment segment = segments[0];
  float dx = segment.getPin().x - ball.x;
  float dy = segment.getPin().y - ball.y;
  float dist = sqrt(dx * dx + dy * dy);
  if(dist < ball.radius){
    ball.vx += random(2) - 1;
    ball.vy -= 1;
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

class Ball extends Sprite {
  float radius;
  float vx, vy;
  float mass = 1;
  
  Ball(float radius){
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


