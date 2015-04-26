float angle = 0;
float centerY;
float range = 50;
float xspeed = 1;
float yspeed = 0.05;
float xpos;
float ypos;
float pxpos;
float pypos;
    
void setup() {
  background(255);  
  size(960, 540);
  frameRate(30);
  initialize();
}

void initialize() {
  centerY = height/2;
  xpos = 0;
  pxpos = ypos;
  ypos = centerY;
  pypos = ypos;
}

void draw() {
  stroke(0);
  xpos += xspeed;
  angle += yspeed;
  ypos = centerY + sin(angle) * range;
  line(pxpos, pypos, xpos, ypos);
  pxpos = xpos;
  pypos = ypos;
}
