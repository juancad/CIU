## Práctica 1. Introducción a Processing y p5.js
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

[Introducción](#Introducción)

[Descripción del trabajo realizado](#Descripción-del-trabajo-realizado)  

### 1. Introducción
Se realizará un juego similar al pong para 2 jugadores utilizando [Proccessing](https://processing.org/).
La propuesta realizada debe incluir al menos: rebote, marcador, sonido, movimiento inicial aleatorio, admitiendo aportaciones propias de cada estudiante. La propuesta debe cuidar aspectos de usabilidad, dado que la evaluación se basará en el cumplimiento de los requisitos, además de la usabilidad, y el rigor y calidad de la documentación.

Para poder ejecutar el código, se recomienda:
1. Descargar el proyecto completo.
2. Abrir el archivo P1.pde con processing.
3. Instalar librería de sonido: Herramientas > Añadir herramienta > Libraries > Sound > Install

### 2. Descripción del trabajo realizado

#### Configuración inicial
Para comenzar, la ventana de juego tendrá un tamaño de 500x500px. El texto estará centrado y se cargarán los sonidos haciendo uso de la librería de sonido. Los sonidos estarán guardados en la carpeta sounds del proyecto.

```
import processing.sound.*;

SoundFile sonidoBoing;
SoundFile sonidoGoal;

void setup() {
  size(500, 500);
  textAlign(CENTER);
  //cargo los sonidos
  sonidoBoing = new SoundFile(this, "sounds/boing.wav");
  sonidoGoal = new SoundFile(this, "sounds/goal.wav");
}

```

#### Ventana de inicio:
Se mostrará una ventana de inicio que explicará los controles y el funcionamiento básico del juego. Para ello me he creado una variable booleana que indica si la ventana de inicio está activa o no. En caso de que esté activa, se mostrarán los controles con imágenes utilizando las funciones [image](https://processing.org/reference/image_.html) y [resize](https://processing.org/reference/PImage_resize_.html). 
En caso de que se presione la tecla enter (para saberlo se hace uso de la variable [key](https://processing.org/reference/key.html)), se cambiará el valor de la variable booleana inicio a false, se limpia la ventana con la función clear() y daría comienzo al juego.

```
import processing.sound.*;

SoundFile sonidoBoing;
SoundFile sonidoGoal;
boolean inicio=true; //indica si la ventana de inicio está activa

void setup() {
  size(500, 500);
  textAlign(CENTER);
  //cargo los sonidos
  sonidoBoing = new SoundFile(this, "sounds/boing.wav");
  sonidoGoal = new SoundFile(this, "sounds/goal.wav");
}

void draw() {
  if (inicio) { //si el juego no ha iniciado se mostrará la ventana inicial
    background(217, 217, 217);
    textSize(15);
    fill(169, 22, 22);
    text("BIENVENIDOS AL JUEGO DEL PONG", width/2, 50);
    fill(0, 0, 0);
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
    text("Moverse arriba:", 345, 120);
    PImage arriba2 = loadImage("images/w.png");
    arriba2.resize(70, 70);
    image(arriba2, 310, 120);
    text("Moverse abajo:", 345, 210);
    PImage abajo2 = loadImage("images/s.png");
    abajo2.resize(70, 70);
    image(abajo2, 310, 210);
    
    if (keyPressed == true) {
      if (key == ENTER) {
        inicio = false;
        clear();
      }
    }
  } else {
    //se mostrará aquí la ventana de juego
  }
}

```
Aspecto de la ventana de inicio:

![image](https://user-images.githubusercontent.com/91132611/153782316-4f585044-c46b-4c4f-b85b-388fefcc7143.png)

#### Ventana de juego
Una vez presionada la tecla enter en la ventana de inicio, dará comienzo al juego. El fondo será de color negro, y se dibujará un círculo para el balón, que será de color blanco, utiliznado la función [ellipse](https://processing.org/reference/ellipse_.html). Las variables posX y posY tendrán la posición del balón, la variable D contiene el diámegro del balón.

```
    background(0);
    noStroke();
    fill(255, 255, 255);
    ellipse(posX, posY, D, D);
```
Se ha modificado el setup para que inicialmente, el balón esté en una posición X y una posición Y aleatoria (se tiene en cuenta el diámetro a la hora de establecer la posición para que el balón no aparezca fuera de la ventana de juego). Las variables mov y mov2 indican el movimiento del balón (si es hacia arriba, abajo, izquierda o derecha). Un valor negativo de mov indica que el balón va hacia la izquierda, y positivo a la derecha. Un valor negativo de mov2 indica que el balón va hacia arriba, y positivo hacia abajo. En el setup también se establece el movimiento de forma aleatoria.

```
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
  if (random(0, 10)>=5) {
    mov=-2;
    mov2=-2;
  }
}
```

Ahora habría que dibujar a cada jugador en la ventana de juego. Para ello se utilizará una posición X e Y. La variable anchojug contiene el tamaño de ancho de los rectángulos de los jugadores. El jugador 1 estará en la posición 50+anchojug y el jugador 2 en la posición width-50, ya que quiero dejar un margen de 50 píxeles entre el borde izquierdo y derecho de la ventana y el rectángulo del jugador.
Posteriormente se controla las teclas que se han pulsado. El jugador 1 tendrás los controles arriba y abajo, y el jugador 2 los controles w y s. En caso de que se pulse alguna tecla de estas, se modificará la posición del jugador en el eje Y, aumentando o disminuyendo de 5 en 5. Luego se dibujan ambos jugadores con la función [rect](https://processing.org/reference/rect_.html). 

```
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
```

Se actualizan las posiciones del balón conforme al movimiento:
```
    posX=posX+mov;
    posY=posY+mov2;
```

Ahora se verifica si hay choque con el borde superior o inferior de la ventana, para modificar el movimiento del balón en caso de que ocurra.
```
    if (posY>=height-D/2 || posY<=50+D/2) {
      mov2=-mov2;
    }
```
En caso de que el balón llegue a uno de los bordes superior o inferior, se modifica el movimiento, pasando de positivo a negativo o viceversa.

También se verifica si hay choque con el borde izquierdo o derecho, y con los jugadores, para modificar su movimiento sobre el eje X. Se ha creado una variable booleana que me indica si me he chocado con un borde o no, para poder diferenciar el sonido que hace cuando choca con un borde (se marca un gol) de cuando choca contra un jugador.
En caso de que se marque gol, se incrementa en 1 el marcador del jugador que ha marcado y se indica con una variable booleana qué jugador ha sido el que ha marcado el gol (para posteriormetne mostrarlo en el juego).
```
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
```

Posteriormente se muestra el marcador y quién ha marcado gol.
```
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
```
Aspecto de la ventana de juego:

![image](https://user-images.githubusercontent.com/91132611/153784186-478285cd-d50b-4028-a07d-8f7d2dba48ad.png)


#### Fin del juego
El fin del juego llegará cuando uno de los dos jugadores haya marcado 6 goles.
Se ha creado otra variable booleana que indica si el juego ha terminado o no, que se activará cuando uno de los jugadores haya llegado a 6 goles.
```
import processing.sound.*;

int D=30; //diámetro de la bola
float posX=D/2+1; //posición X del balón
float posY=50+D/2+1; //posición Y del balón
int anchojug=20;
int altojug=50;
int mov=4;
int mov2=4;
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
  if (random(0, 10)>=5) {
    mov=-2;
    mov2=-2;
  }
}

void draw() {
  if (inicio) { //si el juego no ha iniciado se mostrará la ventana inicial
    background(217, 217, 217);
    textSize(15);
    fill(169, 22, 22);
    text("BIENVENIDOS AL JUEGO DEL PONG", width/2, 50);
    fill(0, 0, 0);
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
    text("Moverse arriba:", 345, 120);
    PImage arriba2 = loadImage("images/w.png");
    arriba2.resize(70, 70);
    image(arriba2, 310, 120);
    text("Moverse abajo:", 345, 210);
    PImage abajo2 = loadImage("images/s.png");
    abajo2.resize(70, 70);
    image(abajo2, 310, 210);

    if (keyPressed == true) {
      if (key == ENTER) {
        inicio = false;
        clear();
      }
    }
  } else { //si el juego ha iniciado
    if (!fin) {
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

      if (goles1==6 || goles2==6) {
        fin = true;
        clear();
      }
    } else { //el juego ha finalizado
      if (goles1==6) {
        background(228, 225, 100);
        fill(0, 0, 0);
        textSize(20);
        text("¡ENHORABUENA AL JUGADOR 1!", width/2, height/2);
        text("Ha ganado la partida.", width/2, height/2+20);
      } else {
        background(100, 103, 227);
        fill(0, 0, 0);
        textSize(20);
        text("¡ENHORABUENA AL JUGADOR 2!", width/2, height/2);
        text("Ha ganado la partida.", width/2, height/2+20);
      }
    }
  }
}

```
