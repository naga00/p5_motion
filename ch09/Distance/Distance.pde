Ball ball1;
Ball ball2;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  ball1 = new Ball(40);
  ball1.x = width/2;
  ball1.y = height/2;
  ball1.setFillColor(color(255, 0, 0));

  ball2 = new Ball(40);
  ball2.x = 0;
  ball2.y = 0;
  ball2.setFillColor(color(255, 0, 0));
}

void draw() {
  background(255);
  ball2.x = mouseX;
  ball2.y = mouseY;
  
  float dx = ball2.x - ball1.x;
  float dy = ball2.y - ball1.y;
  float dist = sqrt(dx * dx + dy * dy);
  if(dist < 80) {
    println("hit");
  }
      
  ball1.update();
  ball2.update();
}
////////////////////////////////

class Ball extends Sprite {
  float radius;
  float vx, vy;
  
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
  Boolean isRollOver;
  Boolean locked;
  float xoff, yoff;
 
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
