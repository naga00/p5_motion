Ball ball;
float spring = 0.1;
float vx, vy;
float friction = 0.95;
int springLength = 100;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball();
  ball.x = 0;
  ball.y = 0;
  ball.radius = 20;
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
  
  float dx = ball.x - mouseX;
  float dy = ball.y - mouseY;
  float angle = atan2(dy, dx);
  float targetX = mouseX + cos(angle) * springLength;
  float targetY = mouseY + sin(angle) * springLength;
  vx += (targetX - ball.x) * spring;
  vy += (targetY - ball.y) * spring;
  vx *= friction;
  vy *= friction;
  ball.x += vx;
  ball.y += vy;
  
  stroke(0, 0, 0);
  line(ball.x, ball.y, mouseX, mouseY);
  
  noStroke();
  ball.update();
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  
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
