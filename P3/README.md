## Práctica 3. Transformaciones
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#config-inicial)
  2.2. [Planetas](#planetas)
  2.3. [Satélites](#satelites)
  2.4. [Controles](#controles)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"></a>
"Crear un prototipo que muestre un sistema planetario en movimiento que incluya una estrella, al menos cinco planetas y alguna luna, integrando primitivas 3D, texto e imágenes (p.e. imagen de fondo). Se valorará que exista algún tipo de interacción."

Un ejemplo de ejecución:
![animacion](https://user-images.githubusercontent.com/91132611/155978719-7051460b-55cd-454e-a40c-37242c6a9d42.gif)

#### 2.1 Configuración inicial <a name="config-inicial"></a>
El método setup() contendrá la configuración inicial de la aplicaicón, en la que se carga una imagen de fondo, se cambia la fuente por defecto y se establece el tamaño de la ventana de la aplicaicón en 1280x720.

Se cargarán también las texturas de las estrellas, planetas y satélites.
Para la estrella principal, se ha cargado la textura de la forma:
```
  imgS1 = loadImage("images/S1.jpg");
  beginShape();
  S1 = createShape(SPHERE, 70);
  S1.setStroke(255); //elimina visualización de aristas
  S1.setTexture(imgS1); 
  endShape(CLOSE);
```
Que crea una esfera de tamaño 70. Cuando se vaya a dibujar dicha esfera, estará en el centro de la aplicación para que sea la estrella principal del sistema planetario. El resto de planetas girará alrededor de dicha estrella.

En el método draw() se dibuja la estrella, con su movimiento de rotación (esta estrella sólo rotará sobre sí misma).
```
  //crea la estrella principal
  translate(width/2, height/2, 0);
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
```
Como girará sólo sobre sí misma, se establece un movimiento en el eje Y (no se mueve en el resto de ejes). El ángulo de rotación va aumentando en el tiempo, lo que permite que la esfera gire sobre sí misma.

Para los planetas del sistema y satélites, se han craedo las clases: "Planet" y "Satelite".

#### 2.2 Planetas <a name="planetas"></a>
Los planetas están definidos en la clase "Planet".
El constructor por defecto permite crear un planeta con una imagen y un tamaño determinado. Dicho constructor se usará en el método setup() de la clase principal para cargar la textura y establecer el tamaño del planeta.
La clase Planet contiene una lista de satélites, que contendrá los satélites que tiene cada planeta.
El método showPlanet() permite mostrar el planeta en una posición determinada, con una velocidad de traslación y rotación definida. Si el planeta tiene satélites, se mostrarán dichos satélites. La aplicación permite ocultar los satélites del planeta, para ello se utilzia un parámetro booleano que permitirá saber si se deben mostrar o no los satélites en la aplicación.
El método addSatelite(Satelite s) permite añadir un satélite a un planeta.

#### 2.3 Satélites <a name="satelites"></a>
Los satélites están definidos en la clase "Satelite".
El constructor por defecto permite crear un satelite con una imagen, un tamaño determinado, la distancia a la que se encuentra del planeta y una velocidad de traslación y de rotación determinadas. Dicho constructor se usará en el método setup() para cargar la textura, establecer el tamaño del satélite y los parámetros que definen su posición y velocidad de rotación y traslación. En el método setup() se crearán los planetas, satélites y se añadirán los satélites al planeta.
El método showSatelite() permite mostrar el satélite a la distancia del planeta que hayamos determinado, con una velocidad de traslación y rotación definida.

#### 2.4 Controles <a name="satelites"></a>
El usuario podrá ocultar determiandos planetas en la aplicación. Para ocultar el primer planeta, se deberá pulsar la tecla 1, para el segundo la tecla 2 y así sucesivamente. Para ocultar los satélites se deberá pulsar la tecla R y para ocultarlos la tecla T. Se utlizan para ello variables booleanas, que estarán activas si el planeta o satélites se tienen que mostrar. Al pulsar una tecla numérica se desactivará la variable booleana correspondiente al planeta que quiera ocultar. Si pulso espacio, se activará el booleano correspondiente a cada planeta y a los satélites, mostrándolos.

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[Guión práctica 3](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P3/README.md)

[Fondo](https://www.deviantart.com/paulinemoss/art/Telescopic-View-426425862)

[Imágenes de las texturas](http://frederickhiggins.com/celestia/terrestrials.htm)
