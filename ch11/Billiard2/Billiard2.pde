Ball ball0;
Ball ball1;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();

  ball0 = new Ball(40);
  ball0.mass = 2;
  ball0.x = 50;
  ball0.y = height / 2;
  ball0.vx = 1;
  ball0.setFillColor(color(255, 0, 0));
  
  ball1 = new Ball(25);
  ball1.mass = 1;
  ball1.x = 300;
  ball1.y = height / 2;
  ball1.vx = -1;
  ball1.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
  
  ball0.x += ball0.vx;
  ball1.x += ball1.vx;
  float dist = ball1.x - ball0.x;
  if(abs(dist) < ball0.radius + ball1.radius){
    float vxTotal = ball0.vx - ball1.vx;
    ball0.vx = ((ball0.mass - ball1.mass) * ball0.vx + 2 * ball1.mass * ball1.vx) / (ball0.mass + ball1.mass);
    ball1.vx = vxTotal + ball0.vx;
    ball0.x += ball0.vx;
    ball1.x += ball1.vx;
  }
  ball0.update();
  ball1.update();  
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


