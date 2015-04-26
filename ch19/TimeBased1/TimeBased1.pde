Ball ball;
float vx;
float vy;
float bounce = -0.7;
float time;
float gravity = 450;

void setup() {
  size(960, 540);
  frameRate(100);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball(50);
  ball.x = width/2;
  ball.y = height/2;
  vx = 300;
  vy = -300;
  ball.setFillColor(color(255, 0, 0));
  
  time = millis();
}

void draw() {
  background(255);

  float elapsed = millis() - time;
  time = millis();
  vy += gravity * elapsed / 1000;
  ball.x += vx * elapsed / 1000;
  ball.y += vy * elapsed / 1000;
  float left = 0;
  float right = width;
  float top = 0;
  float bottom = height;
  
  if(ball.x + ball.radius > right) {
    ball.x = right - ball.radius;
    vx *= bounce;
  }else if(ball.x - ball.radius < left) {
    ball.x = left + ball.radius;
    vx *= bounce;
  }
  if(ball.y + ball.radius > bottom) {
    ball.y = bottom - ball.radius;
    vy *= bounce;
  }else if(ball.y - ball.radius < top){
    ball.y = top + ball.radius;
    vy *= bounce;
  }
  
  ball.update();
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  
  Ball(float radius) {
    super();
    this.radius = radius;
  }
  
  void draw() {
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
    visible = true;
  }
  
  void update() {
    if(! visible) return;
    pushMatrix();
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
  
  void draw() {}
}
