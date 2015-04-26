Ball ball;
Line[] lineObjs;
static final int numLines = 5;
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
  ball = new Ball(20);
  ball.x = 110;
  ball.y = 50;
  ball.setFillColor(color(255, 0, 0));
  
  lineObjs = new Line[numLines];
  for(int i=0; i<numLines; i++) {
    lineObjs[i] = new Line();
    lineObjs[i].setStrokeColor(color(0, 0, 0));
    lineObjs[i].moveTo(0, 0);
    lineObjs[i].lineTo(50, 0);  
  }

  lineObjs[0].x = 100;
  lineObjs[0].y = 100;
  lineObjs[0].rotation = 30;
  
  lineObjs[1].x = 100;
  lineObjs[1].y = 230;
  lineObjs[1].rotation = 45;
  
  lineObjs[2].x = 250;
  lineObjs[2].y = 180;
  lineObjs[2].rotation = -30;

  lineObjs[3].x = 150;
  lineObjs[3].y = 330;
  lineObjs[3].rotation = 10;

  lineObjs[4].x = 230;
  lineObjs[4].y = 250;
  lineObjs[4].rotation = -30; 

}

void draw() {
  background(255);
  
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
  
  for(int i=0; i<numLines; i++) {
    checkLine(lineObjs[i]);
    lineObjs[i].update();
  }  
 
  noStroke();
  ball.update();
}

void checkLine(Line lineObj) {
  Rectangle bounds = lineObj.getBounds();
  println(bounds.left);
  println(bounds.right);
  
  stroke(255, 0, 0);
  rect(bounds.x, bounds.y, bounds.width, bounds.height);
  
  if(ball.x > bounds.left && ball.x < bounds.right) {
    float angle = lineObj.rotation * PI / 180;
    float cosine = cos(angle);
    float sine = sin(angle);
    float x1 = ball.x - lineObj.x;
    float y1 = ball.y - lineObj.y;
    float y2 = cosine * y1 - sine * x1;
    float vy1 = cosine * ball.vy - sine * ball.vx;
        
    if(y2 > -ball.height / 2 && y2 < vy1){
      float x2 = cosine * x1 + sine * y1;
      float vx1 = cosine * ball.vx + sine * ball.vy;

      y2 = -ball.height / 2;
      vy1 *= bounce;
      x1 = cosine * x2 - sine * y2;
      y1 = cosine * y2 + sine * x2;
      ball.vx = cosine * vx1 - sine * vy1;
      ball.vy = cosine * vy1 + sine * vx1;
      ball.x = lineObj.x + x1;
      ball.y = lineObj.y + y1;
    }
  }
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
  float fromX, fromY;
  float toX, toY;
  
  Line() {
  }
  
  void moveTo(float x, float y) {
    fromX = x;
    fromY = y;
  }
  
  void lineTo(float toX, float toY) {
    this.toX = toX;
    this.toY = toY;
    width = toX;
    height = toY;
  }
  
  Rectangle getBounds() {
    return new Rectangle(x + fromX, y, width, height);
  }
  
  void draw() {
    line(fromX, fromY, toX, toY);
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

class Point {
  float x, y;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

