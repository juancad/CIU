public class Satelite {
  private PShape sphere;
  private PImage image;
  private float angTranslation;
  private float angRotation;
  private float distance;
  private float velocTranslation;
  private float velocRotation;

  Satelite(String imageURL, float size, float distance, float velocTranslation, float velocRotation) {
    this.image = loadImage(imageURL);
    beginShape();
    sphere = createShape(SPHERE, size);
    sphere.setStroke(255); //elimina visualización de aristas
    sphere.setTexture(image); 
    endShape(CLOSE);

    this.angTranslation = 0;
    this.angRotation = 0;
    this.distance = distance;
    this.velocTranslation = velocTranslation;
    this.velocRotation = velocRotation;
  }

  public void showSatelite() {
    pushMatrix();
    //movimiento de traslación del satélite
    rotateY(radians(angTranslation));
    translate(40, 0, 0);
    //movimiento de rotación del satélite
    rotateY(radians(angRotation));
    shape(sphere);

    //aumenta la traslación
    if (angTranslation>360)
      angTranslation = 0;
    else
      angTranslation = angTranslation+velocTranslation;

    //aumenta la rotación
    if (angRotation>360)
      angRotation = 0;
    else
      angRotation = angRotation+velocRotation;
  popMatrix();
  }
}
