## Práctica 7. Síntesis y procesamiento de audio
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#config-inicial)
  2.2. [Modificador de volumen](#volumen)
  2.3. [Modificador de frecuencia del sonido sinu](#frecuencia)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"/>
"Realizar una propuesta de prototipo integrando al menos gráficos y síntesis de sonido. Se acepta la modificación de alguna de las prácticas precedentes."

Para poder ejecutar el código, se recomienda:
1. Descargar el proyecto completo.
2. Abrir el archivo P7.pde con processing.
3. Instalar librería de sonido: Herramientas > Añadir herramienta > Libraries > Sound > Install

Se utilziará como base el código de la [P4](https://github.com/juancad/CIU/tree/main/P4) para integrar síntesis de sonido. Las modificaciones relizadas son: permitir aumentar y disminuir el volumen, mostrar el volumen en un gráfico e integrar un oscilador sinuoidal que aumente su frecuencia a medida que avance la nave y disminuya a medida que retroceda.

Ejecución de la aplicación con los cambios realizados:
![image](https://user-images.githubusercontent.com/91132611/160536967-7222025b-5b61-4c7f-84b0-3b16dcd29468.png)

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"/>
#### 2.1 Configuración inicial <a name="config-inicial"/>
Se ha realizado una amplicación de la parte en la que se cargan los sonidos de la P4, añadiendo el sonido SinOsc, que permitirá integrar un oscilador sinuoidal. El volumen estará definido por una variable entera llamada musicAmp, que tendrá un valor por defecto de 5. El volumen podrá aumentar o disminuir, teniendo valores entre 0 y 10. Se establece la amplitud por defecto de los sonidos de la aplicación con el valor de la variable musicAmp, con una amplitud mínima de 0 y máxima de 10.

```
//...
  //cargo los sonidos
  sinu = new SinOsc(this);
  shipsound = new SoundFile(this, "sounds/shipsound.wav");
  music = new SoundFile(this, "sounds/music.mp3");
  //establezco el volumen por defecto
  music.amp(map(musicAmp, 0, 10, 0, 1));
  shipsound.amp(map(musicAmp, 0, 10, 0, 1));
  sinu.amp(map(musicAmp, 0, 10, 0, 1));
  music.play();
//...
```

#### 2.2 Modificador de volumen <a name="volumen"/>
A la hora de presionar la tecla '+' aumentará el volumen (variable musicAmp). Si pulso '-', disminuirá la variable. Esto se realiza en el método keyPressed(), añadiendo el código que se muestra a continuación:

```  
//...
    if (key == '+') {
    //aumenta el volumen de la música
    if (musicAmp < 10)
      musicAmp++;
    music.amp(map(musicAmp, 0, 10, 0, 1));
    sinu.amp(map(musicAmp, 0, 10, 0, 1));
    shipsound.amp(map(musicAmp, 0, 10, 0, 1));
  } else if (key == '-') {
    //disminuye el volumen de la música
    if (musicAmp > 0)
      musicAmp--;
    music.amp(map(musicAmp, 0, 10, 0, 1));
    sinu.amp(map(musicAmp, 0, 10, 0, 1));
    shipsound.amp(map(musicAmp, 0, 10, 0, 1));
  }
//...
```
En definitiva, se modifica la variable musicAmp (teniendo en cuenta que el mínimo es 0 y el máximo es 10), y se establece la nueva amplitud en los sonidos de la aplicación (los cuales son 3: music, sinu y shipsound).

Se muestra también un gráfico con el volumen de la aplicación (en el método draw()) de la siguiente manera:
```  
//...
    //dibuja el volumen
    for(int i = 0; i < musicAmp; i++) {
      rect(width/2-75+i*13, height-150, 10, 20);
    }
//...
```
Lo que hace es dibujar un rectángulo por cada valor de sonido que tengamos (es decir, si el sonido es 0, no dibujará nada, si el sonido es 5, dibujará 5 rectángulos de seguido).


#### 2.3. Modificador de frecuencia del sonido sinu <a name="frecuencia"/>
En la aplicación, la tecla UP permitía a la nave avanzar y la telca DOWN permitía a la nave retroceder. La modificación con respecto a la P4 que se ha realizado, es la de hacer sonar el sonido sinu y aumentar su frecuencia al pulsar UP (con un máximo de 600) y disminuir al pulsar DOWN (con un mínimo de 0).
```
//...
      if (keyCode == UP) {
        mueveZ+=0.6;
        sinu.play();
        if (sinuFreq < 600)
          sinuFreq++;
        sinu.freq(map(sinuFreq, 0, 600, 20.0, 500.0));
      } else
      {
        if (keyCode == DOWN) {
          mueveZ-=0.6;
          sinu.play();
          if (sinuFreq > 0)
            sinuFreq--;
          sinu.freq(map(sinuFreq, 0, 600, 20.0, 500.0));
        }
      }
//...
```

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[Guión práctica 7](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P7/README.md)

[Fondo](https://www.deviantart.com/paulinemoss/art/Telescopic-View-426425862)

[Imágenes de las texturas](http://frederickhiggins.com/celestia/terrestrials.htm)

[Imagen de la nave](https://www.nicepng.com/ourpic/u2w7i1u2e6i1a9q8_spaceship-cockpit-png-sci-fi-cockpit-png/)

[Música](https://pixabay.com/music/upbeat-space-chillout-14194/)

[Efecto de sonido](https://freesound.org/people/NicknameLarry/sounds/492072/)
