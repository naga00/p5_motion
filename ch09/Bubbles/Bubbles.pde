Ball[] balls;
static final int numBalls = 10;
Ball centerBall;
float bounce = -1.0;
float spring = 0.2;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  centerBall = new Ball(100);
  centerBall.x = width/2;
  centerBall.y = height/2;
  centerBall.setFillColor(color(200, 200, 200));
  
  balls = new Ball[numBalls];
  for(int i=0; i<numBalls; i++) {
    float radius = random(40) + 5;
    balls[i] = new Ball(radius);
    balls[i].x = random(width);
    balls[i].y = random(height);
    balls[i].vx = random(6) - 3;
    balls[i].vy = random(6) - 3;
    balls[i].setFillColor(color(random(255), random(255), random(255)));
  }
}

void draw() {
  background(255);

  for(int i=0; i<numBalls; i++){
    Ball ball = balls[i];
    move(ball);
    float dx = ball.x - centerBall.x;
    float dy = ball.y - centerBall.y;
    float dist = sqrt(dx * dx + dy * dy);
    float minDist = ball.radius + centerBall.radius;
    if(dist < minDist) {
      float angle = atan2(dy, dx);
      float tx = centerBall.x + cos(angle) * minDist;
      float ty = centerBall.y + sin(angle) * minDist;
      ball.vx += (tx - ball.x) * spring;
      ball.vy += (ty - ball.y) * spring;
    }
        
    ball.update();
  }
  centerBall.update();
}

void move(Ball ball) {
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


