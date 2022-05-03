## Práctica 10-11. Introducción a los shaders en Processing
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Carga del objeto 3D y shader](#carga3dyshader)
  2.2. [Archivos GLSL](#archivosglsl)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"/>
"Realizar una propuesta de prototipo que haga uso al menos de un shader de fragmentos y/o vértices, sugiriendo que cree un diseño generativo o realice algún procesamiento sobre imagen. Será aceptable la integración en cualquier práctica precedente." [1]

Para poder ejecutar el código, se necesita:
1. Descargar el proyecto completo.
2. Añadir modo "Shader Mode" a la lista de modos. 
3. Abrir el archivo P10_11.pde con processing y ejecutarlo, con el modo "Shader Mode" seleccionado.

Ejecución de la aplicación:

![Animation2](https://user-images.githubusercontent.com/91132611/166407263-ce117c9c-0c34-4d2e-8837-c2a2ad3d5c80.gif)

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"/>
#### 2.1 Cargar el objeto 3D <a name="carga3dyshader"/>
Para cargar el objeto 3D se ha seguido el código proporcionado por "Processing References"[3]. El objeto que se ha utilzado es de la web free3d, (en formato .obj, el cual se puede cargar en Processing)[4]. En el archivo P10_11.pde se carga el objeto en 3D y los archivos lightfrag.glsl y ligthvert.glsl para aplicar los shaders. Se establece una luz ambiente, se muestra el objeto en 3D (que irá rotando en el eje Y) y se establece el shader.

#### 2.2 Archivos GLSL <a name="archivosglsl"/>
El archivo lightfrag.glsl" y "lightvert.glsl" están basado los archivos con el mismo nombre del guión de la prática 11 [1]. Se ha utilizado también como referencia el archivo "ColoreaInput.glsl" del proyecto "p9_shader_setvalues_coord" del guión de la práctica 10 [2], en el que se colorea cada pixel en función de su posición.
En este caso el valor de la posición se ha obtenido de la variable "gl_Position" en el archivo lightvert. La variable u_time que me permite modificar el color en el tiempo se ha establecido también en el archivo lightvert, que es donde se calcula ahora el color de cada píxel, guarado en la variable vertColor. Se ha cambiado la opacidad en el color para que el cristal tenga un efecto de transparencia.
El resultado es un objeto en 3D (un cristal en este caso) que cambia de color y que tiene un efecto de transparencia.

### 3. Referencias <a name="referencias"></a>

[1][Guión práctica 11](https://github.com/otsedom/otsedom.github.io/tree/main/CIU/P11#readme)

[2][Guión práctica 10](https://github.com/otsedom/otsedom.github.io/tree/main/CIU/P10#readme)

[3][Processing references, Load and Display an OBJ Shape](https://processing.org/examples/loaddisplayobj.html)

[4] [Modelo del objeto en 3d utilizado (free3d.com)](https://free3d.com/es/modelo-3d/3d-crystal-29456.html)
