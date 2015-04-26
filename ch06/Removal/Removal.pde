static final int COUNT = 20;
ArrayList balls;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
 
  balls = new ArrayList();
  for(int i=0; i<COUNT; i++){
    Ball ball = new Ball();
    ball.x = random(width);
    ball.y = random(height);
    ball.vx = random(2) - 1;
    ball.vy = random(2) - 1;
    ball.radius = 10;
    ball.setFillColor(color(255, 0, 0));
    balls.add(ball);
  }
}

void draw() {
  background(255);
  
  for(int i=0; i<balls.size(); i++) {
    Ball ball = (Ball) balls.get(i);
    ball.x += ball.vx;
    ball.y += ball.vy;
    if(ball.x - ball.radius > width || ball.x + ball.radius < 0 || ball.y - ball.radius > height || ball.y + ball.radius < 0) {
      ball.visible = false;
      balls.remove(i);
      if(balls.size() <= 0){
        noLoop();
      }
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
