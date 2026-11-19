Juego juego;

void setup() {
  size(1000, 650);
  juego = new Juego();
}

void draw() {
  juego.actualizar();
  juego.dibujar();
}

void mousePressed() {
  juego.mousePressed();
}

void keyPressed() {
  juego.keyPressed(key);
}
