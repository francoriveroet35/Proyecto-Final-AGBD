// ======================================================
// CYBER DEFENSE: LAST FIREWALL
// Tower Defense 2D - Processing
// ======================================================

// ----------------------
// LISTAS
// ----------------------

ArrayList<Enemigo> enemigos;
ArrayList<Torre> torres;
ArrayList<Proyectil> proyectiles;
ArrayList<PVector> nodos;


// ----------------------
// VARIABLES GENERALES
// ----------------------

int dinero = 300;
int vidas = 10;

int oleada = 1;
int enemigosPorOleada = 5;
int enemigosGenerados = 0;

int contadorSpawn = 0;
int tiempoEntreEnemigos = 100;

boolean juegoTerminado = false;
boolean victoria = false;


// ======================================================
// SETUP
// ======================================================

void setup() {

  size(1000, 650);

  enemigos = new ArrayList<Enemigo>();
  torres = new ArrayList<Torre>();
  proyectiles = new ArrayList<Proyectil>();

  nodos = new ArrayList<PVector>();

  crearNodos();
}


// ======================================================
// DRAW
// ======================================================

void draw() {

  background(0);

  // MAPA
  dibujarMapa();

  // JUEGO
  if (!juegoTerminado) {

    controlarOleadas();

    actualizarEnemigos();
    actualizarTorres();
    actualizarProyectiles();

  } else {

    dibujarMensajeFinal();
  }

  // INTERFAZ
  dibujarInterfaz();
}
