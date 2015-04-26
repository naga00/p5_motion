Ball ball;
float xpos = 0;
float ypos = 0;
float zpos = 0;
float vx = 0;
float vy = 0;
float vz = 0;
float friction = 0.98;
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
  noStroke();
  vpX = width/2;
  vpY = height/2;
  ball = new Ball(50);
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
      
  xpos += vx;
  ypos += vy;
  zpos += vz;
      
  vx *= friction;
  vy *= friction;
  vz *= friction;
      
  if(zpos > -fl) {
    float scale = fl / (fl + zpos);
    ball.scaleX = ball.scaleY = scale;
    ball.x = vpX + xpos * scale;
    ball.y = vpY + ypos * scale;
    ball.visible = true;
  }else{
    ball.visible = false;
  }  
  ball.update();
}

void keyPressed() {
  switch(keyCode) {
    case UP:
      vy -= 1;
      break;
    case DOWN:
      vy += 1;
      break;
    case LEFT:
      vx -= 1;
      break;
    case RIGHT:
      vx += 1;
      break;
    case ALT:
      vz += 1;
      break;
    case CONTROL:
      vz -= 1;
      break;
    default:
      break;
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


