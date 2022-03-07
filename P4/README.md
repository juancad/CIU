## Práctica 4. Modelo cámara
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#camara)
  2.2. [Cámara](#ventana-juego)
  2.3. [Controles de la nave](#controles)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"></a>
"La tarea de la práctica anterior abordaba la definición de un sistema planetario. Para esta nueva entrega, se incluirá una nave que de forma interactiva podrá navegar por dicho sistema planetario, enfatizando que el movimiento sea esperable para un objeto en movimiento, es decir, suave, sin saltos, sin paradas repentinas. Tener en cuenta que la navegación de la nave podrá afectar no únicamente a su posición en el espacio, sino también a su vertical y al punto hacia el que se mira desde ella, influyendo por tanto en su definición de cámara."

Para poder ejecutar el código, se recomienda:
1. Descargar el proyecto completo.
2. Abrir el archivo P4.pde con processing.
3. Instalar librería de sonido: Herramientas > Añadir herramienta > Libraries > Sound > Install

Ejemplo de ejecución:
![Animation](https://user-images.githubusercontent.com/91132611/156978716-8d069d43-38f0-4670-9b87-8a4d34abaad3.gif)

###2. Descripción del trabajo realizado <a name="descripcion-trabajo"></a>
####2.1 Configuración inicial <a name="config-inicial"></a>
Se ha utilizado la configuración de la P3. Se va ha añadir una nave que podrá moverse por el espacio creado en la P3.
La nave se trata de una imagen que ocupará toda la ventana de la aplicación, con ventanas a través de las cuales se podrá observar el espacio. Se carga la nave en el método setup().
```
//...
  imgNave = loadImage("images/ship.png");
  imgNave.resize(1280, 720);
  beginShape();
  nave = createShape(RECT, 0, 0, 1280, 720);
  nave.setStroke(255); //elimina la visualizacíon de aristas
  nave.setTexture(imgNave);
  endShape(CLOSE);
//...
```
Se han cargado también sonidos.

####2.2 Cámara <a name="cámara"></a>
Utilizando los controles de la aplicación se podrá mover la nave. Para ello se ha utilizado la variable mueveX, que permite cambiar la perspectiva a través del eje x, y mueveY a través del eje y. Para poder rotar la nave se utiliza la variable ang.
```
//...
angL=-sin(radians(ang));
  angR=cos(radians(ang));
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0-mueveX, height/2.0-mueveY, 0, angL, angR, 0);
//...
```
La variable mueveZ me permitirá alejarme o acercarme, por lo que moverá el espacio en el eje Z:translate(width/2, height/2, mueveZ);

```
//...
translate(width/2, height/2, mueveZ);
//...
```

####2.3. Controles de la nave <a name="controles"></a>
Dichos controles modificarán el valor de las variables mencionadas en el punto 2.2.
Pulsar una tecla aumentará o disminuirá el valor de las variables.
```
//...
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
//...
```

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[Guión práctica 4](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P4/README.md)

[Fondo](https://www.deviantart.com/paulinemoss/art/Telescopic-View-426425862)

[Imágenes de las texturas](http://frederickhiggins.com/celestia/terrestrials.htm)

[Música](https://pixabay.com/music/upbeat-space-chillout-14194/)

[Efecto de sonido](https://freesound.org/people/NicknameLarry/sounds/492072/)
