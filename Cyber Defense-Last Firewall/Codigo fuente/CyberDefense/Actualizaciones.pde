// ======================================================
// ACTUALIZAR ENEMIGOS
// ======================================================

void actualizarEnemigos() {

  for (int i = enemigos.size() - 1; i >= 0; i--) {

    Enemigo enemigo = enemigos.get(i);

    enemigo.actualizar();
    enemigo.dibujar();


    // ----------------------
    // LLEGÓ AL NÚCLEO
    // ----------------------

    if (enemigo.llegoAlFinal) {

      vidas--;

      enemigos.remove(i);


      if (vidas <= 0) {

        juegoTerminado = true;
        victoria = false;
      }

      continue;
    }


    // ----------------------
    // ENEMIGO ELIMINADO
    // ----------------------

    if (!enemigo.vivo) {

      enemigos.remove(i);
    }
  }
}


// ======================================================
// ACTUALIZAR TORRES
// ======================================================

void actualizarTorres() {

  for (Torre torre : torres) {

    torre.actualizar();
    torre.dibujar();
  }
}


// ======================================================
// ACTUALIZAR PROYECTILES
// ======================================================

void actualizarProyectiles() {

  for (int i = proyectiles.size() - 1; i >= 0; i--) {

    Proyectil proyectil = proyectiles.get(i);

    proyectil.actualizar();
    proyectil.dibujar();


    // ----------------------
    // PROYECTIL TERMINADO
    // ----------------------

    if (proyectil.terminado) {

      proyectiles.remove(i);
    }
  }
}
