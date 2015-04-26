Point3D points[];
Triangle[] triangles;
float fl = 250;
float vpX = 0;
float vpY = 0;
float offsetX = 0;
float offsetY = 0;

void setup() {
  size(960, 700);
  frameRate(30);
  initialize();
}

void initialize() {
  smooth();
  noStroke();
  vpX = width/2;
  vpY = height/2;
  
  points = new Point3D[8];
  points[0] = new Point3D(-100, -100, -100);
  points[1] = new Point3D( 100, -100, -100);
  points[2] = new Point3D( 100,  100, -100);
  points[3] = new Point3D(-100,  100, -100);
  points[4] = new Point3D(-100, -100,  100);
  points[5] = new Point3D( 100, -100,  100);
  points[6] = new Point3D( 100,  100,  100);
  points[7] = new Point3D(-100,  100,  100);
  for(int i=0; i<points.length; i++) {
    points[i].setVanishingPoint(vpX, vpY);
    points[i].setCenter(0, 0, 200);
  }
  
  triangles = new Triangle[12];
  triangles[0] = new Triangle(points[0], points[1], points[2], #6666cc);
  triangles[1] = new Triangle(points[0], points[2], points[3], #6666cc);
  triangles[2] = new Triangle(points[0], points[5], points[1], #66cc66);
  triangles[3] = new Triangle(points[0], points[4], points[5], #66cc66);
  triangles[4] = new Triangle(points[4], points[6], points[5], #cc6666);
  triangles[5] = new Triangle(points[4], points[7], points[6], #cc6666);
  triangles[6] = new Triangle(points[3], points[2], points[6], #cc66cc);
  triangles[7] = new Triangle(points[3], points[6], points[7], #cc66cc);
  triangles[8] = new Triangle(points[1], points[5], points[6], #66cccc);
  triangles[9] = new Triangle(points[1], points[6], points[2], #66cccc);
  triangles[10] = new Triangle(points[4], points[0], points[3], #cccc66);
  triangles[11] = new Triangle(points[4], points[3], points[7], #cccc66);      
}

void draw() {
  background(255);
  
  float angleX = (mouseY - vpY) * 0.001;
  float angleY = (mouseX - vpX) * 0.001;
  for(int i=0; i<points.length; i++) {
    Point3D point = points[i];
    point.rotateX(angleX);
    point.rotateY(angleY);
  }
  for(int i=0; i<triangles.length; i++) {
    triangles[i].update();
  }
}

void keyPressed() {
  switch(keyCode) {
    case UP:
      offsetY -= 5;
      break;
    case DOWN:
      offsetY += 5;
      break;
    case LEFT:
      offsetX -= 5;
      break;
    case RIGHT:
      offsetX += 5;
      break;
    default:
      break;
  }
  for(int i= 0; i < points.length; i++) {
    points[i].x += offsetX;
    points[i].y += offsetY;
  }
}

////////////////////////////////

class Triangle extends Sprite {
  Point3D pointA;
  Point3D pointB;
  Point3D pointC;
  color cl;
  
  Triangle(Point3D a, Point3D b, Point3D c, color cl){
    super();
    pointA = a;
    pointB = b;
    pointC = c;
    this.cl = cl;
  }
  
  void draw(){
    fill(cl);
    beginShape(TRIANGLE_STRIP);
    vertex(pointA.screenX(), pointA.screenY());
    vertex(pointB.screenX(), pointB.screenY());
    vertex(pointC.screenX(), pointC.screenY());
    vertex(pointA.screenX(), pointA.screenY());
    endShape();
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

class Point3D extends Object {
  float fl = 250;
  float vpX = 0;
  float vpY = 0;
  float cX = 0;
  float cY = 0;
  float cZ = 0;
  float x = 0;
  float y = 0;
  float z = 0;
  
  Point3D(float x, float y, float z) {
    super();
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void setVanishingPoint(float vpX, float vpY) {
    this.vpX = vpX;
    this.vpY = vpY;
  }
  
  void setCenter(float cX, float cY, float cZ) {
    this.cX = cX;
    this.cY = cY;
    this.cZ = cZ;    
  }
  
  float screenX() {
    float scale = fl / (fl + z + cZ);
    return vpX + (cX + x) * scale;  
  }
  
  float screenY() {
    float scale = fl / (fl + z + cZ);
    return vpY + (cY + y) * scale;
  }
  
  void rotateX(float angleX) {
    float cosX = cos(angleX);
    float sinX = sin(angleX);
    float y1 = y * cosX - z * sinX;
    float z1 = z * cosX + y * sinX;
    y = y1;
    z = z1;
  }
  
  void rotateY(float angleY) {
    float cosY = cos(angleY);
    float sinY = sin(angleY);
    float x1 = x * cosY - z * sinY;
    float z1 = z * cosY + x * sinY;
    x = x1;
    z = z1;
  }
  
  void rotateZ(float angleZ) {
    float cosZ = cos(angleZ);
    float sinZ = sin(angleZ);
    float x1 = x * cosZ - y * sinZ;
    float y1 = y * cosZ + x * sinZ;
    x = x1;
    y = y1;
  }
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


