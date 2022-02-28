public class Satelite {
  private PShape sphere;
  private PImage image;
  private float angTranslation;
  private float angRotation;
  
  Satelite(String imageURL, float size) {
    this.image = loadImage(imageURL);
    beginShape();
    sphere = createShape(SPHERE, size);
    sphere.setStroke(255); //elimina visualización de aristas
    sphere.setTexture(image); 
    endShape(CLOSE);

    this.angTranslation = 0;
    this.angRotation = 0;
  }
  
  public void showSatelite() {
      //movimiento de traslación de la luna
      rotateY(radians(angM1));
      translate(40, 0, 0);
      //movimiento de rotación de la luna
      rotateY(radians(movRot));
      shape(M1);
  }
  
  public void setAngTranslation(float angTranslation) {
    this.angTranslation = angTranslation;
  }
  
  public void setAngRotation(float angRotation) {
    this.angRotation = angRotation;
  }
  
  public float getAngTranslation() {
    return angTranslation;
  }
  
    public float setAngRotation() {
    return setAngRotation;
  }
}
