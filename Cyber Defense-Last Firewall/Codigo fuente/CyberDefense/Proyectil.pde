// ======================================================
// CLASE PROYECTIL
// ======================================================

class Proyectil {

  PVector posicion;

  PVector velocidad;

  Enemigo objetivo;

  float rapidez = 5;

  float daño;

  String tipo;

  boolean terminado = false;


  // ====================================================
  // CONSTRUCTOR
  // ====================================================

  Proyectil(
    PVector posicionInicial,
    Enemigo objetivo,
    float daño,
    String tipo) {

    posicion =
      posicionInicial.copy();

    this.objetivo = objetivo;

    this.daño = daño;

    this.tipo = tipo;
  }


  // ====================================================
  // ACTUALIZAR
  // ====================================================

  void actualizar() {

    if (objetivo == null ||
      !objetivo.vivo) {

      terminado = true;

      return;
    }


    // ----------------------
    // VECTOR HACIA OBJETIVO
    // ----------------------

    PVector direccion =
      PVector.sub(
      objetivo.posicion,
      posicion
      );


    direccion.normalize();

    direccion.mult(rapidez);


    // ----------------------
    // ACTUALIZAR VELOCIDAD
    // ----------------------

    velocidad = direccion;


    // ----------------------
    // MOVER PROYECTIL
    // ----------------------

    posicion.add(velocidad);


    // ----------------------
    // COLISIÓN
    // ----------------------

    if (
      dist(
      posicion.x,
      posicion.y,
      objetivo.posicion.x,
      objetivo.posicion.y
      ) < 12
      ) {

      objetivo.vida -= daño;

      terminado = true;
    }
  }


  // ====================================================
  // DIBUJAR
  // ====================================================

  void dibujar() {

    // ----------------------
    // PROYECTIL ANTIVIRUS
    // ----------------------

    if (tipo.equals("antivirus")) {

      fill(255, 255, 0);
    }


    // ----------------------
    // PROYECTIL FIREWALL
    // ----------------------

    if (tipo.equals("firewall")) {

      fill(255, 0, 255);
    }


    noStroke();

    ellipse(
      posicion.x,
      posicion.y,
      10,
      10
      );
  }
}
