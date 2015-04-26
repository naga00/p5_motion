Ball ball0;
Ball ball1;
Ball ball2;
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
  color col = color(255, 0, 0);
  ball0 = new Ball();
  ball0.radius = 20;
  ball0.setFillColor(col);
  ball1 = new Ball();
  ball1.radius = 20;
  ball1.setFillColor(col);
  ball2 = new Ball();
  ball2.radius = 20;
  ball2.setFillColor(col);
}

void draw() {
  background(255);
  
  moveBall(ball0, mouseX, mouseY);
  moveBall(ball1, ball0.x, ball0.y);
  moveBall(ball2, ball1.x, ball1.y);
  
  stroke(0, 0, 0);
  line(mouseX, mouseY, ball0.x, ball0.y);
  line(ball0.x, ball0.y, ball1.x, ball1.y);
  line(ball1.x, ball1.y, ball2.x, ball2.y);
  
  noStroke();
  ball0.update();
  ball1.update();
  ball2.update();
}

void moveBall(Ball ball, float targetX, float targetY) {
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
