Ball[] particles;
static final int numParticles = 30;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  
  particles = new Ball[numParticles];
  for(int i=0; i<numParticles; i++) {
    particles[i] = new Ball(5);
    particles[i].x = random(width);
    particles[i].y = random(height);
    particles[i].mass = 1;
    particles[i].setFillColor(color(255, 0, 0));
  }
}

void draw() {
  background(255);

  for(int i=0; i<numParticles; i++){
    Ball particle = particles[i];       
    particle.x += particle.vx;
    particle.y += particle.vy;
    particle.update();
  }
      
  for(int i=0; i<numParticles; i++){
    Ball partA = particles[i];
    for(int j=i+1; j<numParticles; j++){
      Ball partB = particles[j];
      checkCollision(partA, partB);
      gravitate(partA, partB);
    }
  }
}

void gravitate(Ball partA, Ball partB) {
  float dx = partB.x - partA.x;
  float dy = partB.y - partA.y;
  float distSQ = dx*dx + dy*dy;
  float dist = sqrt(distSQ);
  float force = partA.mass * partB.mass / distSQ;
  float ax = force * dx / dist;
  float ay = force * dy / dist;
  partA.vx += ax;
  partA.vy += ay;
  partB.vx -= ax;
  partB.vy -= ay;
}

void checkCollision(Ball ball0, Ball ball1) {
  float dx = ball1.x - ball0.x;
  float dy = ball1.y - ball0.y;
  float dist = sqrt(dx*dx + dy*dy);
  
  if(dist < ball0.radius + ball1.radius){
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


