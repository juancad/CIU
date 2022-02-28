//import gifAnimation.*;

PShape S1, P1, P2, P3, P4, P5, P6, P7, P8, M1, M2; 
PImage bg, imgS1, imgP1, imgP2, imgP3, imgP4, imgP5, imgP6, imgP7, imgP8, imgM1, imgM2;
float movRot=0, angS1=0, angP1=0, angP2=0, angP3=0, angP4=0, angP5=0, angP6=0, angP7=0, angP8=0, angM1=0, angM2;
boolean showSat = true, showP1 = true, showP2 = true, showP3 = true, showP4 = true, showP5 = true, showP6 = true, showP7 = true, showP8 = true;
//GifMaker filegif;

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
  imgP1 = loadImage("images/P1.jpg");
  beginShape();
  P1 = createShape(SPHERE, 15);
  P1.setStroke(255); //elimina visualización de aristas
  P1.setTexture(imgP1); 
  endShape(CLOSE);

  //carga P2
  imgP2 = loadImage("images/P2.jpg");
  beginShape();
  P2 = createShape(SPHERE, 20);
  P2.setStroke(255); //elimina visualización de aristas
  P2.setTexture(imgP2); 
  endShape(CLOSE);

  //carga P3
  imgP3 = loadImage("images/P3.jpg");
  beginShape();
  P3 = createShape(SPHERE, 22);
  P3.setStroke(255); //elimina visualización de aristas
  P3.setTexture(imgP3); 
  endShape(CLOSE);

  //carga P4
  imgP4 = loadImage("images/P4.jpg");
  beginShape();
  P4 = createShape(SPHERE, 22);
  P4.setStroke(255); //elimina visualización de aristas
  P4.setTexture(imgP4); 
  endShape(CLOSE);

  //carga P5
  imgP5 = loadImage("images/P5.jpg");
  beginShape();
  P5 = createShape(SPHERE, 35);
  P5.setStroke(255); //elimina visualización de aristas
  P5.setTexture(imgP5); 
  endShape(CLOSE);

  //carga P6
  imgP6 = loadImage("images/P6.jpg");
  beginShape();
  P6 = createShape(SPHERE, 35);
  P6.setStroke(255); //elimina visualización de aristas
  P6.setTexture(imgP6); 
  endShape(CLOSE);

  //carga P7
  imgP7 = loadImage("images/P7.jpg");
  beginShape();
  P7 = createShape(SPHERE, 15);
  P7.setStroke(255); //elimina visualización de aristas
  P7.setTexture(imgP7); 
  endShape(CLOSE);

  //carga P8
  imgP8 = loadImage("images/P8.jpg");
  beginShape();
  P8 = createShape(SPHERE, 40);
  P8.setStroke(255); //elimina visualización de aristas
  P8.setTexture(imgP8); 
  endShape(CLOSE);

  //carga M1
  imgM1 = loadImage("images/M1.jpg");
  beginShape();
  M1 = createShape(SPHERE, 7);
  M1.setStroke(255); //elimina visualización de aristas
  M1.setTexture(imgM1); 
  endShape(CLOSE);

  //carga M2
  imgM2 = loadImage("images/M2.jpg");
  beginShape();
  M2 = createShape(SPHERE, 8);
  M2.setStroke(255); //elimina visualización de aristas
  M2.setTexture(imgM2); 
  endShape(CLOSE);
  
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
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP1));
    translate(150, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P1);
    popMatrix();
    angP1 = incrementAng(angP1, 0.3);
  }

  //P2
  if (showP2) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP2));
    translate(220, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P2);
    popMatrix();
    angP2 = incrementAng(angP2, 0.2);
  }

  //P3: planeta con una luna
  if (showP3) {
    pushMatrix();
    //movimiento de traslación P3
    rotateY(radians(angP3));
    translate(-280, 0, 0);
    //movimiento de rotación P3
    rotateY(radians(movRot));
    shape(P3);
    if (showSat) {
      //movimiento de traslación de la luna
      rotateY(radians(angM1));
      translate(40, 0, 0);
      //movimiento de rotación de la luna
      rotateY(radians(movRot));
      shape(M1);
    }
    popMatrix();
    angP3 = incrementAng(angP3, 0.25);
    angM1 = incrementAng(angM1, 0.5);
  }

  //P4
  if (showP4) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP4));
    translate(-380, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P4);
    popMatrix();
    angP4 = incrementAng(angP4, 0.3);
  }

  //P5: planeta con luna
  if (showP5) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP5));
    translate(480, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P5);
    if (showSat) {
      //movimiento de traslación de la luna 2
      rotateY(radians(angM2));
      translate(80, 0, 0);
      //movimiento de rotación de la luna 2
      rotateY(radians(movRot));
      shape(M2);
    }
    popMatrix();
    angP5 = incrementAng(angP5, 0.2);
    angM2 = incrementAng(angM2, 0.1);
  }

  //P6
  if (showP6) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP6));
    translate(-600, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P6);
    popMatrix();
    angP6 = incrementAng(angP6, 0.4);
  }

  //P7
  if (showP7) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP7));
    translate(-680, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P7);
    popMatrix();
    angP7 = incrementAng(angP7, 0.15);
  }

  //P8
  if (showP8) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angP8));
    translate(-750, 0, 0);
    //movimiento de rotación
    rotateY(radians(movRot));
    shape(P8);
    popMatrix();
    angP8 = incrementAng(angP8, 0.3);
  }

  movRot = incrementAng(movRot, 0.6);

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
