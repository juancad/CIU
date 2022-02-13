import processing.sound.*;

int D=30; //diámetro de la bola
float posX=D/2+1; //posición X del balón
float posY=50+D/2+1; //posición Y del balón
int anchojug=20;
int altojug=50;
int mov=2;
int mov2=2;
int goles1=0;
int goles2=0;
int muestragol=0;
int jug1y=50; //posición inicial jugador 1
int jug2y=50; //posición inicial jugador 2
boolean juggol=false; //indica el último jugador en marcar gol
SoundFile sonidoBoing;
SoundFile sonidoGoal;
boolean inicio=false; //indica si el juego ha finalizado

void setup() {
  size(500, 500);
  textAlign(CENTER);
  //cargo los sonidos
  sonidoBoing = new SoundFile(this, "sounds/boing.wav");
  sonidoGoal = new SoundFile(this, "sounds/goal.wav");
  //comienzo con una posición aleatoria del balón
  posX=random(D/2+1, width-D/2-1);
  posY=random(50+D/2+1, height-D/2-1);
  //movimiento inicial aleatorio
  if (random(0, 20)>=10) {
    mov=-2;
    mov2=-2;
  }
}

void draw() {
  if (!inicio) { //si el juego no ha iniciado se mostrará la ventana inicial
    textSize(15);
    fill(0, 0, 0);
    text("BIENVENIDOS AL JUEGO DEL PONG", width/2, 50);
    text("Presiona la tecla:", width/2, 100);
    image(loadImage("images/enter.png"), 0, 0);

    if(keyPressed == true) {
      if(key == ENTER) {
        inicio = true;
      }
    } 
  } else { //si el juego ha iniciado
    background(0);
    noStroke();
    fill(255, 255, 255);
    ellipse(posX, posY, D, D);

    int jug1x=50-anchojug;
    int jug2x=width-50;

    if (keyPressed == true) {
      if (keyCode == UP && jug1y>50) {
        jug1y=jug1y-5;
      } else if (keyCode == DOWN && jug1y<=height-50) {
        jug1y=jug1y+5;
      }
      if ((key  == 'W' || key == 'w') && jug2y>50) {
        jug2y=jug2y-5;
      } else if ((key  == 'S' || key == 's') && jug2y<=height-50) {
        jug2y=jug2y+5;
      }
    }

    //dibujo ambos jugadores
    noStroke();
    fill(228, 225, 100);
    rect(jug1x, jug1y, anchojug, altojug);
    fill(100, 103, 227);
    rect(jug2x, jug2y, anchojug, altojug);

    posX=posX+mov;
    posY=posY+mov2;

    //verificando si hay choque vertical
    if (posY>=height-D/2 || posY<=50+D/2) {
      mov2=-mov2;
    }

    //verificando si hay choque horizontal
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
      }

      //Si choca con la izquierda, es gol para el jugador 2
      if  (posX<=0+D/2)
      {
        goles2=goles2+1;
        muestragol=40;
        juggol=false; //indica que el último gol es del jug2
        choqueBorde = true;
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
    text(goles1, width/2-25, 25);
    fill(100, 103, 227);
    rect (width/2, 0, 40, 40, 0, 0, 25, 0);
    fill(255, 255, 255);
    text(goles2, width/2+12, 25);

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
  }
}
