Ball ball0;
Ball ball1;
float bounce = -1.0;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();

  ball0 = new Ball(150);
  ball0.mass = 2;
  ball0.x = width - 200;
  ball0.y = height - 200;
  ball0.vx = random(10) - 5;
  ball0.vy = random(10) - 5;
  ball0.setFillColor(color(255, 0, 0));
  
  ball1 = new Ball(90);
  ball1.mass = 1;
  ball1.x = 100;
  ball1.y = 100;
  ball1.vx = random(10) - 5;
  ball1.vy = random(10) - 5;
  ball1.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);

  ball0.x += ball0.vx;
  ball0.y += ball0.vy;
  ball1.x += ball1.vx;
  ball1.y += ball1.vy;
  checkCollision(ball0, ball1);
  checkWalls(ball0);
  checkWalls(ball1);
      
  ball0.update();
  ball1.update();  
}

void checkWalls(Ball ball) {
  if(ball.x + ball.radius > width){
    ball.x = width - ball.radius;
    ball.vx *= bounce;
  }else if(ball.x - ball.radius < 0){
    ball.x = ball.radius;
    ball.vx *= bounce;
  }
      
  if(ball.y + ball.radius > height){
    ball.y = height - ball.radius;
    ball.vy *= bounce;
  }else if(ball.y - ball.radius < 0){
    ball.y = ball.radius;
    ball.vy *= bounce;
  }
}

void checkCollision(Ball ball0, Ball ball1) {
  float dx = ball1.x - ball0.x;
  float dy = ball1.y - ball0.y;
  float dist = sqrt(dx*dx + dy*dy);
  
  if(dist < ball0.radius + ball1.radius) {
    float angle = atan2(dy, dx);
    float sine = sin(angle);
    float cosine = cos(angle);
        
    Point pos0 = new Point(0, 0);
    Point pos1 = rotate(dx, dy, sine, cosine, true);
    Point vel0 = rotate(ball0.vx, ball0.vy, sine, cosine, true);
    Point vel1 = rotate(ball1.vx, ball1.vy, sine, cosine, true);

    float vxTotal = vel0.x - vel1.x;
    vel0.x = ((ball0.mass - ball1.mass) * vel0.x + 2 * ball1.mass * vel1.x) / (ball0.mass + ball1.mass);
    vel1.x = vxTotal + vel0.x;

    float absV = abs(vel0.x) + abs(vel1.x);
    float overlap = (ball0.radius + ball1.radius)  - abs(pos0.x - pos1.x);
    pos0.x += vel0.x / absV * overlap;
    pos1.x += vel1.x / absV * overlap;
    
    Point pos0F = rotate(pos0.x, pos0.y, sine, cosine, false);
    Point pos1F = rotate(pos1.x, pos1.y, sine, cosine, false);
    
    ball1.x = ball0.x + pos1F.x;
    ball1.y = ball0.y + pos1F.y;
    ball0.x = ball0.x + pos0F.x;
    ball0.y = ball0.y + pos0F.y;

    Point vel0F = rotate(vel0.x, vel0.y, sine, cosine, false);
    Point vel1F = rotate(vel1.x, vel1.y, sine, cosine,false);
    ball0.vx = vel0F.x;
    ball0.vy = vel0F.y;
    ball1.vx = vel1F.x;
    ball1.vy = vel1F.y;
  }
}

Point rotate(float x, float y, float sine, float cosine, Boolean reverse) {
  Point result = new Point(0, 0);
  if(reverse){
    result.x = x * cosine + y * sine;
    result.y = y * cosine - x * sine;
  }else{
    result.x = x * cosine - y * sine;
    result.y = y * cosine + x * sine;
  }
  return result;  
}

////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  float mass = 1;
  
  Ball(float radius){
    super();
    this.radius = radius;
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

class Sprite extends Object {
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
    super();
    scaleX = 1.0;
    scaleY = 1.0;
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

////////////////////////////////

class Point extends Object {
  float x, y;
  
  Point(float x, float y) {
    super();
    this.x = x;
    this.y = y;
  }
}

////////////////////////////////

class Object {
  Object() {}
}


