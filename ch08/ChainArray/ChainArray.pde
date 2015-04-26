Ball[] balls;
int numBalls = 5;
float spring = 0.1;
float friction = 0.8;
float gravity = 5;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  balls = new Ball[numBalls];
  for(int i = 0; i < numBalls; i++) {
    balls[i] = new Ball();
    balls[i].radius = 20;
    balls[i].setFillColor(color(255, 0, 0));
  }
  balls[0].x = width/2;
  balls[0].y = height/2;
}

void draw() {
  background(255);

  stroke(0, 0, 0);
  line(mouseX, mouseY, balls[0].x, balls[0].y);
  for(int i=1; i<numBalls; i++) {
    Ball ballA = balls[i-1];
    Ball ballB = balls[i];
    line(ballA.x, ballA.y, ballB.x, ballB.y);
  }
  
  noStroke();
  moveBall(balls[0], mouseX, mouseY); 
  for(int i=1; i<numBalls; i++) {
    Ball ballA = balls[i-1];
    Ball ballB = balls[i]; 
    moveBall(ballB, ballA.x, ballA.y);
  }
}

void moveBall(Ball ball, float targetX, float targetY) {
  ball.update();
  ball.vx += (targetX - ball.x) * spring;
  ball.vy += (targetY - ball.y) * spring;
  ball.vy += gravity;
  ball.vx *= friction;
  ball.vy *= friction;
  ball.x += ball.vx;
  ball.y += ball.vy;
  
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
