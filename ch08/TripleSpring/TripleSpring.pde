Ball ball0;
Ball ball1;
Ball ball2;
Boolean ball0Dragging = false;
Boolean ball1Dragging = false;
Boolean ball2Dragging = false;
float spring = 0.1;
float friction = 0.9;
int springLength = 100;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball0 = new Ball();
  ball0.x = random(width);
  ball0.y = random(height);
  ball0.radius = 20;
  ball0.setFillColor(color(255, 0, 0));
  
  ball1 = new Ball();
  ball1.x = random(width);
  ball1.y = random(height);
  ball1.radius = 20;
  ball1.setFillColor(color(255, 0, 0));
  
  ball2 = new Ball();
  ball2.x = random(width);
  ball2.y = random(height);
  ball2.radius = 20;
  ball2.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
  
  if(!ball0Dragging) {
    springTo(ball0, ball1);
    springTo(ball0, ball2);
  }
      
  if(!ball1Dragging) {
    springTo(ball1, ball0);
    springTo(ball1, ball2);
  }

  if(!ball2Dragging) {
    springTo(ball2, ball0);
    springTo(ball2, ball1);
  }
  
  stroke(0);
  line(ball0.x, ball0.y, ball1.x, ball1.y);
  line(ball1.x, ball1.y, ball2.x, ball2.y);
  line(ball2.x, ball2.y, ball0.x, ball0.y);
  
  noStroke();
  ball0.update();
  ball1.update();
  ball2.update();
}

void springTo(Ball ballA, Ball ballB) {
  float dx = ballB.x - ballA.x;
  float dy = ballB.y - ballA.y;
  float angle = atan2(dy, dx);
  float targetX = ballB.x - cos(angle) * springLength;
  float targetY = ballB.y - sin(angle) * springLength;
  ballA.vx += (targetX - ballA.x) * spring;
  ballA.vy += (targetY - ballA.y) * spring;
  ballA.vx *= friction;
  ballA.vy *= friction;
  ballA.x += ballA.vx;
  ballA.y += ballA.vy;
}

void mousePressed() {   
  ball0.startDrag();
  ball1.startDrag();
  ball2.startDrag();
  if(ball0.isRollOver) {
    ball0Dragging = true;
  }
  if(ball1.isRollOver) {
    ball1Dragging = true;
  }
  if(ball2.isRollOver) {
    ball2Dragging = true;
  }
}

void mouseReleased() {
  ball0.stopDrag();
  ball1.stopDrag();
  ball2.stopDrag();
  ball0Dragging = false;
  ball1Dragging = false;
  ball2Dragging = false;    
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  
  Ball(){
    super();
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
