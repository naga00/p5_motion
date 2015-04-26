static final int numDots = 20;
float friction = 0.95;
Ball[] dots;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  background(255);
  dots = new Ball[numDots];
  for(int i=0; i<numDots; i++) {
    dots[i] = new Ball(0.5);
    dots[i].x = random(width);
    dots[i].y = random(height);
    dots[i].vx = 0;
    dots[i].vy = 0;
    dots[i].setFillColor(color(0));
  }
}

void draw() {
  for(int i=0; i<numDots; i++) {
    Ball dot = dots[i];
    
    stroke(color(0, 0, 0, 50));
    strokeWeight(1);    
    beginShape();
    
    vertex(dot.x, dot.y);
    dot.vx += random(0.2) - 0.1;
    dot.vy += random(0.2) - 0.1;
    dot.x += dot.vx;
    dot.y += dot.vy;
    dot.vx *= friction;
    dot.vy *= friction;
    vertex(dot.x, dot.y);
    endShape(CLOSE);
        
    if(dot.x > width) {
      dot.x = 0;
    }else if(dot.x < 0) {
      dot.x = width;
    }
    if(dot.y > height) {
      dot.y = 0;
    }else if(dot.y < 0) {
      dot.y = height;
    }
    noStroke();
    dot.update();
  }
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
