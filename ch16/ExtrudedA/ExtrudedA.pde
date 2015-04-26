Point3D points[];
Triangle[] triangles;
float fl = 250;
float vpX = 0;
float vpY = 0;

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
  
  points = new Point3D[22];
  points[0] = new Point3D( -50, -250,  -50);
  points[1] = new Point3D(  50, -250,  -50);
  points[2] = new Point3D( 200,  250,  -50);
  points[3] = new Point3D( 100,  250,  -50);
  points[4] = new Point3D(  50,  100,  -50);
  points[5] = new Point3D( -50,  100,  -50);
  points[6] = new Point3D(-100,  250,  -50);
  points[7] = new Point3D(-200,  250,  -50);
  points[8] = new Point3D(   0, -150,  -50);
  points[9] = new Point3D(  50,    0,  -50);
  points[10] = new Point3D( -50,   0,  -50);
  
  points[11] = new Point3D( -50, -250,  50);
  points[12] = new Point3D(  50, -250,  50);
  points[13] = new Point3D( 200,  250,  50);
  points[14] = new Point3D( 100,  250,  50);
  points[15] = new Point3D(  50,  100,  50);
  points[16] = new Point3D( -50,  100,  50);
  points[17] = new Point3D(-100,  250,  50);
  points[18] = new Point3D(-200,  250,  50);
  points[19] = new Point3D(   0, -150,  50);
  points[20] = new Point3D(  50,    0,  50);
  points[21] = new Point3D( -50,    0,  50);
  
  for(int i=0; i<points.length; i++) {
    points[i].setVanishingPoint(vpX, vpY);
    points[i].setCenter(0, 0, 200);
  }
  
  triangles = new Triangle[44];
  triangles[0] =new Triangle(points[0],   points[1],  points[8],  color(102, 102, 204, 127));
  triangles[1] =new Triangle(points[1],   points[9],  points[8],  color(102, 102, 204, 127));
  triangles[2] =new Triangle(points[1],   points[2],  points[9],  color(102, 102, 204, 127));
  triangles[3] =new Triangle(points[2],   points[4],  points[9],  color(102, 102, 204, 127));
  triangles[4] =new Triangle(points[2],   points[3],  points[4],  color(102, 102, 204, 127));
  triangles[5] =new Triangle(points[4],   points[5],  points[9],  color(102, 102, 204, 127));
  triangles[6] =new Triangle(points[9],   points[5],  points[10], color(102, 102, 204, 127));
  triangles[7] =new Triangle(points[5],   points[6],  points[7],  color(102, 102, 204, 127));
  triangles[8] =new Triangle(points[5],   points[7],  points[10], color(102, 102, 204, 127));
  triangles[9] =new Triangle(points[0],   points[10], points[7],  color(102, 102, 204, 127));
  triangles[10] = new Triangle(points[0], points[8],  points[10], color(102, 102, 204, 127));
  
  triangles[11] = new Triangle(points[11], points[19], points[12], color(204, 102, 102, 127));
  triangles[12] = new Triangle(points[12], points[19], points[20], color(204, 102, 102, 127));
  triangles[13] = new Triangle(points[12], points[20], points[13], color(204, 102, 102, 127));
  triangles[14] = new Triangle(points[13], points[20], points[15], color(204, 102, 102, 127));
  triangles[15] = new Triangle(points[13], points[15], points[14], color(204, 102, 102, 127));
  triangles[16] = new Triangle(points[15], points[20], points[16], color(204, 102, 102, 127));
  triangles[17] = new Triangle(points[20], points[21], points[16], color(204, 102, 102, 127));
  triangles[18] = new Triangle(points[16], points[18], points[17], color(204, 102, 102, 127));
  triangles[19] = new Triangle(points[16], points[21], points[18], color(204, 102, 102, 127));
  triangles[20] = new Triangle(points[11], points[18], points[21], color(204, 102, 102, 127));
  triangles[21] = new Triangle(points[11], points[21], points[19], color(204, 102, 102, 127));
  
  triangles[22] = new Triangle(points[0],  points[11], points[1],  color(204, 204, 102, 127));
  triangles[23] = new Triangle(points[11], points[12], points[1],  color(204, 204, 102, 127));
  triangles[24] = new Triangle(points[1],  points[12], points[2],  color(204, 204, 102, 127));
  triangles[25] = new Triangle(points[12], points[13], points[2],  color(204, 204, 102, 127));
  triangles[26] = new Triangle(points[3],  points[2],  points[14], color(204, 204, 102, 127));
  triangles[27] = new Triangle(points[2],  points[13], points[14], color(204, 204, 102, 127));
  triangles[28] = new Triangle(points[4],  points[3],  points[15], color(204, 204, 102, 127));
  triangles[29] = new Triangle(points[3],  points[14], points[15], color(204, 204, 102, 127));
  triangles[30] = new Triangle(points[5],  points[4],  points[16], color(204, 204, 102, 127));
  triangles[31] = new Triangle(points[4],  points[15], points[16], color(204, 204, 102, 127));
  triangles[32] = new Triangle(points[6],  points[5],  points[17], color(204, 204, 102, 127));
  triangles[33] = new Triangle(points[5],  points[16], points[17], color(204, 204, 102, 127));
  triangles[34] = new Triangle(points[7],  points[6],  points[18], color(204, 204, 102, 127));
  triangles[35] = new Triangle(points[6],  points[17], points[18], color(204, 204, 102, 127));
  triangles[36] = new Triangle(points[0],  points[7],  points[11], color(204, 204, 102, 127));
  triangles[37] = new Triangle(points[7],  points[18], points[11], color(204, 204, 102, 127));
  
  triangles[38] = new Triangle(points[8],  points[9],  points[19], color(204, 204, 102, 127));
  triangles[39] = new Triangle(points[9],  points[20], points[19], color(204, 204, 102, 127));
  triangles[40] = new Triangle(points[9],  points[10], points[20], color(204, 204, 102, 127));
  triangles[41] = new Triangle(points[10], points[21], points[20], color(204, 204, 102, 127));
  triangles[42] = new Triangle(points[10], points[8],  points[21], color(204, 204, 102, 127));
  triangles[43] = new Triangle(points[8],  points[19], points[21], color(204, 204, 102, 127));     
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


