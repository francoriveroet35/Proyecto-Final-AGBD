// ======================================================
// MOUSE
// ======================================================

void mousePressed() {

  if (juegoTerminado) {

    return;
  }


  // ====================================================
  // TORRE ANTIVIRUS
  // ====================================================

  if (!keyPressed &&
    dinero >= 100) {

    if (!estaSobreElCamino(mouseX, mouseY)) {

      torres.add(
        new Torre(
        mouseX,
        mouseY,
        "antivirus"
        )
        );

      dinero -= 100;
    }
  }


  // ====================================================
  // TORRE FIREWALL
  // ====================================================

  if (keyPressed &&
    keyCode == SHIFT &&
    dinero >= 150) {

    if (!estaSobreElCamino(mouseX, mouseY)) {

      torres.add(
        new Torre(
        mouseX,
        mouseY,
        "firewall"
        )
        );

      dinero -= 150;
    }
  }
}


// ======================================================
// COMPROBAR CAMINO
// ======================================================

boolean estaSobreElCamino(
  float x,
  float y) {

  for (int i = 0;
    i < nodos.size() - 1;
    i++) {

    PVector a = nodos.get(i);

    PVector b = nodos.get(i + 1);


    float distancia =
      distanciaPuntoLinea(
      x,
      y,
      a.x,
      a.y,
      b.x,
      b.y
      );


    if (distancia < 35) {

      return true;
    }
  }

  return false;
}


// ======================================================
// DISTANCIA PUNTO-LÍNEA
// ======================================================

float distanciaPuntoLinea(
  float px,
  float py,
  float x1,
  float y1,
  float x2,
  float y2) {

  float dx = x2 - x1;

  float dy = y2 - y1;


  if (dx == 0 &&
    dy == 0) {

    return dist(
      px,
      py,
      x1,
      y1
      );
  }


  float t =
    ((px - x1) * dx +
    (py - y1) * dy)
    /
    (dx * dx + dy * dy);


  t = constrain(t, 0, 1);


  float puntoX =
    x1 + t * dx;


  float puntoY =
    y1 + t * dy;


  return dist(
    px,
    py,
    puntoX,
    puntoY
    );
}


// ======================================================
// REINICIAR
// ======================================================

void keyPressed() {

  if (key == 'r' ||
    key == 'R') {

    dinero = 300;

    vidas = 10;

    oleada = 1;

    enemigosPorOleada = 5;

    enemigosGenerados = 0;

    contadorSpawn = 0;


    enemigos.clear();

    torres.clear();

    proyectiles.clear();


    juegoTerminado = false;

    victoria = false;
  }
}
