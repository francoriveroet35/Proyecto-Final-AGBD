// ======================================================
// OLEADAS
// ======================================================

void controlarOleadas() {

  // ----------------------
  // GENERAR ENEMIGOS
  // ----------------------

  if (enemigosGenerados < enemigosPorOleada) {

    contadorSpawn++;

    if (contadorSpawn >= tiempoEntreEnemigos) {

      crearEnemigo();

      enemigosGenerados++;

      contadorSpawn = 0;
    }

  } else {

    // ----------------------
    // ESPERAR A QUE MUERAN
    // ----------------------

    if (enemigos.size() == 0) {

      // ----------------------
      // VICTORIA
      // ----------------------

      if (oleada >= 5) {

        juegoTerminado = true;

        victoria = true;

      } else {

        // ----------------------
        // NUEVA OLEADA
        // ----------------------

        oleada++;

        enemigosPorOleada += 2;

        enemigosGenerados = 0;

        contadorSpawn = -180;
      }
    }
  }
}


// ======================================================
// CREAR ENEMIGO
// ======================================================

void crearEnemigo() {

  // Cada tercer enemigo será Malware

  if (enemigosGenerados % 3 == 0) {

    enemigos.add(
      new Enemigo("malware")
      );

  } else {

    enemigos.add(
      new Enemigo("virus")
      );
  }
}
