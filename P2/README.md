## Práctica 2. Superficie de revolución
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#config-inicial)
  2.2. [Vista de dibujo](#vista-dibujo)
  2.3. [Vista del objeto tridimensional](#vista-objeto-tridimensional)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"></a>

"Crear un prototipo que recoja puntos de un perfil del sólido de revolución al hacer clic con el ratón sobre la pantalla. Dicho perfil será utilizado por el prototipo para crear un objeto tridimensional por medio de una superficie de revolución, almacenando la geometría resultante en una variable de tipo PShape, ver a modo de ilustración la figura. El prototipo permitirá crear sólidos de revolución de forma sucesiva, si bien únicamente se asumirá necesario almacenar el último definido."

Un ejemplo de ejecución del código:

![animacion](https://user-images.githubusercontent.com/91132611/155011123-cb93983f-fe2d-494c-8fb7-263732eb2a8d.gif)

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"></a>

#### 2.1 Configuración inicial <a name="config-inicial"></a>
Se establece el tamaño de la ventana (800px de ancho y 600px de alto), el modo P3D (para que el programa me permita crear figuras en 3D), la fuente y el color por defecto de la aplicación.
En el método draw() se establecerá el color de fondo por defecto. La variable booleana view1 me indica si la vista 1 está activa o no, si está activa, se mostrará la ventana de dibujo, si no, se mostrará la ventana que dibuja el objeto tridimensional por medio de la superficie de revolución.
La geomtería se almacenará en la variable de tipo PSHape, llamada figure.
Si pulso la tecla enter desde la ventana de dibujo iré a la ventana donde se muestra el objeto tridimensional. En caso de que pulse la tecla backspace desde la ventana donde se muestra el objeto tridimensional, volveré a la ventana de dibujo.

```
PShape figure;
boolean view1=true;

void setup() {
  size(800, 600, P3D);
  textFont(createFont("Consolas", 14));
  stroke(255, 255, 255);
  
  filegif = new GifMaker(this, "animacion.gif");
  filegif.setRepeat(0);
}

void draw() {
  background(0);

  if (view1) {
    //muestro la ventana de dibujo
    clear();
    drawView();
  } else {
    //muestra la ventana de gráficos
    clear();
    graphicView();
  }
}

void drawView() {
//...
  if (keyPressed == true && key == ENTER) {
    view1 = false;
  }
}

void graphicView() {
//...
  if (keyPressed == true && key == BACKSPACE) {
    view1 = true;
    points = new ArrayList<Point>();
  }
}
```

#### 2.2 Vista de dibujo <a name="vista-dibujo"></a>

El método **drawView()** contiene toda la implementación de la vista de dibujo.
Se dibuja una linea en el centro de la ventana, que servirá para dividir la ventana en dos. La mitad izquierda de la ventana se utilizará para mostrar los comandos y otra información relevante. La mitad derecha de la ventana, se utilizará para dibujar la figura con el click del ratón.
```  
line(width/2, 0, width/2, height);
```
Posteriormente se añade la información que se muestra en la **mitad izquierda** de la ventana:
```  
noFill();
rect (10, 10, 320, 90);
text("Controles: \n Click izquierdo: Añadir vértices. \n ENTER: Generar superficie revolución.\n BACKSPACE: Borrar dibujo.\n\n\nSolo se puede dibujar en la zona\nderecha de la ventana.", 20, 30);
text("Autor: Juan Carlos Alcalde Díaz", 20, height-30);
```
La **mitad derecha** de la ventana será la zona de dibujo. Como el usuario dibujará con el clic izquierdo del ratón, se controla que cuando se haga clic izquierdo sobre la mitad derecha de la ventana (controlando que no dibuje fuera de los límites), se añada un nuevo vértice a la lista de puntos.
Para poder almacenar los vértices, se crea una variable de tipo ArrayList de "Punto". Punto será una clase que se crea a continuación y que contiene el valor x y el valor y de los puntos dibujados.
```  
if (mousePressed && (mouseButton == LEFT)) {
  if (mouseX>width/2 && mouseX<width && mouseY>0 && mouseY<height) {
    points.add(new Point(mouseX, mouseY));
   }
}
```
Hay que mostrar las líneas que el usuario vaya dibujando. Para ello se recorren todos los puntos que se han creado anteriormente (con el clic derecho del ratón se han ido añadiendo los puntos a la lista) y se dibujará una línea entre cada uno de los puntos.
```
for (int i=0; i<points.size(); i++) {
  if (i>0) {
    line(points.get(i-1).getX(), points.get(i-1).getY(), points.get(i).getX(), points.get(i).getY());
  }
}
```
En caso de que se presione la tecla de retroceso o backspace, se eliminará el dibujo creado por el usuario, por lo que se vuelve a inicializar la variable points con un ArrayList vacío:
```
if (keyPressed == true && key == BACKSPACE) {
  points = new ArrayList<Point>();
}
```

Aspecto de la ventana de dibujo:
![image](https://user-images.githubusercontent.com/91132611/155011833-47b8c913-a050-402f-a7d6-6e48485b9ad2.png)

Aspecto de la ventana de dibujo con un dibujo creado por el usuario:
![image](https://user-images.githubusercontent.com/91132611/155011770-5a50ec47-d760-421a-b5fd-b98079433713.png)

#### 2.2 Vista del objeto tridimensional <a name="vista-objeto-tridimensional"></a>

El método **graphicView()** contiene toda la implementación de la vista del objeto tridimensional.
En esta vista se construye el objeto utilizando como referencia los puntos de la figura que ha creado el usuario en la vista anterior. En primer lugar, se muestran los controles de esta vista:
```
rect (10, 10, 320, 110);
text("Controles: \n Mover cursor: mueve la figura. \n +: Aumentar zoom\n -: Disminuir zoom.\n BACKSPACE: Volver a dibujar.", 20, 30);
```

Posteriormente se crea la figura añadiendo los vértices a una variable de tipo PShape llamada figure. Para determinar donde se crean los puntos, se ha utilizado como referencia la siguiente fórmula [1]:

![image](https://user-images.githubusercontent.com/91132611/155009552-b11f296d-d3a7-4026-ba8f-3ebf8beadd04.png)

```
figure = createShape();
figure.beginShape(TRIANGLE_STRIP);
figure.stroke(255);
figure.strokeWeight(3);

//añade los vértices a la figura
for (int i = 1; i < points.size(); i++) {
  for (int j = 0; j <= 16; j++) {
    figure.vertex(width/2+((points.get(i-1).getX()-(width/2)) * cos(PI/8*j)), points.get(i-1).getY(), (width/2)+((points.get(i-1).getX()-(width/2)) * sin(PI/8*j)));
    figure.vertex(width/2+((points.get(i).getX()-(width/2)) * cos(PI/8*j)), points.get(i).getY(), (width/2)+((points.get(i).getX()-(width/2)) * sin(PI/8*j)));
   }
}

  figure.endShape();
```
También se crea una variable de tipo entero que me permitirá determinar el zoom que hago en la figura, para que cuando pulse la tecla + aumente el zoom, y cuando pulse - disminuya. El zoom aumentará o disminuirá en 5 cuando se pulse una de estas teclas:
```
if (keyPressed && key == '+')
  zoom+=5;
if (keyPressed && key == '-')
  zoom-=5;
```
La figura se moverá siguiendo el cursor, por lo que en el translate se utiliza como referencia mouseX y mouseY para posicionar la figura. Se utiliza también el zoom, que se establece en un inicio en -1000 sumado al valor de la variable zoom. Posteriormente, se dibuja la figura.
```
translate(mouseX-width/2, mouseY-width/2, -1000 + zoom);
shape(figure);
```
Si pulso el botón de retroceso o backspace, se volverá a la vista anterior y borraré el dibujo que ha creado el usuario, reinicializando el ArrayList puntos.
```
if (keyPressed == true && key == BACKSPACE) {
  view1 = true;
  points = new ArrayList<Point>();
}
```

Aspecto de la ventana que muestra el objeto tridimensional creado por el usuario:
![image](https://user-images.githubusercontent.com/91132611/155011815-249e6acd-20b9-4687-8bf9-07514fe8205e.png)

```
rect (10, 10, 320, 110);
text("Controles: \n Mover cursor: mueve la figura. \n +: Aumentar zoom\n -: Disminuir zoom.\n BACKSPACE: Volver a dibujar.", 20, 30);
```

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[1] [Guión práctica 2](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P2/README.md#21-pshape)
