// ======================================================
// MAPA
// ======================================================

void crearNodos() {

  // ----------------------
  // WAYPOINTS
  // ----------------------

  nodos.add(new PVector(50, 150));   // A
  nodos.add(new PVector(250, 150));  // B
  nodos.add(new PVector(250, 400));  // C
  nodos.add(new PVector(550, 400));  // D
  nodos.add(new PVector(550, 200));  // E
  nodos.add(new PVector(850, 200));  // F
}


// ======================================================
// DIBUJAR MAPA
// ======================================================

void dibujarMapa() {

  // ----------------------
  // CAMINO
  // ----------------------

  stroke(100);
  strokeWeight(8);
  noFill();

  beginShape();

  for (PVector nodo : nodos) {

    vertex(nodo.x, nodo.y);
  }

  endShape();


  // ----------------------
  // WAYPOINTS
  // ----------------------

  for (int i = 0; i < nodos.size(); i++) {

    fill(255);
    noStroke();

    ellipse(
      nodos.get(i).x,
      nodos.get(i).y,
      10,
      10
      );

    fill(255);

    textSize(12);

    text(
      "P" + char('A' + i),
      nodos.get(i).x + 10,
      nodos.get(i).y - 10
      );
  }


  // ----------------------
  // NÚCLEO
  // ----------------------

  fill(0, 255, 0);

  rect(
    900,
    175,
    50,
    50
    );

  fill(255);

  textSize(14);

  text(
    "NUCLEO",
    895,
    245
    );
}
