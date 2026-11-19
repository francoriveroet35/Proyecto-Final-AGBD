// ======================================================
// INTERFAZ
// ======================================================

void dibujarInterfaz() {

  fill(255);

  textAlign(LEFT);

  textSize(20);


  text(
    "Dinero: $" + dinero,
    20,
    30
    );


  text(
    "Vidas: " + vidas,
    20,
    55
    );


  text(
    "Oleada: " + oleada,
    20,
    80
    );


  textSize(14);


  text(
    "CLICK = Torre Antivirus ($100)",
    20,
    110
    );


  text(
    "SHIFT + CLICK = Torre Firewall ($150)",
    20,
    130
    );
}


// ======================================================
// MENSAJE FINAL
// ======================================================

void dibujarMensajeFinal() {

  fill(255);

  textAlign(CENTER);

  textSize(45);


  if (victoria) {

    text(
      "VICTORIA",
      width / 2,
      height / 2
      );

  } else {

    text(
      "DERROTA",
      width / 2,
      height / 2
      );
  }


  textSize(20);


  text(
    "Presiona R para reiniciar",
    width / 2,
    height / 2 + 50
    );
}
