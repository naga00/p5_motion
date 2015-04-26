Point3D points[];
static final int numPoints = 12;
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
  
  points = new Point3D[numPoints];
  points[0] =  new Point3D(-150, -250, 100);
  points[1] =  new Point3D( 150, -250, 100);
  points[2] =  new Point3D( 150, -150, 100);
  points[3] =  new Point3D( -50, -150, 100);
  points[4] =  new Point3D( -50,  -50, 100);
  points[5] =  new Point3D(  50,  -50, 100);
  points[6] =  new Point3D(  50,   50, 100);
  points[7] =  new Point3D( -50,   50, 100);
  points[8] =  new Point3D( -50,  150, 100);
  points[9] =  new Point3D( 150,  150, 100);
  points[10] = new Point3D( 150,  250, 100);
  points[11] = new Point3D(-150,  250, 100);
  for(int i=0; i<numPoints; i++) {
    points[i].setVanishingPoint(vpX, vpY);
    points[i].setCenter(0, 0, 200);
  }
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
  stroke(0);
  for(int i = 1; i < numPoints; i++) {
    line(points[i-1].screenX(), points[i-1].screenY(), points[i].screenX(), points[i].screenY());
  }
  line(points[numPoints - 1].screenX(), points[numPoints - 1].screenY(), points[0].screenX(), points[0].screenY());
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


