class Juego {
  int estado = 0;
  int dinero = 300;
  int vidas = 5;
  int torreSeleccionada = 1;

  ArrayList<Enemigo> enemigos;
  ArrayList<Torre> torres;
  ArrayList<Proyectil> proyectiles;

  Mapa mapa;
  Menu menu;
  Oleada oleada;
  Interfaz interfaz;

  Torre torreElegida = null;

  Juego() {
    enemigos = new ArrayList<Enemigo>();
    torres = new ArrayList<Torre>();
    proyectiles = new ArrayList<Proyectil>();

    mapa = new Mapa();
    menu = new Menu(this);
    oleada = new Oleada(this);
    interfaz = new Interfaz(this);
  }

  void comenzar() {
    dinero = 300;
    vidas = 5;
    torreSeleccionada = 1;

    enemigos.clear();
    torres.clear();
    proyectiles.clear();

    torreElegida = null;

    oleada.reiniciar();
    oleada.iniciarOleada();

    estado = 1;
  }

  void actualizar() {
    if (estado != 1) return;

    oleada.actualizar();

    for (int i = enemigos.size() - 1; i >= 0; i--) {
      Enemigo e = enemigos.get(i);

      boolean llego = e.actualizar();

      if (llego) {
        vidas--;
        enemigos.remove(i);
      }
      else if (!e.vivo) {
        dinero += e.recompensa;
        enemigos.remove(i);
      }
    }

    for (int i = 0; i < torres.size(); i++) {
      torres.get(i).actualizar();
    }

    for (int i = proyectiles.size() - 1; i >= 0; i--) {
      Proyectil p = proyectiles.get(i);

      p.actualizar();

      if (!p.activo) {
        proyectiles.remove(i);
      }
    }

    if (vidas <= 0) {
      estado = 5;
    }
  }

  void dibujar() {
    if (estado == 0) {
      menu.dibujar();
    }
    else if (estado == 1 || estado == 3) {
      mapa.dibujar();

      for (Torre t : torres) {
        t.dibujar();
      }

      for (Enemigo e : enemigos) {
        e.dibujar();
      }

      for (Proyectil p : proyectiles) {
        p.dibujar();
      }

      dibujarPrevisualizacion();
      interfaz.dibujar();

      if (estado == 3) {
        interfaz.dibujarPausa();
      }
    }
    else if (estado == 4) {
      interfaz.dibujarVictoria();
    }
    else if (estado == 5) {
      interfaz.dibujarDerrota();
    }
  }

  void mousePressed() {
    if (estado == 0) {
      menu.mousePressed();
    }

    else if (estado == 1) {
      torreElegida = null;

      // Buscar si se hizo click sobre una torre
      for (Torre t : torres) {
        if (dist(mouseX, mouseY, t.posicion.x, t.posicion.y) < 25) {
          torreElegida = t;
          return;
        }
      }

      // Colocar torre
      if (posicionValida(mouseX, mouseY)) {
        int costo = 100;

        if (torreSeleccionada == 2) {
          costo = 150;
        }

        if (dinero >= costo) {
          torres.add(new Torre(
            mouseX,
            mouseY,
            torreSeleccionada,
            this
          ));

          dinero -= costo;
        }
      }
    }

    else if (estado == 3) {
      if (mouseX > 385 && mouseX < 615 &&
          mouseY > 300 && mouseY < 350) {
        estado = 1;
      }

      else if (mouseX > 385 && mouseX < 615 &&
               mouseY > 370 && mouseY < 420) {
        estado = 0;
        menu.pantalla = 0;
      }
    }

    else if (estado == 4 || estado == 5) {
      comenzar();
    }
  }

  void keyPressed(char tecla) {

    if (estado == 1) {

      // Seleccionar antivirus
      if (tecla == '1') {
        torreSeleccionada = 1;
        torreElegida = null;
      }

      // Seleccionar firewall
      if (tecla == '2') {
        torreSeleccionada = 2;
        torreElegida = null;
      }

      // Mejorar torre
      if (tecla == 'u' || tecla == 'U') {
        if (torreElegida != null) {
          torreElegida.mejorar();
        }
      }

      // Eliminar torre
      if (tecla == 'd' || tecla == 'D') {
        if (torreElegida != null) {
          torres.remove(torreElegida);
          torreElegida = null;
        }
      }

      // Pausar juego
      if (tecla == 'p' || tecla == 'P') {
        estado = 3;
      }
    }

    // Reanudar juego
    else if (estado == 3) {
      if (tecla == 'p' || tecla == 'P') {
        estado = 1;
      }
    }
  }

  void dibujarPrevisualizacion() {
    if (estado != 1 || torreElegida != null) return;

    float alcance = 150;

    if (torreSeleccionada == 2) {
      alcance = 110;
    }

    noFill();
    stroke(255, 255, 255, 80);
    ellipse(mouseX, mouseY, alcance * 2, alcance * 2);

    if (posicionValida(mouseX, mouseY)) {
      fill(0, 255, 100, 100);
    } else {
      fill(255, 0, 0, 100);
    }

    noStroke();
    rectMode(CENTER);
    rect(mouseX, mouseY, 30, 30);
    rectMode(CORNER);
  }

  boolean posicionValida(float x, float y) {
    if (x < 25 || x > width - 25 ||
        y < 25 || y > height - 25) {
      return false;
    }

    PVector posicion = new PVector(x, y);

    // Evitar poner torres en el camino
    for (int i = 0; i < mapa.nodos.size() - 1; i++) {
      PVector a = mapa.nodos.get(i);
      PVector b = mapa.nodos.get(i + 1);

      if (distanciaAsegmento(posicion, a, b) < 48) {
        return false;
      }
    }

    // Evitar poner torres cerca
    for (Torre t : torres) {
      if (dist(x, y, t.posicion.x, t.posicion.y) < 70) {
        return false;
      }
    }

    return true;
  }

  float distanciaAsegmento(PVector p, PVector a, PVector b) {
    PVector ab = PVector.sub(b, a);
    PVector ap = PVector.sub(p, a);

    float largo = ab.magSq();

    if (largo == 0) {
      return PVector.dist(p, a);
    }

    float proyeccion = ap.dot(ab) / largo;
    proyeccion = constrain(proyeccion, 0, 1);

    PVector punto = PVector.add(
      a,
      PVector.mult(ab, proyeccion)
    );

    return PVector.dist(p, punto);
  }
}
