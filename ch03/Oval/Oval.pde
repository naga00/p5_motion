Ball ball;
float centerX, centerY;
float angle = 0;
float radiusX = 200;
float radiusY = 100;
float speed = 0.1;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball = new Ball();
  centerX = width/2;
  centerY = height/2;
  ball.x = centerX;
  ball.y = centerY;
  ball.radius = 5;
  ball.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);

  ball.x = centerX + sin(angle) * radiusX;
  ball.y = centerY + cos(angle) * radiusY;
  ball.update();
  angle += speed; 
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
