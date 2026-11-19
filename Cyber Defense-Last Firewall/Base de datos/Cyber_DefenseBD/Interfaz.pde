class Interfaz {
  Juego juego;

  Interfaz(Juego juego) {
    this.juego = juego;
  }

  void dibujar() {
    fill(255);
    textSize(18);
    textAlign(LEFT);

    // Información
    text("Dinero: $" + juego.dinero, 20, 30);
    text("Vidas: " + juego.vidas, 20, 60);
    text("Oleada: " + juego.oleada.numero, 20, 90);

    // Controles
    textSize(14);
    text("CONTROLES", 20, 500);
    text("1: Seleccionar Antivirus ($100)", 20, 540);
    text("2: Seleccionar Firewall   ($200)", 20, 560);
    text("Click en torre: Seleccionar torre", 20, 580);
    text("D: Eliminar torre seleccionada", 20, 600);
    text("U: Mejorar torre seleccionada", 20, 620);
    text("P: Pausar | M: Musica", 20, 640);

    // Informacion de la torre seleccionada
    if (juego.torreElegida != null) {
      fill(255, 230, 0);
      textSize(16);

      text(
        "Torre seleccionada: LEVEL " + juego.torreElegida.nivel,
        350, 565
      );

      if (juego.torreElegida.nivel < 3) {
        text(
          "Costo de mejora: $" + (juego.torreElegida.nivel * 100), 350, 590);
      
    } else {
        text("Nivel maximo alcanzado", 350, 590);
      }

      // Opcion para eliminar torre
      fill(255, 80, 80);
      text("[D] ELIMINAR TORRE", 350, 615);
    }

    textAlign(LEFT);
  }

  // Pantalla de pausa
  void dibujarPausa() {
    fill(0, 0, 0, 190);
    noStroke();
    rect(0, 0, width, height);

    fill(255);
    textAlign(CENTER);
    textSize(38);
    text("JUEGO PAUSADO", width/2, 230);

    dibujarBoton("CONTINUAR", 325);
    dibujarBoton("MENU PRINCIPAL", 395);

    textAlign(LEFT);
  }

  // Pantalla de victoria
  void dibujarVictoria() {
    background(10, 30, 25);

    fill(0, 255, 150);
    textAlign(CENTER);
    textSize(42);
    text("¡VICTORIA!", width/2, 250);

    fill(255);
    textSize(20);
    text("Protegiste el nucleo de datos.", width/2, 300);

    dibujarBoton("JUGAR NUEVAMENTE", 390);

    textAlign(LEFT);
  }

  // Pantalla de derrota
  void dibujarDerrota() {
    background(35, 10, 15);

    fill(255, 60, 60);
    textAlign(CENTER);
    textSize(42);
    text("DERROTA", width/2, 250);

    fill(255);
    textSize(20);
    text("El nucleo de datos fue comprometido.", width/2, 300);

    dibujarBoton("VOLVER A INTENTAR", 390);

    textAlign(LEFT);
  }

  // Dibujar botones
  void dibujarBoton(String nombre, int y) {
    rectMode(CENTER);

    fill(0, 120, 200);
    rect(width/2, y, 230, 50, 10);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(17);
    text(nombre, width/2, y);

    rectMode(CORNER);
  }
}
