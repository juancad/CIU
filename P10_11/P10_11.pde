PShape s;
int rotation;
PShader sh;

void setup() {
  size(720, 720, P3D);
  s = loadShape("Crystal.obj");
  s.scale(100);
  rotation = 0;

  sh = loadShader("lightfrag.glsl" ,"lightvert.glsl");
}

void draw() {
  background(10);
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
  shader(sh);
  sh.set("u_time", float(millis())/float(1000));
      
  pushMatrix();
  translate(width/2, height/2+100);
  rotateX(radians(180));
  rotateY(radians(rotation));
  shape(s);
  popMatrix();

  if (rotation >=360)
    rotation = 0;
  else
    rotation ++;
}
