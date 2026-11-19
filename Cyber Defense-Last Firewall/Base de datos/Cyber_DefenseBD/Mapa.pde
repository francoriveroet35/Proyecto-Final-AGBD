class Mapa {

  ArrayList<PVector> nodos;

  Mapa() {

    nodos = new ArrayList<PVector>();

    nodos.add(new PVector(50, 180));
    nodos.add(new PVector(250, 180));
    nodos.add(new PVector(250, 400));
    nodos.add(new PVector(550, 400));
    nodos.add(new PVector(550, 220));
    nodos.add(new PVector(850, 220));
  }

  void dibujar() {

    background(15, 20, 30);

    // Camino de los enemigos

    stroke(70, 75, 90);
    strokeWeight(55);
    noFill();

    beginShape();

    for (PVector n : nodos) {
      vertex(n.x, n.y);
    }

    endShape();

    // Linea central

    stroke(120, 130, 150);
    strokeWeight(2);

    for (int i = 0; i < nodos.size() - 1; i++) {

      PVector a = nodos.get(i);
      PVector b = nodos.get(i + 1);

      line(a.x, a.y, b.x, b.y);
    }

    // Nucleo de datos

    noStroke();
    fill(0, 180, 255);

    rectMode(CENTER);
    rect(900, 220, 55, 55);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(11);
    text("CORE", 900, 220);

    rectMode(CORNER);
    textAlign(LEFT);

    strokeWeight(1);
  }
}
