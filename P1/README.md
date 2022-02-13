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
Se mostrará una ventana de inicio que explicará los controles y el funcionamiento básico del juego. 


