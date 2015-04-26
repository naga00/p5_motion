Ball[] balls;
int numBalls = 10;
float vr = 0.05;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  balls = new Ball[numBalls];
  
  for(int i=0; i<numBalls; i++){
    balls[i] = new Ball();
    balls[i].x = random(width);
    balls[i].y = random(height);
    balls[i].radius = 40;
    balls[i].setFillColor(color(255, 0, 0));
  }
}

void draw() {
  background(255);

  float angle = (mouseX - width / 2) * 0.001;
  float cosine = cos(angle);
  float sine = sin(angle);
      
  for(int i=0; i<numBalls; i++){
    Ball ball = balls[i];
    float x1 = ball.x - width / 2;
    float y1 = ball.y - height / 2;
    float x2 = cosine * x1 - sine * y1;
    float y2 = cosine * y1 + sine * x1;
    ball.x = width / 2 + x2;
    ball.y = height / 2 + y2;
    ball.update();
  }
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
