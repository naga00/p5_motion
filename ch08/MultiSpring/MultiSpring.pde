Ball ball;
Ball[] handles;
float spring = 0.1;
float friction = 0.8;
int numHandles = 3;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball();
  ball.radius = 20;
  ball.setFillColor(color(255, 0, 0));
  handles = new Ball[numHandles];
  for(int i=0; i<numHandles; i++) {
    handles[i] = new Ball();
    handles[i].radius = 10;
    handles[i].setFillColor(color(0, 0, 255));
    handles[i].x = random(width);
    handles[i].y = random(height);
  }
}

void draw() {
  background(255);

  for(int i = 0; i < numHandles; i++){
    Ball handle = handles[i];
    float dx = handle.x - ball.x;
    float dy = handle.y - ball.y;
    ball.vx += dx * spring;
    ball.vy += dy * spring; 
  }
  ball.vx *= friction;
  ball.vy *= friction;
  ball.x += ball.vx;
  ball.y += ball.vy;

  stroke(0);
  for(int i=0; i<numHandles; i++) {
    line(ball.x, ball.y, handles[i].x, handles[i].y);
  }
  
  noStroke();  
  for(int i = 0; i < numHandles; i++){
    Ball handle = handles[i];
    handle.update();  
  }
  ball.update();
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
