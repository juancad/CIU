//import gifAnimation.*;
import processing.sound.*;

PImage bg, imgS1, imgNave;
float angS1=0, mueveZ=0, mueveX=0, mueveY=0, angL, angR, ang=0;
PShape S1, nave;
//GifMaker filegif;
Planet P1, P2, P3, P4, P5, P6, P7, P8;
Satelite M1, M2, M3;
int aspecto;
boolean showControls = true, view1 = true, playMusic = true;
SoundFile shipsound, music;

void setup()
{ 
  size(1280, 720, P3D);
  //cargo los sonidos
  shipsound = new SoundFile(this, "sounds/shipsound.wav");
  music = new SoundFile(this, "sounds/music.mp3");
  music.play();

  stroke(0);
  textFont(createFont("Consolas", 15));

  hint(DISABLE_DEPTH_TEST);

  bg = loadImage("images/fondo.jpg");
  bg.resize(1280, 720);

  //carga la nave
  imgNave = loadImage("images/ship.png");
  imgNave.resize(1280, 720);
  beginShape();
  nave = createShape(RECT, 0, 0, 1280, 720);
  nave.setStroke(255); //elimina la visualizacíon de aristas
  nave.setTexture(imgNave);
  endShape(CLOSE);

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
  P8 = new Planet("images/P8.jpg", 35);

  //filegif = new GifMaker(this, "animacion.gif");
  //filegif.setRepeat(0);
}


void draw()
{  
  background(bg);

  pushMatrix();
  angL=-sin(radians(ang));
  angR=cos(radians(ang));
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0-mueveX, height/2.0-mueveY, 0, angL, angR, 0);
  translate(width/2, height/2, mueveZ);

  //crea la estrella principal
  rotateX(radians(-45));
  pushMatrix();
  rotateY(radians(angS1));
  shape(S1);
  popMatrix();
  //giro S1
  if (angS1>360)
    angS1 = 0;
  else
    angS1 = angS1+0.2;

  //P1
  P1.showPlanet(150, 0, 0, 0.3, 1);

  //P2
  P2.showPlanet(220, 0, 0, 0.2, 0.9);

  //P3: planeta con una luna
  P3.showPlanet(-280, 0, 0, 0.25, 0.5);

  //P4
  P4.showPlanet(-380, 0, 0, 0.3, 0.8);

  //P5: planeta con luna
  P5.showPlanet(480, 0, 0, 0.2, 0.6);

  //P6
  P6.showPlanet(-600, 0, 0, 0.4, 1);

  //P7
  P7.showPlanet(-690, 0, 0, 0.15, 0.5);

  //P8
  P8.showPlanet(-750, 0, 0, 0.3, 0.6);

  popMatrix();

  if (view1) {
    //crea la nave
    noFill();
    pushMatrix();
    translate(0, 0, 0);
    shape(nave);
    popMatrix();

    if (showControls) {
      text("Controles:\n Arriba: acercarse\n Abajo: alejarse \n W: Subir\n S: Bajar\n A: Izquierda\n D: Derecha\n F: Girar nave a la izquierda \n G: Girar nave a la derecha\n Z: Pausar/reproducir música\n V: Cambiar vista", 20, height-400);
    }
    fill(127, 255, 0);
    text("Autor\nJuan Carlos\nAlcalde Díaz", width/2-250, height-225);
    fill(0, 0, 255);
    textFont(createFont("Consolas", 10));
    text("Bienvenido/a a la nave.\n\n\n\n\nPulsa n para\nmostrar/ocultar\nlos controles.", width/2-75, height-260);
    fill(255);
    textFont(createFont("Consolas", 15));

    if (keyPressed) {
      if (keyCode == UP) {
        mueveZ+=0.6;
      } else
      {
        if (keyCode == DOWN) {
          mueveZ-=0.6;
        }
      }
      if (key == 'W' || key == 'w') {
        mueveY+=10;
      } else
      {
        if (key == 'S' || key == 's') {
          mueveY-=10;
        } 
        if (key == 'A' || key == 'a') {
          mueveX+=10;
        } else
        {
          if (key == 'D' || key == 'd') {
            mueveX-=10;
          } else {
            if (key == 'F' || key == 'f') {
              ang=ang+0.15;
              if (ang>360) ang=ang-360;
            } else {
              if (key == 'G' || key == 'g') {
                ang=ang-0.5;
                if (ang<0) ang=ang+360;
              }
            }
          }
        }
      }
    }
  } else {
    text("Controles:\n Z: Pausar/reproducir música\n V: Cambiar vista", 20, height-350);
  }

  //filegif.setDelay(1000/60);
  //filegif.addFrame();
}

void keyPressed() {
  if (key == 'N' || key == 'n') {
    if (view1)
      showControls=!showControls;
  } else {
    if (key == 'V' || key == 'v') {
      view1=!view1;
      shipsound.play();
    } else {
      if (key == 'Z' || key == 'z') {
        if (playMusic)
          music.pause();
        else
          music.play();
        playMusic=!playMusic;
      }
    }
  }
}
