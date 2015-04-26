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


