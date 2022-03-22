## Práctica 6. Modelo cámara
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#config-inicial)
  2.2. [Descripción de la aplicación](#descripcion)
  2.3. [Ventana de ayuda](#ayuda)
  2.4. [Invertir imagen](#invertir)
  2.5. [Zoom](#zoom)
  2.. [Filtros](#filtros)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"/>
"Proponer un concepto y su prototipo de combinación de salida gráfica e interacción en respuesta a una captura de vídeo. Una sugerencia puede ser inspirarse en trabajos ya existentes, como los de la galería." [1]

Ejemplo de ejecución:

![Animation2](https://user-images.githubusercontent.com/91132611/159420329-66670ce4-3b4c-49eb-b1e3-c0c508178c3f.gif)

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"/>
#### 2.1 Configuración inicial <a name="config-inicial"/>
Se ha configurado un tamaño de ventana de 1280x720px. La fuente por defecto elegida es Helvetica, con tamaño 18.
Se mostrará 4 veces la cámara en la pantalla, por lo que se dividirá la pantalla en 2x2. Inicialmente se cargan 4 imágenes del tipo CVImage, que contendrán la vista de la cámara.

#### 2.2 Descripción de la aplicación <a name="descripcion"/>
La aplicación estará dividida en 4 espacios iguales. Cada espacio de cámara tendrá un ancho de width/2 y un alto de height/2, para poder tener 2x2 imágenes recogidas de la cámara.
En la primera imagen (ubicada posición 0,0), se podrán aplicar filtros. También se podrá hacer zoom sobre la primera imagen con la rueda del ratón. En caso de hacer zoom, la primera imagen ocupará toda la ventana de la aplicación.
Las demás imágenes (ubicadas en la posición 0,1; 1,0 y 1,1) se aplicará en una un filtro rojo, en otra un filtro verde y en otra un filtro azul.
También se mostrará una pequeña ventana de ayuda, que aparecerá cuando se pulsa el botón H, en el centro de la ventana de la aplicación. Esta ventana mostrará los comandos para poder aplicar filtros a la imagen.

Vista al abrir la aplicación:

![image](https://user-images.githubusercontent.com/91132611/159412132-262a0d2b-21dc-459c-a9ce-3cb9d2f05c8a.png)

#### 2.3 Ventana de ayuda <a name="ayuda"/>
Por defecto aparecerá oculta, pulsando H aparecerá la ventana con los controles de la aplicaicón.

Vista de la ventana de ayuda:

![image](https://user-images.githubusercontent.com/91132611/159412500-2b59e777-84ff-4879-a7d8-21ae5ef8dc67.png)

Una variable booleana indica si la ventana de ayuda está activada o no. En caso de que no esté activada, se mostrará el control "H: Mostrar ayuda" en la parte central inferior de la ventana de la aplicación. En caso de que esté activada, se mostrará la ayuda en el centro de la aplicación.
```
    if (help) {
      fill(220);
      rect(width/2-110, height/2-110, 220, 220, 20, 20, 20, 20);
      fill(0);
      textSize(18);
      text("Controles:", width/2-92, height/2-75);
      textSize(13);
      text("Botón izquierdo: cambiar filtro\nBotón derecho: voltear imagen\nRueda: aumentar zoom\nH: Ocultar ayuda\n\nAutor:\nJuan Carlos Alcalde Díaz", width/2-92, height/2-45);
    } else {
      fill(220);
      rect(width/2-70, height-25, 140, 25, 5, 5, 0, 0);
      fill(0);
      textSize(14);
      text("H: Mostrar ayuda", width/2-55, height-8);
```

#### 2.4 Invertir imagen <a name="invertir"/>
Al pulsar el botón izquierdo del ratón se invertirá la imagen. Se controla con una variable booleana, que cambia de estado al pulsar el botón izquierdo del ratón.
Para poder invertir la imagen se ha hecho uso del método scale(-1, 1);
Si el primer parámetro es negativo, se invierte horizontalmente. En caso de que el segundo parámetro sea positivo, se invierte el segundo. Al utilizar este método, la posición de las imágenes también debe cambiarse, puesto que al rotarla se desplaza:
```
      scale(-scale, scale);
      image(img, -width/2, 0);
      tint(256, 0, 0);
      image(img2, -width, 0);
      tint(0, 256, 0);
      image(img3, -width/2, height/2);
      tint(0, 0, 256);
      image(img4, -width, height/2);
```

Invirtiendo la imagen:

![Animation](https://user-images.githubusercontent.com/91132611/159414389-00a13898-ad14-470f-a3cd-9d4318581a27.gif)

#### 2.5 Zoom <a name="zoom"/>
Al utilizar la rueda del ratón se aplicará un zoom sobre la primera imagen, que hará que desaparezcan las demás imágenes de la ventana para mostrarse sólo la primera.
Esto se consigue gracias al método scale, que si se utiliza de la forma scale(2, 2); aumenta x2 el tamaño de la imagen (en ancho y alto). Para que varíe con la rueda del ratón, se ha utilziado una variable entera "scale", que valdrá 1 si el zoom no está activado y 2 si está activado.

Haciendo zoom a la imagen:

![Animation2](https://user-images.githubusercontent.com/91132611/159419043-65d69caf-fb45-4d52-ba24-01d8ce486f75.gif)

#### 2.6 Filtros <a name="filtros"/>
Los filtros se aplicarán sobre la primera imagen. Para saber qué filtro aplicar, se usa una variable entera llamada "imgMode". En la aplicación hay 5 filtros, y uno por defecto, por lo que la variable tomará valores del 0 al 5.
Al pulsar el botón izquierdo del ratón se cambiará de filtro. Cuando se pulsa el botón izquierdo, si la variable vale más de 5 vuelve a su estado inicial, 0.
Algunos filtros están basados en los del guión de la práctica [1], y otros se han realizado utilizando el método filter() de processing [2].

### 3. Referencias <a name="referencias"></a>
[1][Guión práctica 6](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P6/README.md)

[2] Processing references [proccesing.org](https://processing.org/reference/)

YouTube: [Aplicar filtros a una imagen](https://www.youtube.com/watch?v=zYdtMaszMfI)

YouTube [Introduction to Webcam Effects](https://www.youtube.com/watch?v=6pGEk2dQnss)
