## Práctica 9. Síntesis y procesamiento de audio
### Autores: Pablo Morales Gómez y Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"/>
"Programar una interfaz que utilice la información de distancia suministrada por el sensor infrarrojo Sharp GP2D12 o similar, capturada a través del Arduino, para controlar el movimiento del juego Pong implementado con Processing." [1]

Se ha modificado el juego del pong (práctica 1) para que se permita controlar el movimiento del jugador 2 mediante un sensor infrarrojo.

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"/>

Se han utilizado las siguientes variables:
- "val" de tipo String: tendrá los valores recogidos del puerto serie.
- "mappedVal" de tipo float: tendrá el valor de "val" transformado a float y mapeado para que el número esté en el rango de valores del tamaño ventana de la aplicación.
- "previousPos" de tipo entero: guarda la posición del jugador 2 para utilziarla en caso de que se recoja algún valor nulo del sensor infrarrojo y que el jugador se mantenga en la posición anterior.

Se ha modificado el movimiento del jugador 2, sustituyendo los controles de la práctica 1 por el control del sensor infrarrojo.
El código en el que se define el movimiento del jugador 2 a partir de los datos recogidos por el sensor infrarrojo es el siguiente:
```
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
 ```

En el programa, se recogen los datos del sensor infrarrojo y se almacenan en la variable "val". Si el valor recogido no es nulo, se procede a transformar el valor recogido a un número en formato float. Posteriormente se establece un límite para valNum y se mapea dicho valor para que evitar que el jugador 2 se salga de la ventana del juego, para ello se utiliza la función [map(value, start1, stop1, start2, stop2)](https://processing.org/reference/map_.html).
La posición del jugador 2 ahora será ahora el valor recogido por el sensor infrarrojo, mapeado para que se encuentre en una posición válida dentro del juego. La posición actual se guarda en una variable para que, en caso de que se recoja un valor nulo se utilice dicha posición.

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[1] [Guión práctica 9](https://github.com/otsedom/otsedom.github.io/tree/main/CIU/P9)
