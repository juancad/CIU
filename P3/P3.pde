//import gifAnimation.*;

PImage bg, imgS1;
float movRot=0, angS1=0;
boolean showSat = true, showP1 = true, showP2 = true, showP3 = true, showP4 = true, showP5 = true, showP6 = true, showP7 = true, showP8 = true;
PShape S1;
//GifMaker filegif;
Planet P1, P2, P3, P4, P5, P6, P7, P8;
Satelite M1, M2, M3;

void setup()
{
  size(1280, 720, P3D);
  stroke(0);
  textFont(createFont("Consolas", 14));

  bg = loadImage("images/fondo.jpg");
  bg.resize(1280, 720);

  //carga el sol
  imgS1 = loadImage("images/S1.jpg");
  beginShape();
  S1 = createShape(SPHERE, 70);
  S1.setStroke(255); //elimina visualización de aristas
  S1.setTexture(imgS1); 
  endShape(CLOSE);

  //carga P1
  P1 = new Planet("images/P1.jpg", 15);

  //carga P2
  P2 = new Planet("images/P2.jpg", 15);

  //carga P3
  P3 = new Planet("images/P3.jpg", 22);
  //añado una luna a P3
  P3.addSatelite(new Satelite("images/M1.jpg", 7, 40, 0.5, 0.7));

  //carga P4
  P4 = new Planet("images/P4.jpg", 21);

  //carga P5
  P5 = new Planet("images/P5.jpg", 34);
  //añado dos lunas a P5
  P5.addSatelite(new Satelite("images/M2.jpg", 8, 80, 0.5, 0.7));
  P5.addSatelite(new Satelite("images/M3.jpg", 5, 100, 0.23, 1));
    
  //carga P6
  P6 = new Planet("images/P6.jpg", 28);

  //carga P7
  P7 = new Planet("images/P7.jpg", 15);

  //carga P8
  P8 = new Planet("images/P8.jpg", 40);

  //filegif = new GifMaker(this, "animacion.gif");
  //filegif.setRepeat(0);
}


void draw()
{  
  background(bg);

  text("Controles:\n R: ocultar satélites.\n T: mostrar satélites.\n 1, 2, 3, 4, 5, 6, 7, 8: ocultar planeta.\n ESPACIO: mostrar todo.", 20, height-105);
  text("Juan Carlos Alcalde Díaz", width-210, height-20);

  //crea la estrella principal
  translate(width/2, height/2, 0);
  rotateX(radians(-45));
  pushMatrix();
  rotateY(radians(angS1));
  shape(S1);
  popMatrix();
  //giro S1
  angS1 = incrementAng(angS1, 0.2);

  //P1
  if (showP1) {
    P1.showPlanet(150, 0, 0, 0.3, 1, false);
  }

  //P2
  if (showP2) {
    P2.showPlanet(220, 0, 0, 0.2, 0.9, false);
  }

  //P3: planeta con una luna
  if (showP3) {
    P3.showPlanet(-280, 0, 0, 0.25, 0.5, showSat);
  }

  //P4
  if (showP4) {
    P4.showPlanet(-380, 0, 0, 0.3, 0.8, false);
  }

  //P5: planeta con luna
  if (showP5) {
    P5.showPlanet(480, 0, 0, 0.2, 0.6, showSat);
  }

  //P6
  if (showP6) {
    P6.showPlanet(-600, 0, 0, 0.4, 1, false);
  }

  //P7
  if (showP7) {
    P7.showPlanet(-680, 0, 0, 0.15, 0.5, false);
  }

  //P8
  if (showP8) {
    P8.showPlanet(-750, 0, 0, 0.3, 0.6, false);
  }

  if (keyPressed == true && (key == 'R' || key == 'r')) {
    showSat = false;
  }
  if (keyPressed == true && (key == 'R' || key == 't')) {
    showSat = true;
  }

  if (keyPressed == true && key == ' ') {
    showSat = true;
    showP1 = true;
    showP2 = true;
    showP3 = true;
    showP4 = true; 
    showP5 = true; 
    showP6 = true; 
    showP7 = true; 
    showP8 = true;
  }

  if (keyPressed == true && key == '1') {
    showP1 = false;
  }
  if (keyPressed == true && key == '2') {
    showP2 = false;
  }
  if (keyPressed == true && key == '3') {
    showP3 = false;
  }
  if (keyPressed == true && key == '4') {
    showP4 = false;
  }
  if (keyPressed == true && key == '5') {
    showP5 = false;
  }
  if (keyPressed == true && key == '6') {
    showP6 = false;
  }
  if (keyPressed == true && key == '7') {
    showP7 = false;
  }
  if (keyPressed == true && key == '8') {
    showP8 = false;
  }

  //filegif.setDelay(1000/60);
  //filegif.addFrame();
}

float incrementAng(float ang, float veloc) {
  if (ang>360)
    return 0;
  else
    return ang+veloc;
}
