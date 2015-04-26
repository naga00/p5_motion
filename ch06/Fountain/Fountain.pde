static final int COUNT = 100;
Ball[] balls;
float gravity = 0.5;


void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
 
  balls = new Ball[COUNT];
  for(int i=0; i<COUNT; i++) {
    balls[i] = new Ball();
    balls[i].x = width/2;
    balls[i].y = height;
    balls[i].vx = random(2) - 1;
    balls[i].vy = random(-10) - 10;
    balls[i].setFillColor(color(random(255), random(255), random(255)));
    balls[i].radius = 2;
  }
}

void draw() {
  background(255);
  
  for(int i=0; i<balls.length; i++) {
    Ball ball = balls[i];
    ball.vy += gravity;
    ball.x += ball.vx;
    ball.y += ball.vy;
    if(ball.x - ball.radius > width || ball.x + ball.radius < 0 || ball.y - ball.radius > height || ball.y + ball.radius < 0) {
      ball.x = width / 2;
      ball.y = height;
      ball.vx = random(2) - 1;
      ball.vy = random(-10) - 10;
    }
    ball.update(); 
  }
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  
  Ball(){
    super();
  }
  
  void draw(){
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
