Box box;
ArrayList boxes;
float gravity = 0.2;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  rectMode(CORNER);
  boxes = new ArrayList();
  createBox();
}

void draw() {
  background(255);

  box.vy += gravity;
  box.y += box.vy;
      
  if(box.y + box.height / 2 > height){
    box.y = height - box.height / 2;
    createBox();
   }
  
  for(int i=0; i<boxes.size(); i++){
    Box targetBox = (Box)boxes.get(i);
  
    if(box != targetBox && box.hitTestObject(targetBox)){
      println("Hit");
      box.y = 100;
      //box.y = targetBox.y - targetBox.height / 2 - box.height / 2;
      //createBox();
    }
  }
  
  for(int i=0; i<boxes.size(); i++){
    Box box = (Box)boxes.get(i);
    box.update();
  }
}

void createBox() {
  box = new Box();
  box.width = random(40) + 10;
  box.height = random(40) + 10;
  box.setFillColor(color(255, 0, 0));
  //box.x = random(width);
  box.x = 100;
  boxes.add(box);
}

////////////////////////////////

class Box extends Sprite {
  float vx, vy;
  
  Box() {
    super();
  }
  
  Boolean hitTestObject(Box box) {
    //Point topLeft = new Point(box.x, box.y);
    //Point topRight = new Point(box.x + box.width, box.y);
    //Point bottomLeft = new Point(box.x, box.y + box.height);
    //Point bottomRight = new Point(box.x + box.width, box.y + box.height);

    if(box.x >= this.x + this.width && box.y >= this.y + this.height && box.x + box.width <= this.x + this.width && box.y + box.height <= this.y + this.height) {
      return true;
    }

    if(box.x >= this.x && box.y >= this.y + this.height && box.x + box.width <= this.x && box.y + box.height <= this.y + this.height) {
      return true;
    }

    if(box.x >= this.x + this.width && box.y >= this.y && box.x + box.width <= this.x + this.width && box.y + box.height <= this.y) {
      return true;
    }

    if(box.x >= this.x && box.y >= this.y && box.x + box.width <= this.x && box.y + box.height <= this.y) {
      return true;
    }


    
    return false;
  }
  
  void draw() {
    rect(0, 0, width, height);
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

////////////////////////////////

class Point {
  float x, y;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

