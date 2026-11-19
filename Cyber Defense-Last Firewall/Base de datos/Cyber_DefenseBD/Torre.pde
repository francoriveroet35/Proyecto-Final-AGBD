class Torre {
  PVector posicion;

  float alcance;
  float danio;

  int cooldown;
  int contador = 0;

  int costo;
  int tipo;
  int nivel = 1;

  Juego juego;

  Torre(float x, float y, int tipo, Juego juego) {
    posicion = new PVector(x, y);

    this.tipo = tipo;
    this.juego = juego;

    if (tipo == 1) {
      alcance = 150;
      danio = 25;
      cooldown = 45;
      costo = 100;
    } else {
      alcance = 110;
      danio = 50;
      cooldown = 80;
      costo = 150;
    }
  }

  void actualizar() {
    contador++;

    if (contador >= cooldown) {
      Enemigo objetivo = encontrarObjetivo();

      if (objetivo != null) {
        juego.proyectiles.add(new Proyectil(
          posicion.x,
          posicion.y,
          objetivo,
          danio,
          tipo
        ));

        contador = 0;
      }
    }
  }

  Enemigo encontrarObjetivo() {
    Enemigo mejorObjetivo = null;
    float menorDistancia = alcance;

    for (Enemigo e : juego.enemigos) {
      if (e.vivo) {
        float distancia = dist(
          posicion.x,
          posicion.y,
          e.posicion.x,
          e.posicion.y
        );

        if (distancia <= menorDistancia) {
          menorDistancia = distancia;
          mejorObjetivo = e;
        }
      }
    }

    return mejorObjetivo;
  }

  void mejorar() {
    if (nivel >= 3) return;

    int precio = nivel * 100;

    if (juego.dinero >= precio) {
      juego.dinero -= precio;

      nivel++;
      danio *= 1.5;
      alcance += 25;
      cooldown = max(20, cooldown - 5);

      contador = 0;
    }
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();

    if (tipo == 1) {
      fill(0, 150, 255);
    } else {
      fill(0, 255, 180);
    }

    rect(posicion.x, posicion.y, 30, 30);

    fill(255);
    textAlign(CENTER);
    textSize(11);
    text("NIVEL " + nivel, posicion.x, posicion.y - 23);

    // Barra de recarga
    float progreso = constrain((float)contador / cooldown, 0, 1);

    fill(40);
    rect(posicion.x, posicion.y + 25, 36, 7);

    if (progreso >= 1) {
      fill(0, 255, 100);
    } else {
      fill(255, 200, 0);
    }

    rectMode(CORNER);
    rect(
      posicion.x - 18,
      posicion.y + 21.5,
      36 * progreso,
      7
    );

    // Circulo de alcance
    if (juego.torreElegida == this) {
      noFill();
      stroke(255, 255, 0);
      strokeWeight(2);

      ellipse(
        posicion.x,
        posicion.y,
        alcance * 2,
        alcance * 2
      );
    }

    rectMode(CORNER);
    textAlign(LEFT);
    strokeWeight(1);
  }
}
