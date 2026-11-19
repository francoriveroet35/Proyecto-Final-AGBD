class Enemigo {

  PVector posicion;

  int waypointActual = 0;
  int recompensa;
  float velocidad;
  float vida;
  float vidaMaxima;
  
  String tipo;

  boolean vivo = true;

  Mapa mapa;

  Enemigo(String tipo, int nivel, Mapa mapa) {

    this.tipo = tipo;
    this.mapa = mapa;

    posicion = mapa.nodos.get(0).copy();

    if (tipo.equals("Virus")) {

      velocidad = min(1.8 + (nivel - 1) * 0.06, 3.0);
      vida = 180 + (nivel - 1) * 12;
      recompensa = 50;

    } else if (tipo.equals("Malware")) {

      velocidad = min(1.1 + (nivel - 1) * 0.04, 2.2);
      vida = 240 + (nivel - 1) * 20;
      recompensa = 80;

    } else {

      velocidad = min(1.3 + (nivel - 1) * 0.04, 2.0);
      vida = 300 + (nivel - 1) * 25;
      recompensa = 110;
    }

    vidaMaxima = vida;
  }

  boolean actualizar() {

    if (!vivo) {
      return false;
    }

    if (waypointActual >= mapa.nodos.size()) {
      return true;
    }

    PVector objetivo = mapa.nodos.get(waypointActual);

    PVector direccion = PVector.sub(objetivo, posicion);

    float distancia = direccion.mag();

    if (distancia <= velocidad) {

      posicion = objetivo.copy();
      waypointActual++;

      if (waypointActual >= mapa.nodos.size()) {
        return true;
      }

    } else {

      direccion.normalize();
      direccion.mult(velocidad);
      posicion.add(direccion);
    }

    return false;
  }

  void recibirDanio(float cantidad) {

    vida -= cantidad;

    if (vida <= 0) {
      vivo = false;
    }
  }

  void dibujar() {

    if (!vivo) {
      return;
    }

    noStroke();

    if (tipo.equals("Virus")) {

      fill(255, 60, 60);
      ellipse(posicion.x, posicion.y, 25, 25);

    } else if (tipo.equals("Malware")) {

      fill(255, 150, 0);
      rectMode(CENTER);
      rect(posicion.x, posicion.y, 25, 25);
      rectMode(CORNER);

    } else {

      fill(255, 230, 0);
      ellipse(posicion.x, posicion.y, 32, 32);
    }

    // Barra de vida

    fill(70);
    rect(posicion.x - 15, posicion.y - 22, 30, 5);

    fill(0, 255, 100);

    float ancho = map(vida, 0, vidaMaxima, 0, 30);

    rect(posicion.x - 15, posicion.y - 22, ancho, 5);
  }
}
