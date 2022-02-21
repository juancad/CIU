import gifAnimation.*;

PShape figure;
boolean view1=true;
ArrayList<Point> points = new ArrayList<Point>();
int zoom = 0;
//GifMaker filegif;

void setup() {
  size(800, 600, P3D);
  textFont(createFont("Consolas", 14));
  stroke(255, 255, 255);
  
  //filegif = new GifMaker(this, "animacion.gif");
  //filegif.setRepeat(0);
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
  line(width/2, 0, width/2, height);
  noFill();
  rect (10, 10, 320, 90);
  text("Controles: \n Click izquierdo: Añadir vértices. \n ENTER: Generar superficie revolución.\n BACKSPACE: Borrar dibujo.\n\n\nSolo se puede dibujar en la zona\nderecha de la ventana.", 20, 30);
  text("Autor: Juan Carlos Alcalde Díaz", 20, height-30);

  if (mousePressed && (mouseButton == LEFT)) {
    if (mouseX>width/2 && mouseX<width && mouseY>0 && mouseY<height) {
      points.add(new Point(mouseX, mouseY));
    }
  }

  //dibuja las líneas entre cada punto
  for (int i=0; i<points.size(); i++) {
    if (i>0) {
      line(points.get(i-1).getX(), points.get(i-1).getY(), points.get(i).getX(), points.get(i).getY());
    }
  }

  if (keyPressed == true && key == BACKSPACE) {
    points = new ArrayList<Point>();
  }
  
  if (keyPressed == true && key == ENTER) {
    view1 = false;
  }
  
  //filegif.setDelay(1000/60);
  //filegif.addFrame();
}

void graphicView() {
  rect (10, 10, 320, 110);
  text("Controles: \n Mover cursor: mueve la figura. \n +: Aumentar zoom\n -: Disminuir zoom.\n BACKSPACE: Volver a dibujar.", 20, 30);

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

  //control del zoom
  if (keyPressed && key == '+')
    zoom+=5;
  if (keyPressed && key == '-')
    zoom-=5;

  //la figura se moverá siguiendo el cursor
  translate(mouseX-width/2, mouseY-width/2, -1000 + zoom);
  
  //dibuja la figura
  shape(figure);

  //filegif.setDelay(1000/60);
  //filegif.addFrame();
  
  if (keyPressed == true && key == BACKSPACE) {
    view1 = true;
    points = new ArrayList<Point>();
    //filegif.finish();
  }
}

class Point {
  int x;
  int y;
  int z;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  int getX() {
    return this.x;
  }

  int getY() {
    return this.y;
  }
}
