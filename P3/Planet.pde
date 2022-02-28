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
    this.satelites = new ArrayList<Satelite>();
  }

  public void showPlanet(float posX, float posY, float posZ, float velocTranslation, float velocRotation, boolean showSat) {
    pushMatrix();
    //movimiento de traslación
    rotateY(radians(angTranslation));
    translate(posX, posY, posZ);
    //movimiento de rotación
    rotateY(radians(angRotation));
    shape(sphere);
    //muestra los satélites
    if(showSat) {
    for(int i = 0; i<satelites.size(); i++)
      satelites.get(i).showSatelite();
    }
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
  
  public void addSatelite(Satelite s) {
    satelites.add(s);
  }
}
