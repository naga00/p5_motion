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
  triangles[0] =new Triangle(points[0],   points[1],  points[8],  0xcccccc);
  triangles[1] =new Triangle(points[1],   points[9],  points[8],  0xcccccc);
  triangles[2] =new Triangle(points[1],   points[2],  points[9],  0xcccccc);
  triangles[3] =new Triangle(points[2],   points[4],  points[9],  0xcccccc);
  triangles[4] =new Triangle(points[2],   points[3],  points[4],  0xcccccc);
  triangles[5] =new Triangle(points[4],   points[5],  points[9],  0xcccccc);
  triangles[6] =new Triangle(points[9],   points[5],  points[10], 0xcccccc);
  triangles[7] =new Triangle(points[5],   points[6],  points[7],  0xcccccc);
  triangles[8] =new Triangle(points[5],   points[7],  points[10], 0xcccccc);
  triangles[9] =new Triangle(points[0],   points[10], points[7],  0xcccccc);
  triangles[10] = new Triangle(points[0], points[8],  points[10], 0xcccccc);
  
  triangles[11] = new Triangle(points[11], points[19], points[12], 0xcccccc);
  triangles[12] = new Triangle(points[12], points[19], points[20], 0xcccccc);
  triangles[13] = new Triangle(points[12], points[20], points[13], 0xcccccc);
  triangles[14] = new Triangle(points[13], points[20], points[15], 0xcccccc);
  triangles[15] = new Triangle(points[13], points[15], points[14], 0xcccccc);
  triangles[16] = new Triangle(points[15], points[20], points[16], 0xcccccc);
  triangles[17] = new Triangle(points[20], points[21], points[16], 0xcccccc);
  triangles[18] = new Triangle(points[16], points[18], points[17], 0xcccccc);
  triangles[19] = new Triangle(points[16], points[21], points[18], 0xcccccc);
  triangles[20] = new Triangle(points[11], points[18], points[21], 0xcccccc);
  triangles[21] = new Triangle(points[11], points[21], points[19], 0xcccccc);
  
  triangles[22] = new Triangle(points[0],  points[11], points[1],  0xcccccc);
  triangles[23] = new Triangle(points[11], points[12], points[1],  0xcccccc);
  triangles[24] = new Triangle(points[1],  points[12], points[2],  0xcccccc);
  triangles[25] = new Triangle(points[12], points[13], points[2],  0xcccccc);
  triangles[26] = new Triangle(points[3],  points[2],  points[14], 0xcccccc);
  triangles[27] = new Triangle(points[2],  points[13], points[14], 0xcccccc);
  triangles[28] = new Triangle(points[4],  points[3],  points[15], 0xcccccc);
  triangles[29] = new Triangle(points[3],  points[14], points[15], 0xcccccc);
  triangles[30] = new Triangle(points[5],  points[4],  points[16], 0xcccccc);
  triangles[31] = new Triangle(points[4],  points[15], points[16], 0xcccccc);
  triangles[32] = new Triangle(points[6],  points[5],  points[17], 0xcccccc);
  triangles[33] = new Triangle(points[5],  points[16], points[17], 0xcccccc);
  triangles[34] = new Triangle(points[7],  points[6],  points[18], 0xcccccc);
  triangles[35] = new Triangle(points[6],  points[17], points[18], 0xcccccc);
  triangles[36] = new Triangle(points[0],  points[7],  points[11], 0xcccccc);
  triangles[37] = new Triangle(points[7],  points[18], points[11], 0xcccccc);
  
  triangles[38] = new Triangle(points[8],  points[9],  points[19], 0xcccccc);
  triangles[39] = new Triangle(points[9],  points[20], points[19], 0xcccccc);
  triangles[40] = new Triangle(points[9],  points[10], points[20], 0xcccccc);
  triangles[41] = new Triangle(points[10], points[21], points[20], 0xcccccc);
  triangles[42] = new Triangle(points[10], points[8],  points[21], 0xcccccc);
  triangles[43] = new Triangle(points[8],  points[19], points[21], 0xcccccc);

  Light light = new Light(-100, -100, -100, 1);
  for(int i=0; i<triangles.length; i++) {
    triangles[i].light = light;
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
  sortZ();
  for(int i=0; i<triangles.length; i++) {
    triangles[i].update();
  }
}

void sortZ() {
  for(int i=0; i<triangles.length-1; i++) {
    for(int j=triangles.length-1; j>i; j--) {
      if(triangles[j].zpos > triangles[j-1].zpos) {
        Triangle triangle = triangles[j];
        triangles[j] = triangles[j-1];
        triangles[j-1] = triangle;
      }
    }
  }
  for(int i=0; i<triangles.length; i++) {
     Triangle triangle = triangles[i];
     triangle.update();
  }
}

////////////////////////////////

class Light extends Object {
  float x, y, z;
  float brightness;
  
  Light(float x, float y, float z, float brightness) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.brightness = brightness;  
  }
  
  void setBrightness(float b) {
    brightness = max(b, 0);
    brightness = min(brightness, 1);
  }
}

////////////////////////////////

class Triangle extends Sprite {
  Point3D pointA;
  Point3D pointB;
  Point3D pointC;
  int cn;
  Light light;
  float zpos;
  int red, green, blue;
  
  Triangle(Point3D a, Point3D b, Point3D c, int cn){
    super();
    pointA = a;
    pointB = b;
    pointC = c;
    this.cn = cn;
  }
  
  void draw(){
    setDepth();
    if(isBackFace()) {
      return;
    }
    
    red = cn >> 16;
    green = cn >> 8 & 0xff;
    blue = cn & 0xff;
    float lightFactor = getLightFactor();
    red *= lightFactor;
    green *= lightFactor;
    blue *= lightFactor;
    fill(color(red, green, blue));
    
    beginShape(TRIANGLE_STRIP);
    vertex(pointA.screenX(), pointA.screenY());
    vertex(pointB.screenX(), pointB.screenY());
    vertex(pointC.screenX(), pointC.screenY());
    vertex(pointA.screenX(), pointA.screenY());
    endShape();
  }

  float getLightFactor() {
    Point3D ab = new Point3D(0, 0, 0);
    ab.x = pointA.x - pointB.x;
    ab.y = pointA.y - pointB.y;
    ab.z = pointA.z - pointB.z;
      
    Point3D bc = new Point3D(0, 0, 0);
    bc.x = pointB.x - pointC.x;
    bc.y = pointB.y - pointC.y;
    bc.z = pointB.z - pointC.z;
      
    Point3D norm = new Point3D(0, 0, 0);
    norm.x = (ab.y * bc.z) - (ab.z * bc.y);
    norm.y = -((ab.x * bc.z) - (ab.z * bc.x));
    norm.z = (ab.x * bc.y) - (ab.y * bc.x);
      
    float dotProd = norm.x * light.x + norm.y * light.y + norm.z * light.z;
    float normMag = sqrt(norm.x * norm.x + norm.y * norm.y + norm.z * norm.z);
    float lightMag = sqrt(light.x * light.x + light.y * light.y + light.z * light.z);

    return (acos(dotProd / (normMag * lightMag)) / PI) * light.brightness;
  }
  
  Boolean isBackFace() {
    float cax = pointC.screenX() - pointA.screenX();
    float cay= pointC.screenY() - pointA.screenY();
    float bcx = pointB.screenX() - pointC.screenX();
    float bcy = pointB.screenY() - pointC.screenY();
    return cax * bcy > cay * bcx;
  }
  
  void setDepth() {
    zpos = min(pointA.z, pointB.z);
    zpos = min(zpos, pointC.z);
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


