ArrayList particles;
static final int numParticles = 2;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  
  particles = new ArrayList();

  Ball sun = new Ball(100);
  sun.x = width/2;
  sun.y = height/2;
  sun.vx = 0;
  sun.vy = 0;
  sun.mass = 10000;
  sun.setFillColor(color(255, 255, 0));
  particles.add(sun);
  
  Ball planet = new Ball(10);
  planet.x = width/2 + 200;
  planet.y = height/2;
  planet.vy = 7;
  planet.mass = 1;
  planet.setFillColor(color(0, 255, 0));
  particles.add(planet);
}

void draw() {
  //background(255);
   
  noStroke();
  for(int i=0; i<numParticles; i++){
    Ball particle = (Ball)particles.get(i);
    particle.x += particle.vx;
    particle.y += particle.vy;
    particle.update();
  }
      
  for(int i=0; i<numParticles - 1; i++){
    Ball partA = (Ball)particles.get(i);
    for(int j=i+1; j<numParticles; j++){
      Ball partB = (Ball)particles.get(j);
      gravitate(partA, partB);
    }
  }
  
  stroke(0);
  strokeWeight(1);
  beginShape();
  Ball partA = (Ball)particles.get(1);
  Ball partB = (Ball)particles.get(1);
  vertex(partA.x, partB.y);
  endShape(CLOSE);

beginShape();
vertex(30, 20);
vertex(85, 20);
vertex(85, 75);
vertex(30, 75);
endShape(CLOSE);

}

void gravitate(Ball partA, Ball partB) {
  float dx = partB.x - partA.x;
  float dy = partB.y - partA.y;
  float distSQ = dx*dx + dy*dy;
  float dist = sqrt(distSQ);
  float force = partA.mass * partB.mass / distSQ;
  float ax = force * dx / dist;
  float ay = force * dy / dist;
  partA.vx += ax / partA.mass;
  partA.vy += ay / partA.mass;
  partB.vx -= ax / partB.mass;
  partB.vy -= ay / partB.mass;
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


