float freqMax = 500;
float freqMin = 100;


void setup() {
  pinMode(LED_BUILTIN, OUTPUT);

}

void loop() {
  float tiempo = millis() / 1000;
  
  float freq = ((sin(tiempo/2) + 1) / 2) * (freqMax - freqMin) + freqMin;
  
  digitalWrite(LED_BUILTIN, HIGH);   
  delay(freq/2);                       
  digitalWrite(LED_BUILTIN, LOW);    
  delay(freq/2);    


}
