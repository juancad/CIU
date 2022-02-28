public class Planet {
  private PShape sphere;
  private PImage image;
  private float angTranslation;
  private float angRotation;

  private ArrayList<Satelite> satelites;

  Planet(String imageURL, float size) {
    this.image = loadImage(imageURL);
    beginShape();
    sphere = createShape(SPHERE, size);
    sphere.setStroke(255); //elimina visualización de aristas
    sphere.setTexture(image); 
    endShape(CLOSE);

    this.angTranslation = 0;
    this.angRotation = 0;
  }

  public void showPlanet(float posX, float posY, float posZ, float velocTranslation, float velocRotation) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angTranslation));
    translate(posX, posY, posZ);
    //movimiento de rotación
    rotateY(radians(angRotation));
    shape(sphere);
    popMatrix();

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
  }
}
