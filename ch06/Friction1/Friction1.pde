Ball ball;
float vx = 0;
float vy = 0;
float friction = 0.1;

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
  vy = random(10) - 5;
  ball.radius = 40;
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
  
  float speed = sqrt(vx * vx + vy * vy);
  float angle = atan2(vy, vx);
  if (speed > friction){
    speed -= friction;
  }else{
    speed = 0;
  }
  vx = cos(angle) * speed;
  vy = sin(angle) * speed;
  ball.x += vx;
  ball.y += vy;  
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
