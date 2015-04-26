Arrow arrow;
float speed = 5;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  arrow = new Arrow();
  arrow.x = width/2;
  arrow.y = height/2;
  arrow.setFillColor(color(255, 255, 0));
}

void draw() {
  background(255);

  float dx = mouseX - arrow.x;
  float dy = mouseY - arrow.y;
  float angle = atan2(dy, dx);
  arrow.rotation = angle * 180 / PI;
  float vx = cos(angle) * speed;
  float vy = sin(angle) * speed;
  arrow.x += vx;
  arrow.y += vy;
  arrow.update();
}

////////////////////////////////

class Arrow extends Sprite {
  Arrow() {
    super();
  }
  
  void draw() {
    beginShape();
    vertex(-50, -25);
    vertex(0, -25);
    vertex(0, -50);
    vertex(50, 0);
    vertex(0, 50);
    vertex(0, 25);
    vertex(-50, 25);
    vertex(-50, -25);
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
