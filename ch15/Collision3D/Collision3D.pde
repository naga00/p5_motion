Ball3D[] balls;
static final int numBalls = 20;
float fl = 250;
float vpX = 0;
float vpY = 0;
float top = -200;
float bottom = 200;
float left = -200;
float right = 200;
float front = 200;
float back = -200;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  vpX = width/2;
  vpY = height/2;
  balls = new Ball3D[numBalls];
  for(int i=0; i<numBalls; i++) {
    balls[i] = new Ball3D(15.0);
    balls[i].xpos = random(400) - 200;
    balls[i].ypos = random(400) - 200;
    balls[i].zpos = random(400) - 200;
    balls[i].vx = random(10) - 5;
    balls[i].vy = random(10) - 5;
    balls[i].vz = random(10) - 5;
    balls[i].setFillColor(color(255, 0, 0));   
  }
}

void draw() {
  background(255);
  for(int i=0; i<numBalls; i++) {
    Ball3D ball = balls[i];
    move(ball);
  }
  for(int i=0; i<numBalls - 1; i++) {
    Ball3D ballA = balls[i];
    for(int j=i+1; j<numBalls; j++) {
      Ball3D ballB = balls[j];
      float dx = ballA.xpos - ballB.xpos;
      float dy = ballA.ypos - ballB.ypos;
      float dz = ballA.zpos - ballB.zpos;
      float dist = sqrt(dx * dx + dy * dy + dz * dz);
      if(dist < ballA.radius + ballB.radius) {
        ballA.setFillColor(color(0, 0, 255));
        ballB.setFillColor(color(0, 0, 255));
      }
    }
  }
  sortZ();
}

void move(Ball3D ball) {
  float radius =  ball.radius;
  ball.xpos += ball.vx;
  ball.ypos += ball.vy;
  ball.zpos += ball.vz;
  if(ball.xpos + radius > right) {
    ball.xpos = right - radius;
    ball.vx *= -1;
  }else if(ball.xpos - radius < left) {
    ball.xpos = left + radius;
    ball.vx *= -1;
  }
  if(ball.ypos + radius > bottom) {
    ball.ypos = bottom - radius;
    ball.vy *= -1;
  }else if(ball.ypos - radius < top) {
    ball.ypos = top + radius;
    ball.vy *= -1;
  }
  if(ball.zpos + radius > front) {
    ball.zpos = front - radius;
    ball.vz *= -1;
  }else if(ball.zpos - radius < back) {
    ball.zpos = back + radius;
    ball.vz *= -1;
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
}

void sortZ() {
  for(int i=0; i<numBalls - 1; i++) {
    for(int j=numBalls-1; j>i; j--) {
      if(balls[j].zpos > balls[j-1].zpos) {
        Ball3D t = balls[j];
        balls[j] = balls[j-1];
        balls[j-1] = t;
      }
    }
  }
  for(int i=0; i<numBalls; i++) {
     Ball3D ball = balls[i];
     ball.update();
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


