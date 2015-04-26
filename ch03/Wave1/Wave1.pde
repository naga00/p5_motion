Ball ball;
float centerY;
float angle = 0;
float range = 50;
float xspeed = 1;
float yspeed = 0.05;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball();
  centerY = height/2;
  ball.x = 0;
  ball.y = centerY;
  ball.radius = 50;
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);

  ball.x += xspeed;
  ball.y = centerY + sin(angle) * range;
  angle += yspeed;      
  ball.update();
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  
  Ball() {
    super();
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
