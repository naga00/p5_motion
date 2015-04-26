Tree[] trees;
static final int numTrees = 100;
float fl = 250;
float vpX = 0;
float vpY = 0;
float floor = 50;
float vz = 0;
float friction = 0.98;

void setup() {
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  vpX = width/2;
  vpY = height/2;
  trees = new Tree[numTrees];
  for(int i=0; i<numTrees; i++) {
    trees[i] = new Tree();
    trees[i].xpos = random(2000) - 1000;
    trees[i].ypos = floor;
    trees[i].zpos = random(10000);
    trees[i].setFillColor(color(255, 0, 0));   
  }
}

void draw() {
  background(0);
  for(int i=0; i<numTrees; i++) {
    Tree tree = trees[i];
    move(tree);
  }
  vz *= friction;
  sortZ();
}

void move(Tree tree) {
  tree.zpos += vz;
  if(tree.zpos < -fl) {
    tree.zpos += 10000;
  }
  if(tree.zpos > 10000 - fl) {
    tree.zpos -= 10000;
  }
  float scale = fl / (fl + tree.zpos);
  tree.scaleX = tree.scaleY = scale;
  tree.x = vpX + tree.xpos * scale;
  tree.y = vpY + tree.ypos * scale;
  tree.setStrokeColor(color(255, 255, 255));
  tree.setStrokeColor(color(255, 255, 255, 200 + 55*scale));
}

void sortZ() {
  for(int i=0; i<numTrees - 1; i++) {
    for(int j=numTrees-1; j>i; j--) {
      if(trees[j].zpos > trees[j-1].zpos) {
        Tree t = trees[j];
        trees[j] = trees[j-1];
        trees[j-1] = t;
      }
    }
  }

  for(int i=0; i<numTrees; i++) {
     Tree tree = trees[i];
     tree.update();
  }
}

void keyPressed() {
  switch(keyCode) {
    case UP:
      vz -= 1;
      break;
    case DOWN:
      vz += 1;
      break;
    default:
      break;
  }
}

////////////////////////////////

class Segment extends Sprite {
  float segmentWidth, segmentHeight;
  float vx, vy;
  
  Segment(float segmentWidth, float segmentHeight) {
    super();
    this.segmentWidth = segmentWidth;
    this.segmentHeight = segmentHeight;
  }
  
  void draw() {
    rect(-segmentHeight / 2,  -segmentHeight / 2, segmentWidth + segmentHeight, segmentHeight, segmentHeight, segmentHeight, segmentHeight, segmentHeight);
    ellipse(0, 0, 2, 2);
    ellipse(segmentWidth, 0, 2, 2);
  }
  
  Point getPin() {
    float angle = rotation * PI / 180;
    float xPos = x + cos(angle) * segmentWidth;
    float yPos = y + sin(angle) * segmentWidth;
    return new Point(xPos, yPos);  
  }
}

////////////////////////////////

class Tree extends Sprite {
  float xpos = 0;
  float ypos = 0;
  float zpos = 0;
  float x0, y0, x1, y1, x2, y2, x3, y3, x4, y4;
  
  Tree(){
    super();
    x0 = 0;
    y0 = -140 - random(20);
    x1 = 0;
    y1 = -30 - random(30);
    x2 = random(80) - 40;
    y2 = -100 - random(40);
    x3 = 0;
    y3 = -60 - random(40);
    x4 = random(60) - 30;
    y4 = -110 - random(20);
  }
  
  void draw(){
    line(0, 0, x0, y0);
    line(x1, y1, x2, y2);
    line(x3, y3, x4, y4);
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


