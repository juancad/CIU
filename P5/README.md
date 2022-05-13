## Práctica 5. Iluminación y texturas
### Autor: Juan Carlos Alcalde Díaz

### Contenidos

1. [Introducción](#introduccion)
2. [Descripción del trabajo realizado](#descripcion-trabajo)
  2.1. [Configuración inicial](#config-inicial)
  2.2. [Pantalla de inicio](#inicio)
  2.2. [Vista del mapa](#mapa)
  2.3. [Vista del gráfico de barras](#grafico)
3. [Referencias](#referencias)

### 1. Introducción <a name="introduccion"/>
"En la web de [Sagulpa](https://www.sagulpa.com) puedes localizar el enlace a su [Portal de Transparencia](https://www.sagulpa.com/portal-transparencia), desde donde se puede acceder a una interesante colección de [datos abiertos](https://www.sagulpa.com/datos-abiertos) de aparcamientos y la Sitycleta. En la tarea propuesta, se  les invita a usar los datos de la Siticleta de 2021,  [SÍTYCLETA 2021](https://www.sagulpa.com/descargar.php?f=51&m=39). El archivo contiene el diario de préstamos de bicicletas, incluyendo el horario y fecha, los minutos de uso, además de las estaciones de alquiler y entrega.

La tarea a entregar consiste en hacer uso de la información contenida en dicho fichero, de forma completa o parcial (según estimen, pudiendo si así lo consideran necesario  hacer uso de información de otros años), para visualizar los datos allí presentes haciendo uso de las técnicas vistas para gráficos 3D en *Processing*" [1]

Ejemplo de ejecución:

![Animation](https://user-images.githubusercontent.com/91132611/159076674-cf34918a-7964-49fa-9a6d-3b7137bfab04.gif)

### 2. Descripción del trabajo realizado <a name="descripcion-trabajo"/>
#### 2.1 Configuración inicial <a name="config-inicial"/>
En el método setup() se carga la información de las estaciones de préstamo, para almacenarlas en una estructura. Hay un ArrayList que contiene la información de cada estación. Es un ArrayList de "Ubicacion". La clase "Ubicacion" contiene el id de la ubicación (un autonumérico), el nombre, el número de la latitud, el número de la longitud, el número de veces que se ha cogido la Siticleta en esa estación durante el año 2021 y los minutos que se ha utilizado la Siticleta partiendo de esa estación de origen en el año 2021.

#### 2.2 Vista de inicio <a name="incio"/>
Muestra dos botones, que llevan a la vista de mapa y a la vista del gráfico de barras. Si pulsas sobre uno de esos botones, te llevará a la vista correspondiente. 
A la derecha se muestra una tabla, con los datos de cada estación, recogidos del ArrayList que almacena los datos de cada estación.

![image](https://user-images.githubusercontent.com/91132611/159075523-e0fbe10f-1ffa-455c-8a2c-c4d3a4e89b8e.png)

#### 2.3. Vista de mapa <a name="mapa"/>
Muestra el mapa, basado en el mapa del guión de la práctica [1] con algunas modificaciones. Se ha creado una tabla a la izquierda, que muestra el número de la estación y su nombre. En cada ubicación del mapa se muestra el número de la estación en vez del nombre, para evitar que los nombres se sobrepongan. Al pulsar el botón BACKSPACE, se regresará a la ventana de inicio.

![image](https://user-images.githubusercontent.com/91132611/159075638-3658fc72-6487-4e92-8473-6b5c77eaba5f.png)

#### 2.4. Vista del gráfico de barras <a name="grafico"/>
Muestra un gráfico de barras, basado en el tutorial de la referencia [2]. El gráfico muestra las 4 estaciones donde más se ha cogido la Siticleta durante el año 2021, así como el número de veces que se ha cogido la Siticleta durante este año en cada una de las estaciones que muestra el gráfico. Al pulsar el botón BACKSPACE se regresará a la ventana de inicio.

![image](https://user-images.githubusercontent.com/91132611/159076034-136ee5b2-0145-4e25-951e-3314c722832a.png)

### 3. Referencias <a name="referencias"></a>
Processing references [proccesing.org](https://processing.org/reference/)

[1][Guión práctica 5](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P5/README.md)

[2][Crear gráfico de barras en processing](https://www.youtube.com/watch?v=UXNok3zHlTQ)
