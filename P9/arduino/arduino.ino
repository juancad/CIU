void setup() {
  pinMode(A0, INPUT);
  Serial.begin(9600);
}

void loop() {
  int valor = analogRead(A0);
  Serial.print(valor);
  Serial.println();
  delay(50);
}
