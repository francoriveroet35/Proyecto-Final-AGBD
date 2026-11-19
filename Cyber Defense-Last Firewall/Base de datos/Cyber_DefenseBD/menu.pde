class Menu {
  Juego juego;

int pantalla=0;

  Menu(Juego juego) {
    this.juego = juego;
  }

  void dibujar() {
    background(10, 15, 30);

    fill(0, 200, 255);
    textAlign(CENTER);
    textSize(38);
    text("CYBER DEFENSE", width/2, 100);

    fill(255);
    textSize(22);
    text("LAST FIREWALL", width/2, 135);

    if (juego.estado == 0) {

      // Datos
      fill(190, 200, 215);
      textSize(14);
      text("Cyber Defense - Last Firewall fue un juego creado", width/2, 190);
      text("individualmente por Franco Rivero para las materias de", width/2, 212);
      text("Proyecto Informático II y Programación Orientada a Objetos", width/2, 234);
      text("de la Escuela Técnica N°35 \"Ingeniero Eduardo Latzina\".", width/2, 256);
      text("Gracias por jugar.", width/2, 278);

      dibujarBoton("JUGAR", 340);
      dibujarBoton("INSTRUCCIONES", 410);

    } else {

      fill(255);
      textSize(18);
      text("Protege el nucleo de datos.", width/2, 200);
      text("1 - Seleccionar Antivirus", width/2, 260);
      text("2 - Seleccionar Firewall", width/2, 295);
      text("Clic - Colocar o seleccionar torre", width/2, 330);
      text("U - Mejorar torre seleccionada", width/2, 365);
      text("P - Pausar el juego", width/2, 400);
      text("M - Activar o desactivar musica", width/2, 435);

      dibujarBoton("VOLVER", 530);
    }

    textAlign(LEFT);
  }

  void dibujarBoton(String nombre, int y) {
    rectMode(CENTER);
    fill(0, 120, 200);
    rect(width/2, y, 220, 50, 10);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(nombre, width/2, y);

    rectMode(CORNER);
  }

  void mousePressed() {
    if (juego.estado == 0) {
      if (mouseX > 390 && mouseX < 610 && mouseY > 315 && mouseY < 365) {
        juego.comenzar();
      }

      if (mouseX > 390 && mouseX < 610 && mouseY > 385 && mouseY < 435) {
        juego.estado = 2;
      }

    } else if (juego.estado == 2) {
      if (mouseX > 390 && mouseX < 610 && mouseY > 505 && mouseY < 555) {
        juego.estado = 0;
      }
    }
  }
}
