// ======================================================
// CLASE ENEMIGO
// ======================================================

class Enemigo {

  PVector posicion;

  String tipo;

  float velocidad;

  int vida;
  int vidaMaxima;

  int nodoActual = 0;

  boolean vivo = true;
  boolean llegoAlFinal = false;


  // ====================================================
  // CONSTRUCTOR
  // ====================================================

  Enemigo(String tipo) {

    this.tipo = tipo;

    posicion = nodos.get(0).copy();


    // ----------------------
    // VIRUS
    // ----------------------

    if (tipo.equals("virus")) {

      velocidad = 1.8;

      vida = 100;

      vidaMaxima = 100;
    }


    // ----------------------
    // MALWARE
    // ----------------------

    if (tipo.equals("malware")) {

      velocidad = 1.1;

      vida = 180;

      vidaMaxima = 180;
    }
  }


  // ====================================================
  // ACTUALIZAR
  // ====================================================

  void actualizar() {

    if (!vivo ||
      llegoAlFinal) {

      return;
    }


    // ----------------------
    // MOVIMIENTO POR NODOS
    // ----------------------

    if (nodoActual < nodos.size() - 1) {

      PVector objetivo =
        nodos.get(nodoActual + 1);


      PVector direccion =
        PVector.sub(
        objetivo,
        posicion
        );


      float distancia =
        direccion.mag();


      if (distancia <= velocidad) {

        posicion = objetivo.copy();

        nodoActual++;

      } else {

        direccion.normalize();

        direccion.mult(velocidad);

        posicion.add(direccion);
      }

    } else {

      llegoAlFinal = true;
    }


    // ----------------------
    // MUERTE
    // ----------------------

    if (vida <= 0) {

      vivo = false;


      if (tipo.equals("virus")) {

        dinero += 50;

      } else {

        dinero += 80;
      }
    }
  }


  // ====================================================
  // DIBUJAR
  // ====================================================

  void dibujar() {

    if (!vivo) {
      return;
    }


    // ----------------------
    // VIRUS = ROJO
    // ----------------------

    if (tipo.equals("virus")) {

      fill(255, 0, 0);

      ellipse(
        posicion.x,
        posicion.y,
        30,
        30
        );
    }


    // ----------------------
    // MALWARE = NARANJA
    // ----------------------

    if (tipo.equals("malware")) {

      fill(255, 120, 0);

      ellipse(
        posicion.x,
        posicion.y,
        38,
        38
        );
    }


    // ----------------------
    // BARRA DE VIDA
    // ----------------------

    fill(255, 0, 0);

    rect(
      posicion.x - 20,
      posicion.y - 28,
      40,
      5
      );


    fill(0, 255, 0);

    float anchoVida =
      map(
      vida,
      0,
      vidaMaxima,
      0,
      40
      );


    rect(
      posicion.x - 20,
      posicion.y - 28,
      anchoVida,
      5
      );
  }
}
