Ball ball;
float vx, vy;
float bounce = -0.7;
float gravity = 0.5;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball();
  ball.x = width/2;
  ball.y = height/2;
  ball.radius = 40;
  vx = random(10) - 5;
  vy = -10;    
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
      
  vy += gravity;
  ball.x += vx;
  ball.y += vy;
  int left = 0;
  int right = width;
  int top = 0;
  int bottom = height;

  if(ball.x + ball.radius > right){
    ball.x = right - ball.radius;
    vx *= bounce;
  }else if(ball.x - ball.radius < left){
    ball.x = left + ball.radius;
    vx *= bounce;
  }
  
  if(ball.y + ball.radius > bottom){
    ball.y = bottom - ball.radius;
    vy *= bounce;
  }else if(ball.y - ball.radius < top){
    ball.y = top + ball.radius;
    vy *= bounce;
  }
  
  ball.update();
}

void mousePressed() {
  vx = 0;
  vy = 0;    
  ball.startDrag();
}

void mouseReleased() {
  ball.stopDrag();
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
