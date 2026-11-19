class Proyectil {

  PVector posicion;
  float velocidad = 5;
  float danio;
  int tipo;
  boolean activo = true;
  Enemigo objetivo;

  Proyectil(float x, float y, Enemigo objetivo,
            float danio, int tipo) {

    posicion = new PVector(x, y);

    this.objetivo = objetivo;
    this.danio = danio;
    this.tipo = tipo;
  }

  void actualizar() {

    if (objetivo == null || !objetivo.vivo) {
      activo = false;
      return;
    }

    PVector direccion = PVector.sub(
      objetivo.posicion, posicion
    );

    float distancia = direccion.mag();

    if (distancia <= velocidad + 5) {

      objetivo.recibirDanio(danio);
      activo = false;

    } else {

      direccion.normalize();
      direccion.mult(velocidad);

      posicion.add(direccion);
    }
  }

  void dibujar() {

    if (!activo) {
      return;
    }

    noStroke();

    if (tipo == 1) {
      fill(255, 255, 0);
    } else {
      fill(255, 0, 255);
    }

    ellipse(posicion.x, posicion.y, 10, 10);
  }
}
