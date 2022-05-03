uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

//Posición de la fuente de luz
uniform vec4 lightPosition;

//Particulares de cada vértice
attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;

//Valor pasado al shader de fragmentos
varying vec4 vertColor;

//uniform vec2 u_resolution;
uniform float u_time;

void main() {
  //Porisión del vértice tras transformar y proyectar
  gl_Position = transform * position;

  //Posición del vértice en coordenadas del ojo
  vec3 ecPosition = vec3(modelview * position);
  //Normal del vértice en coordenadas del ojo
  vec3 ecNormal = normalize(normalMatrix * normal);
  //Vector hacia la luz normalizado
  vec3 direction = normalize(lightPosition.xyz - ecPosition);
  //Producto escalar normal por verctor hacia la luz
  float intensity = max(0.0, dot(direction, ecNormal));
  //Establece el color del vértice
  vertColor = vec4(intensity*gl_Position.x/300,intensity*gl_Position.y/300,intensity*abs(sin(u_time)),0.6) * color;
}
