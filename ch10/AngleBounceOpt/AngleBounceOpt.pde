Ball ball;
Line lineObj;
float gravity = 0.3;
float bounce = -0.6;

void setup() {
  size(960, 700);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball(40);
  ball.x = 100;
  ball.y = 100;
  ball.setFillColor(color(255, 0, 0));
  
  lineObj = new Line();
  lineObj.setStrokeColor(color(0, 0, 0));
  lineObj.lineTo(300, 0);
  lineObj.x = 50;
  lineObj.y = 200;
  lineObj.rotation = 30;
}

void draw() {
  background(255);

  ball.vy += gravity;
  ball.x += ball.vx;
  ball.y += ball.vy;
  
  float angle = lineObj.rotation * PI / 180;
  float cosine = cos(angle);
  float sine = sin(angle);
  float x1 = ball.x - lineObj.x;
  float y1 = ball.y - lineObj.y;
  float y2 = cosine * y1 - sine * x1;

  if(y2 > -ball.height / 2){
    float x2 = cosine * x1 + sine * y1;
    float vx1 = cosine * ball.vx + sine * ball.vy;
    float vy1 = cosine * ball.vy - sine * ball.vx;
    y2 = -ball.height / 2;
    vy1 *= bounce;
    x1 = cosine * x2 - sine * y2;
    y1 = cosine * y2 + sine * x2;
    ball.vx = cosine * vx1 - sine * vy1;
    ball.vy = cosine * vy1 + sine * vx1;
    ball.x = lineObj.x + x1;
    ball.y = lineObj.y + y1;
  }

  lineObj.update();
  noStroke();
  ball.update();
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  
  Ball(float radius){
    super();
    this.radius = radius;
    width = radius*2;
    height = radius*2;
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

class Line extends Sprite {
  float toX, toY;
  
  Line() {
  }
  
  Rectangle getBounds() {
    return new Rectangle(x, y, width, height);
  }
  
  void lineTo(float toX, float toY) {
    this.toX = toX;
    this.toY = toY;
    width = toX;
    height = toY;
  }
  
  void draw() {
    line(0, 0, toX, toY);
  }
}

////////////////////////////////

class Rectangle {
  float x, y;
  float width, height; 
  float top, bottom;
  float left, right;
  Point topLeft, bottomRight;
  Point size;
  
  Rectangle(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    top = y;
    bottom = y + height;
    left = x;
    right = x + width;
    topLeft = new Point(x, y);
    bottomRight = new Point(right, bottom);
    size = new Point(width, height);
  }
}

////////////////////////////////

class Sprite {
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
    x = 0.0;
    y = 0.0;
    scaleX = 1.0;
    scaleY = 1.0;
    width = 0;
    height = 0;
    rotation = 0.0;
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

class Point {
  float x, y;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

