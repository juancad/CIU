public class Ubicacion {
  private int id;
  private String nombre;
  private float latitud;
  private float longitud;
  private int veces;
  private float minutos;

  Ubicacion() {
    id = 0;
    latitud = 0;
    longitud = 0;
    nombre="";
    veces = 0;
    minutos = 0;
  }

  Ubicacion(int id, String nombre, float latitud, float longitud, int veces, float minutos) {
    this.id = id;
    this.latitud = latitud;
    this.longitud = longitud;
    this.nombre=nombre;
    this.veces = veces;
    this.minutos = minutos;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public float getLongitud() {
    return longitud;
  }

  public void setLongitud(float longitud) {
    this.longitud = longitud;
  }

  public float getLatitud() {
    return latitud;
  }

  public void setLatitud(float latitud) {
    this.latitud = latitud;
  }
  
  public int getVeces() {
    return veces;
  }

  public void setVeces(int veces) {
    this.veces = veces;
  }
  
  public float getMinutos() {
    return minutos;
  }

  public void setMinutos(float minutos) {
    this.minutos = minutos;
  }
}
