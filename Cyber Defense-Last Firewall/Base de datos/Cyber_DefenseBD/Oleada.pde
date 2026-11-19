class Oleada {

  Juego juego;

  int numero = 1;

  int cantidadEnemigos = 5;
  int enemigosGenerados = 0;

  int contador = 0;
  int intervalo = 100;

  int tiempoEntreOleadas = 0;

  boolean activa = false;

  Oleada(Juego juego) {
    this.juego = juego;
  }

  void reiniciar() {

    numero = 1;

    cantidadEnemigos = 5;
    enemigosGenerados = 0;

    contador = 0;
    intervalo = 100;

    tiempoEntreOleadas = 0;

    activa = false;
  }

  void iniciarOleada() {

    enemigosGenerados = 0;
    contador = 0;

    cantidadEnemigos = 5 + (numero - 1) * 2;

    intervalo = max(45, 100 - (numero - 1) * 5);

    activa = true;
  }

  void actualizar() {

    if (activa) {

      contador++;

      if (contador >= intervalo &&
          enemigosGenerados < cantidadEnemigos) {

        crearEnemigo();

        enemigosGenerados++;
        contador = 0;
      }

      if (enemigosGenerados >= cantidadEnemigos &&
          juego.enemigos.size() == 0) {

        activa = false;

        if (numero >= 5) {

          juego.estado = 4;

        } else {

          tiempoEntreOleadas = 120;
        }
      }

    } else if (tiempoEntreOleadas > 0) {

      tiempoEntreOleadas--;

      if (tiempoEntreOleadas == 0) {

        numero++;
        iniciarOleada();
      }
    }
  }

  void crearEnemigo() {

    String tipo;

    if (enemigosGenerados % 5 == 4) {

      tipo = "Troyano";

    } else if (enemigosGenerados % 3 == 2) {

      tipo = "Malware";

    } else {

      tipo = "Virus";
    }

    juego.enemigos.add(
      new Enemigo(tipo, numero, juego.mapa)
    );
  }
}
