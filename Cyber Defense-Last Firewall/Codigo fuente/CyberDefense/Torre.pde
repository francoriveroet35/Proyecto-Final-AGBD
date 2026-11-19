// ======================================================
// CLASE TORRE
// ======================================================

class Torre {

  PVector posicion;

  String tipo;

  float rango;

  float daño;

  int costo;

  int tiempoDisparo;

  int cooldown;


  // ====================================================
  // CONSTRUCTOR
  // ====================================================

  Torre(
    float x,
    float y,
    String tipo) {

    posicion =
      new PVector(x, y);

    this.tipo = tipo;


    // ----------------------
    // ANTIVIRUS
    // ----------------------

    if (tipo.equals("antivirus")) {

      rango = 150;

      daño = 25;

      cooldown = 45;

      costo = 100;
    }


    // ----------------------
    // FIREWALL
    // ----------------------

    if (tipo.equals("firewall")) {

      rango = 110;

      daño = 50;

      cooldown = 80;

      costo = 150;
    }
  }


  // ====================================================
  // ACTUALIZAR
  // ====================================================

  void actualizar() {

    if (tiempoDisparo > 0) {

      tiempoDisparo--;
    }


    Enemigo objetivo =
      encontrarObjetivo();


    if (objetivo != null) {

      if (tiempoDisparo <= 0) {

        proyectiles.add(
          new Proyectil(
          posicion.copy(),
          objetivo,
          daño,
          tipo
          )
          );

        tiempoDisparo = cooldown;
      }
    }
  }


  // ====================================================
  // BUSCAR OBJETIVO
  // ====================================================

  Enemigo encontrarObjetivo() {

    Enemigo objetivo = null;

    float distanciaMasCercana =
      rango;


    for (Enemigo enemigo : enemigos) {

      if (!enemigo.vivo) {
        continue;
      }


      // DIST() = DISTANCIA MATEMÁTICA

      float distancia =
        dist(
        posicion.x,
        posicion.y,
        enemigo.posicion.x,
        enemigo.posicion.y
        );


      if (distancia <=
        distanciaMasCercana) {

        distanciaMasCercana =
          distancia;

        objetivo = enemigo;
      }
    }

    return objetivo;
  }


  // ====================================================
  // DIBUJAR
  // ====================================================

  void dibujar() {

    // ----------------------
    // RADIO
    // ----------------------

    noFill();

    stroke(50, 100, 255);

    ellipse(
      posicion.x,
      posicion.y,
      rango * 2,
      rango * 2
      );


    rectMode(CENTER);


    // ----------------------
    // ANTIVIRUS = AZUL
    // ----------------------

    if (tipo.equals("antivirus")) {

      fill(0, 100, 255);
    }


    // ----------------------
    // FIREWALL = CELESTE
    // ----------------------

    if (tipo.equals("firewall")) {

      fill(0, 200, 255);
    }


    noStroke();

    rect(
      posicion.x,
      posicion.y,
      35,
      35
      );


    rectMode(CORNER);
  }
}
