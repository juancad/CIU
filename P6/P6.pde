import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.imgproc.Imgproc;

Capture cam;
CVImage img, img2, img3, img4;
boolean invertImg=false, help=false;
int imgMode = 0, scale = 1;

void setup() {
  size(1280, 720);
  textFont(createFont("Helvetica", 18));
  noStroke();
  //Cámara
  cam = new Capture(this, width/2, height/2);

  cam.start();

  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);

  img = new CVImage(cam.width, cam.height);
  img2 = new CVImage(cam.width, cam.height);
  img3 = new CVImage(cam.width, cam.height);
  img4 = new CVImage(cam.width, cam.height);
}

void draw() {
  if (cam.available()) {
    cam.read();

    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 
      0, 0, img.width, img.height);
    img.copyTo();
    img2.copy(cam, 0, 0, cam.width, cam.height, 
      0, 0, img.width, img.height);
    img2.copyTo();
    img3.copy(cam, 0, 0, cam.width, cam.height, 
      0, 0, img.width, img.height);
    img3.copyTo();
    img4.copy(cam, 0, 0, cam.width, cam.height, 
      0, 0, img.width, img.height);
    img4.copyTo();

    Mat gris = img.getGrey();

    //Visualiza las imágenes
    if (!invertImg) {
      pushMatrix();
      tint(256, 256, 256);
      switch (imgMode) {
      case 1:
        //Copia de Mat a CVImage
        cpMat2CVImage(gris, img);
        break;
      case 2:
        //Umbraliza con umbral definido por la posición del ratón
        Imgproc.threshold(gris, gris, 255*mouseX/width, 255, Imgproc.THRESH_BINARY);
        cpMat2CVImage(gris, img);
        break;
      case 3:
        //Gradiente
        int ddepth = CvType.CV_16S;
        Mat grad_x = new Mat();
        Mat grad_y = new Mat();
        Mat abs_grad_x = new Mat();
        Mat abs_grad_y = new Mat();

        // Gradiente X
        Imgproc.Sobel(gris, grad_x, ddepth, 1, 0);
        Core.convertScaleAbs(grad_x, abs_grad_x);

        // Gradiente Y
        Imgproc.Sobel(gris, grad_y, ddepth, 0, 1);
        Core.convertScaleAbs(grad_y, abs_grad_y);

        // Gradiente total aproximado
        Core.addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, gris);

        //Copia de Mat a CVImage
        cpMat2CVImage(gris, img);
      case 4:
        img.filter(INVERT);
        break;
      case 5:
        img.filter(BLUR, mouseX/200);
        break;
      }
      scale(-scale, scale);
      image(img, -width/2, 0);
      tint(256, 0, 0);
      image(img2, -width, 0);
      tint(0, 256, 0);
      image(img3, -width/2, height/2);
      tint(0, 0, 256);
      image(img4, -width, height/2);

      popMatrix();

      if (imgMode == 2) {
        //printea el nivel de umbral
        showBar("Nivel de umbral");
      }
      if (imgMode == 5) {
        //printea el nivel de blur
        showBar("Nivel de blur:");
      }
    } else {
      pushMatrix();
      tint(256, 256, 256);
      //modo blanco y negro
      switch (imgMode) {
      case 1:
        //Copia de Mat a CVImage
        cpMat2CVImage(gris, img);
        break;
      case 2:
        //Umbraliza con umbral definido por la posición del ratón
        Imgproc.threshold(gris, gris, 255*mouseX/width, 255, Imgproc.THRESH_BINARY);
        cpMat2CVImage(gris, img);
        break;
      case 3:
        //Gradiente
        int ddepth = CvType.CV_16S;
        Mat grad_x = new Mat();
        Mat grad_y = new Mat();
        Mat abs_grad_x = new Mat();
        Mat abs_grad_y = new Mat();

        // Gradiente X
        Imgproc.Sobel(gris, grad_x, ddepth, 1, 0);
        Core.convertScaleAbs(grad_x, abs_grad_x);

        // Gradiente Y
        Imgproc.Sobel(gris, grad_y, ddepth, 0, 1);
        Core.convertScaleAbs(grad_y, abs_grad_y);

        // Gradiente total aproximado
        Core.addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, gris);

        //Copia de Mat a CVImage
        cpMat2CVImage(gris, img);
      case 4:
        img.filter(INVERT);
        break;
      case 5:
        img.filter(BLUR, mouseX/200);
        break;
      }
      scale(scale, scale);
      image(img, 0, 0);
      tint(256, 0, 0);
      image(img2, width/2, 0);
      tint(0, 256, 0);
      image(img3, 0, height/2);
      tint(0, 0, 256);
      image(img4, width/2, height/2);
      gris.release();

      popMatrix();

      if (imgMode == 2) {
        //printea el nivel de umbral
        showBar("Nivel de umbral");
      }
      if (imgMode == 5) {
        //printea el nivel de blur
        showBar("Nivel de blur:");
      }
    }
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
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    invertImg=!invertImg;
  } else if (mouseButton == RIGHT) {
    imgMode++;
  }
  if (imgMode>5)
    imgMode=0;
}

//Copia unsigned byte Mat a color CVImage
void  cpMat2CVImage(Mat in_mat, CVImage out_img)
{    
  byte[] data8 = new byte[cam.width*cam.height];

  out_img.loadPixels();
  in_mat.get(0, 0, data8);

  // Cada columna
  for (int x = 0; x < cam.width; x++) {
    // Cada fila
    for (int y = 0; y < cam.height; y++) {
      // Posición en el vector 1D
      int loc = x + y * cam.width;
      //Conversión del valor a unsigned
      int val = data8[loc] & 0xFF;
      //Copia a CVImage
      out_img.pixels[loc] = color(val);
    }
  }
  out_img.updatePixels();
}

void keyPressed() {
  if (keyCode == 'H' || keyCode == 'h') 
    help=!help;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e>0)
    scale=1;
  else
    scale=2;
}

void showBar(String s) {
  fill(0);
  rect(0, 0, width/2, 30);
  fill(255);
  textSize(14);
  text(s, 10, 20);
  stroke(255);
  strokeWeight(2);
  line(130, 15, mouseX/2.6+130, 14);
  noStroke();
}
