import processing.sound.*;
import processing.serial.*;

int D=30; //diámetro de la bola
float posX=D/2+1; //posición X del balón
float posY=50+D/2+1; //posición Y del balón
int anchojug=20;
int altojug=50;
int mov=3;
int mov2=3;
int goles1=0;
int goles2=0;
int muestragol=0;
int jug1y=50; //posición inicial jugador 1
int jug2y=50; //posición inicial jugador 2
boolean juggol=false; //indica el último jugador en marcar gol
SoundFile sonidoBoing;
SoundFile sonidoGoal;
boolean inicio=true; //indica si está abierta la ventana de inicio
boolean fin=false;


Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
float mappedVal;
int previousPos = 0;

void setup() {
  size(500, 500);
  textAlign(CENTER);
  textFont(createFont("Consolas", 12));
  //cargo los sonidos
  sonidoBoing = new SoundFile(this, "sounds/boing.wav");
  sonidoGoal = new SoundFile(this, "sounds/goal.wav");
  //comienzo en el centro de la ventana en el eje X
  posX=width/2;
  //comienzo con una posición aleatoria del balón para el eje Y
  posY=random(50+D/2+1, height-D/2-1);
  //movimiento inicial aleatorio (izquierda o derecha)
  if (random(0, 10)>=5) {
    mov=mov*-1;
    mov2=-mov2*-1;
  }


  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  if (inicio) { //si el juego no ha iniciado se mostrará la ventana inicial
    background(217, 217, 217);
    textSize(15);
    fill(169, 22, 22);
    text("BIENVENIDOS AL JUEGO DEL PONG", width/2, 50);
    fill(0, 0, 0);
    textSize(13);
    text("Ganará el primer jugador que marque 5 goles.", width/2, 310);
    textSize(15);
    text("Presiona la tecla:", width/2, 340);
    PImage enter = loadImage("images/enter.png");
    enter.resize(100, 90);
    image(enter, width/2-60, 350);
    text("Para poder iniciar una partida", width/2, 460);

    //se muestran los controles del jugador 1
    textSize(12);
    text("Controles del jugador 1:", 155, 95);
    fill(228, 225, 100);
    noStroke();
    rect(80, 100, 150, 180, 15);
    fill(0, 0, 0);
    text("Moverse arriba:", 155, 120);
    PImage arriba = loadImage("images/up.png");
    arriba.resize(70, 70);
    image(arriba, 120, 120);
    text("Moverse abajo:", 155, 210);
    PImage abajo = loadImage("images/down.png");
    abajo.resize(70, 70);
    image(abajo, 120, 210);
    
    //se muestran los controles del jugador 2
    fill(0, 0, 0);
    textSize(12);
    text("Controles del jugador 2:", 345, 95);
    fill(100, 103, 227);
    noStroke();
    rect(270, 100, 150, 180, 15);
    fill(0, 0, 0);
    text("Utilizar sensor\ninfrarrojo.", 345, 180);
    /*
    PImage arriba2 = loadImage("images/w.png");
    arriba2.resize(70, 70);
    image(arriba2, 310, 120);
    text("Moverse abajo:", 345, 210);
    PImage abajo2 = loadImage("images/s.png");
    abajo2.resize(70, 70);
    image(abajo2, 310, 210);
    */

    if (keyPressed == true) {
      if (key == ENTER) {
        inicio = false;
        clear();
      }
    }
  } else { 
    //si el juego ha iniciado
    if (!fin) {
      background(0);
      noStroke();
      fill(255, 255, 255);
      //dibuja el balón
      ellipse(posX, posY, D, D);
      stroke(255, 255, 255);
      strokeWeight(2);
      //dibuja la línea discontinua
      for (int i=5; i<width; i+=10)
        line(width/2, i-5, width/2, i);

      int jug1x=50-anchojug;
      int jug2x=width-50;

      if (keyPressed == true) {
        if (keyCode == UP && jug1y>0) {
          jug1y=jug1y-5;
        } else if (keyCode == DOWN && jug1y<=height-50) {
          jug1y=jug1y+5;
        }
      }

      if ( myPort.available() > 0) {  // If data is available,
        val = myPort.readStringUntil('\n'); // read it and store it in val

        if (val != null) {

          float valNum = int(val.trim());
          if (valNum > height - altojug) valNum = height - altojug;
          if (valNum < 80) valNum = 80;

          mappedVal = map(valNum, 80, 450, 0, height-altojug);
          //println(mappedVal);
          jug2y = int(mappedVal);
          previousPos = int(mappedVal);
        } else {
          jug2y = int(previousPos);
        }
      }

      fill(100, 103, 227);
      rect(jug2x, jug2y, anchojug, altojug);

      //dibujo ambos jugadores
      noStroke();
      fill(228, 225, 100);
      rect(jug1x, jug1y, anchojug, altojug);

      posX=posX+mov;
      posY=posY+mov2;

      //verificando si hay choque con el borde superior o inferior de la ventana
      if (posY>=height-D/2 || posY<=50+D/2) {
        mov2=-mov2;
      }

      //verificando si hay choque con el borde izquierdo o derecho de la ventana, o con el jugador
      if (posX>=width-D/2 || posX<=0+D/2 || (mov<0 && jug1y<=posY+D/2 && posY-D/2<=jug1y+altojug && jug1x+anchojug>=posX-D/2) || (mov>0 && jug2y<=posY+D/2 && posY-D/2<=jug2y+altojug && jug2x<=posX+D/2))
      {
        boolean choqueBorde = false; //si no ha chocado con borde
        mov=-mov;
        //Si choca con la derecha, es gol para el jugador 1
        if  (posX>=width-D/2)
        {
          goles1=goles1+1;
          muestragol=40;
          juggol=true; //indica que el último gol es del jug1
          choqueBorde = true;
          //cambio la posición del balón de nuevo
          posX=width/2;
          posY=random(50+D/2+1, height-D/2-1);
        }

        //Si choca con la izquierda, es gol para el jugador 2
        if  (posX<=0+D/2)
        {
          goles2=goles2+1;
          muestragol=40;
          juggol=false; //indica que el último gol es del jug2
          choqueBorde = true;
          //cambio la posición del balón de nuevo
          posX=width/2;
          posY=random(50+D/2+1, height-D/2-1);
        } 
        if (!choqueBorde) {
          sonidoBoing.play();
        } else {
          sonidoGoal.play();
        }
      }

      //marcador
      textSize(20);
      fill(228, 225, 100);
      rect (width/2-40, 0, 40, 40, 0, 0, 0, 25);//rectángulo
      fill(255, 255, 255);
      text(goles1, width/2-20, 25);
      fill(100, 103, 227);
      rect (width/2, 0, 40, 40, 0, 0, 25, 0);
      fill(255, 255, 255);
      text(goles2, width/2+20, 25);

      if (muestragol>0) {
        if (juggol) {
          textSize(14);
          fill(228, 225, 100);
          text("GOOOL DEL JUGADOR 1", width/2, height-50);
        } else {
          textSize(14);
          fill(100, 103, 227);
          text("GOOOL DEL JUGADOR 2", width/2, height-50);
        }
        muestragol=muestragol-1;
      }

      if (goles1==5 || goles2==5) {
        fin = true;
        clear();
      }
    } else { //el juego ha finalizado
      if (goles1==5) {
        background(228, 225, 100);
        fill(0, 0, 0);
        textSize(20);
        text("¡ENHORABUENA AL JUGADOR 1!\n Ha ganado la partida.", width/2, height/2-100);
        text("Pulsa ENTER para volver a jugar.\n Pulsa BACKSPACE para volver\na la ventana inicial.", width/2, height/2+20);
      } else {
        background(100, 103, 227);
        fill(0, 0, 0);
        textSize(20);
        text("¡ENHORABUENA AL JUGADOR 2!\n Ha ganado la partida.", width/2, height/2-100);
        text("Pulsa ENTER para volver a jugar.\n Pulsa BACKSPACE para volver\na la ventana inicial.", width/2, height/2+20);
      }
      if (keyPressed == true) {
        if (key == BACKSPACE) {
          fin = false;
          inicio = true;
          goles1 = goles2 = 0;
        } else         if (key == ENTER) {
          fin = false;
          goles1 = goles2 = 0;
        }
      }
    }
  }
}
