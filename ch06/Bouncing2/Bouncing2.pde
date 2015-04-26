Ball ball;
float vx = 0;
float vy = 0;
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
  vx = random(10) - 5;
  vy = -10;
  ball.radius = 40;
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
    vx *= -1;
  }else if(ball.x - ball.radius < left){
    ball.x = left + ball.radius;
    vx *= -1;
  }
      
  if(ball.y + ball.radius > bottom){
    ball.y = bottom - ball.radius;
    vy *= -1;
  }else if(ball.y - ball.radius < top){
    ball.y = top + ball.radius;
    vy *= -1;
  }
  
  ball.update();
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  
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
