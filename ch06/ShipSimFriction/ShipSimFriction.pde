Ship ship;
float vr = 0;
float thrust = 0;
float vx = 0;
float vy = 0;
float friction = 0.97;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  ship = new Ship();
  ship.x = width/2;
  ship.y = height/2;
  ship.setStrokeColor(color(255, 0, 0));
  ship.setFillColor(color(255, 255, 255));
}

void keyPressed() {
  switch(keyCode) {
    case LEFT: 
      vr = -5;
      break;
    case RIGHT: 
      vr = 5;
      break;
    case UP:
      thrust = 0.2;
      ship.gun(true);
      break;
    default:
      break;
  }
}

void keyReleased() {
  vr = 0;
  thrust = 0;
  ship.gun(false);  
}

void draw() {
  background(255);
  
  fill(255, 255, 255);
  stroke(255, 0, 0);
  
  ship.rotation += vr;
  float angle = ship.rotation * PI / 180;
  float ax = cos(angle) * thrust;
  float ay = sin(angle) * thrust;
  vx += ax;
  vy += ay;
  vx *= friction;
  vy *= friction;    
  ship.x += vx;
  ship.y += vy;
  float left = 0;
  float right = width;
  float top = 0;
  float bottom = height;

  if(ship.x - ship.width / 2 > right){
    ship.x = left - ship.width / 2;
  }else if (ship.x + ship.width / 2 < left){
    ship.x = right + ship.width / 2;
  }
      
  if(ship.y - ship.height / 2 > bottom){
    ship.y = top - ship.height / 2;
  }else if (ship.y < top - ship.height / 2){
    ship.y = bottom + ship.height / 2;
  }  
 
  ship.update();
}

////////////////////////////////

class Ship extends Sprite {
  boolean isGun;
  
  Ship() {
    super();
    isGun = false;  
  }
  
  void gun(boolean isGun) {
    this.isGun = isGun;
  }
  
  void draw() {
    if(isGun) {
      beginShape();
      vertex(-7.5, -5);
      vertex(-15, 0);
      vertex(-7.5, 5);
      endShape(CLOSE);
    }      
    beginShape();
    vertex(10, 0);
    vertex(-10, 10);
    vertex(-5, 0);
    vertex(-10, -10);
    vertex(10, 0);
    endShape(CLOSE);
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
