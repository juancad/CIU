PGraphics lienzo;
PImage img;

float minlat, minlon, maxlat, maxlon;

ArrayList<Ubicacion> ubicaciones=new ArrayList<Ubicacion>();
int nest = 0;
int r = 12;

float zoom;

int x;
int y;

Table Estaciones, Datos2021;

View view = View.START;

float ang;

void setup() {
  size(800, 800, P3D);

  //Cargamos información de estaciones de préstamo
  Estaciones = loadTable("Geolocalización estaciones sitycleta.csv", "header");
  Datos2021 = loadTable("SITYCLETA-2021.csv", "header");
  //Estaciones.getRowCount() contiene el número de entradas

  //Almacenamos datos en nuestra estructura
  nest = 0;
  int veces = 0; //contará las veces que se ha cogido la SitiCleta en esa estación
  float minutos = 0; //contará los minutos que se ha usado la SitiCleta con esa estación de origen
  for (TableRow est : Estaciones.rows()) {
    veces = contarVeces(est.getString("nombre"));
    minutos = contarMinutos(est.getString("nombre"));
    ubicaciones.add(new Ubicacion(nest, est.getString("nombre"), float(est.getString("latitud")), float(est.getString("altitud")), veces, minutos));
    //System.out.println(est.getString("nombre")+" "+veces+" "+minutos);
    nest++;
  }

  //Imagen del Mapa
  img=loadImage("mapaLPGC.png");
  //Creamos lienzo par el mapa
  lienzo = createGraphics(img.width, img.height);
  lienzo.beginDraw();
  lienzo.background(100);
  lienzo.endDraw();

  //Latitud y longitud de los extremos del mapa de la imagen
  minlon = -15.5304;
  maxlon = -15.3656;
  minlat = 28.0705;
  maxlat = 28.1817;

  //Inicializa desplazamiento y zoom
  x = 0;
  y = 0;
  zoom = 1;

  //Compone imagen con estaciones sobre el lienzo
  dibujaMapayEstaciones();

  ang=0;
  noStroke();
  sphereDetail(60);
}

void draw() {
  switch(view) {
  case START:
    drawStartMenu();
    //abre la vista del mapa si pulsa el botón
    if (mousePressed && (mouseX>=width/4-75 && mouseX<=width/4+75 && mouseY>=height/2-175 && mouseY<=height/2-25)) {
      view = view.MAP;
      clear();
    }
    //abre la vista del gráfico si pulsa el botón
    if (mousePressed && (mouseX>=width/4-75 && mouseX<=width/4+75 && mouseY>=height/2+75 && mouseY<=height/2+225)) {
      view = view.GRAPHIC;
      clear();
    }
    break;
  case MAP:
    drawMap();
    //vuelve a la vista anterior si presiona BACKSPACE
    if (keyPressed == true && key == BACKSPACE) {
      view = View.START;
      clear();
    }
    break;
  case GRAPHIC:
    drawGraphic();
    if (keyPressed == true && key == BACKSPACE) {
      view = View.START;
      clear();
    }
    break;
  }
}

//Rueda del ratón para modificar el zoom
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += e/10;
  if (zoom<1)
    zoom = 1;
}

//dibuja la pantalla de inicio
void drawStartMenu() {
  background(25, 31, 59);
  fill(255);
  textFont(createFont("Tw Cen MT", 28));
  text("SITICLETA 2021", 30, 50);
  textFont(createFont("Arial", 15));
  textLeading(20);
  text("Datos recogidos del portal de transparencia\nde la web de Sagulpa.", 30, 80);
  text("Autor de la aplicación:\nJuan Carlos Alcalde Díaz", 30, 760);

  rect(400, 20, 380, 760);
  //dibuja la tabla con los datos
  textFont(createFont("Arial", 15));
  fill(25, 31, 59);
  text("NOMBRE", 405, 40);
  text("VECES", 605, 40);
  text("MINUTOS", 675, 40);
  fill(0);
  stroke(2);
  line(595, 20, 600, 780);
  line(670, 20, 670, 780);
  noStroke();
  textFont(createFont("Arial", 13));

  for (int i = 0; i < nest; i++) {
    //muestra el nombre
    text(ubicaciones.get(i).getNombre(), 405, i*15+60);
    //muestra las veces que se ha cogido
    text(contarVeces(ubicaciones.get(i).getNombre()), 605, i*15+60);
    //muestra los minutos que se ha cogido
    text(contarMinutos(ubicaciones.get(i).getNombre()), 675, i*15+60);
  }

  fill(255);
  textFont(createFont("Tw Cen MT", 16));
  text("Pulsa el botón para ver el mapa:", 100, 200);
  text("Pulsa el botón para ver el gráfico de barras:", 75, 450);

  lights();
  pushMatrix();
  translate(width/4, height/2-100, 0);
  rotateX(radians(-30));
  rotateY(radians(ang));
  ambient(255, 255, 0);//Capa el azul del reflejo ambniente
  fill(255);

  sphere(75);
  popMatrix();

  pushMatrix();
  translate(width/4, height/2+150, 0);
  rotateX(radians(-30));
  rotateY(radians(ang));
  ambient(255, 255, 0);//Capa el azul del reflejo ambniente

  sphere(75);
  popMatrix();

  ang+=1;
  if (ang>360) ang=0;
}

//dibuja el gráfico de barras
void drawGraphic() {
  background(200);

  //dibuja el botón de return
  textFont(createFont("Arial", 12));
  fill(255);
  stroke(1);
  rect(670, 20, 110, 50);
  noStroke();
  fill(0);
  text("← BACKSPACE:\nVolver atrás", 680, 40);

  fill(0);
  textFont(createFont("Tw Cen MT", 28));
  text("SITICLETA 2021", 30, 50);
  textFont(createFont("Arial", 15));
  textLeading(20);
  text("Datos recogidos del portal de transparencia\nde la web de Sagulpa.", 30, 80);
  text("El siguiente gráfico muestra las veces que se ha cogido la Siticleta en la estación correspondiente.\nSe muestran las estaciones donde más se ha cogido.", 30, 150);

  //dibuja el gráfico de barras
  String[] aparcamientos = {"San Telmo", "Plaza de la Feria", "Base Naval", "Parque Santa Catalina"};
  //calculo el porcentaje
  float total = contarVeces("San Telmo") + contarVeces("Plaza de la Feria") + contarVeces("Base Naval") + contarVeces("Parque Santa Catalina");
  float[] porcentajes = {contarVeces("San Telmo")*100/total, contarVeces("Plaza de la Feria")*100/total, contarVeces("Base Naval")*100/total, contarVeces("Parque Santa Catalina")*100/total};

  //muestra los datos de las 4 estaciones
  for (int i = 0; i< aparcamientos.length; i++)
    text(aparcamientos[i]+": "+contarVeces(aparcamientos[i])+" veces.", 30, 220+i*20);


  float x = width * 0.1;
  float y = height * 0.9;
  float delta = width * 0.8/porcentajes.length;
  float w = delta * 0.8;

  for (float value : porcentajes) {
    float h = map(value, 0, 100, 0, height);
    fill(210, 70, 50);
    rect(x, y-h, w, h);
    x = x+delta;
  }

  textSize(15);
  x = width * 0.1;
  y = height * 0.92;
  delta = width * 0.8/porcentajes.length;
  for (int i = 0; i < porcentajes.length; i++) {
    fill(0);
    text(aparcamientos[i], x, y);
    x=x+delta;
  }
}

//dibuja el mapa
void drawMap() {
  background(220);
  //Desplazamiento con botón izquierdo ratón
  if (mousePressed && mouseButton == LEFT) {
    x += (mouseX - pmouseX)/zoom;
    y += (mouseY - pmouseY)/zoom;
  }

  //Coloca origen en el centro
  translate(width/2, height/2, 0);
  //Escala según el zoom
  scale(zoom);
  //Centro de la imagen en el origen
  translate(-img.width/2+x, -img.height/2+y);

  image(lienzo, 0, 0);
}

private void dibujaMapayEstaciones() {
  //Dibuja sobre el lienzo
  lienzo.beginDraw();
  //Imagen de fondo
  lienzo.image(img, 0, 0, img.width, img.height);
  lienzo.fill(255);
  lienzo.rect(145, 20, 242, 775);

  lienzo.textFont(createFont("Arial", 12));
  //dibuja el botón de return
  lienzo.rect(810, 20, 110, 50);
  lienzo.fill(0);
  lienzo.text("← BACKSPACE:\nVolver atrás", 820, 40);

  //Círculo y etiqueta de cada estación según latitud y longitud

  for (int i=0; i<nest; i++) {
    float mlon = map(ubicaciones.get(i).getLongitud(), minlon, maxlon, 0, img.width);
    //latitud invertida con respecto al eje y de la ventana
    float mlat = map(ubicaciones.get(i).getLatitud(), maxlat, minlat, 0, img.height);

    lienzo.fill(0);
    lienzo.ellipse(mlon, mlat, r, r);
    lienzo.fill(255);
    lienzo.textFont(createFont("Arial Black", 8));
    lienzo.textAlign(CENTER, CENTER);
    //imprime el id de la estación
    if (i>=10)
      lienzo.text(ubicaciones.get(i).getId(), mlon, mlat-2);
    else
      lienzo.text(ubicaciones.get(i).getId(), mlon, mlat-2);
    //imprime el nombre y la estación
    lienzo.fill(0);
    lienzo.textFont(createFont("Arial", 15));
    lienzo.textAlign(LEFT, LEFT);
    lienzo.text(ubicaciones.get(i).getId()+": "+ubicaciones.get(i).getNombre(), 150, i*16+36);
  }
  lienzo.endDraw();
}

//cuenta las veces que se ha cogido la SitiCleta en una estación que tenga como nombre el nombre que se pasa por parámetros
int contarVeces(String nombre) {
  int cont = 0;
  for (TableRow datos : Datos2021.rows()) {
    if (datos.getString("Rental place").equals(nombre)) {
      cont++;
    }
  }
  return cont;
}

//cuenta las veces que se ha cogido la SitiCleta en una estación que tenga como nombre el nombre que se pasa por parámetros
float contarMinutos(String nombre) {
  float cont = 0;
  for (TableRow datos : Datos2021.rows()) {
    if (datos.getString("Rental place").equals(nombre)) {
      cont=cont+parseFloat(datos.getString("Minutos"));
    }
  }
  return cont;
}

enum View {
  START, MAP, GRAPHIC;
}
