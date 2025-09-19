#include <stdio.h>zz
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define FILAS 5
#define COLUMNAS 5
#define MAX_PREGUNTAS 8

typedef struct {
    char tipo; 
    int visitado; 
} Habitacion;

typedef struct {
    int salud;
    int puntuacion;
    int fila;
    int columna;
} Jugador;

typedef struct {
    char pregunta[200];
    char opciones[3][100];
    int respuestaCorrecta;
} Pregunta;

void inicializarMazmorra(Habitacion mazmorra[FILAS][COLUMNAS]) {
    srand(time(NULL));

    for (int i = 0; i < FILAS; i++) {
        for (int j = 0; j < COLUMNAS; j++) {
            mazmorra[i][j].tipo = '.';
            mazmorra[i][j].visitado = 0;
        }
    }

    for (int i = 0; i < MAX_PREGUNTAS; i++) {
        int x, y;
        do {
            x = rand() % FILAS;
            y = rand() % COLUMNAS;
        } while (mazmorra[x][y].tipo != '.');
        mazmorra[x][y].tipo = 'E';
    }

    for (int i = 0; i < FILAS * COLUMNAS / 10; i++) {
        int x, y;
        do {
            x = rand() % FILAS;
            y = rand() % COLUMNAS;
        } while (mazmorra[x][y].tipo != '.');
        mazmorra[x][y].tipo = 'R';
    }

    for (int i = 0; i < FILAS * COLUMNAS / 10; i++) {
        int x, y;
        do {
            x = rand() % FILAS;
            y = rand() % COLUMNAS;
        } while (mazmorra[x][y].tipo != '.');
        mazmorra[x][y].tipo = 'T';
    }

    mazmorra[FILAS - 1][COLUMNAS - 1].tipo = 'S';
}

void mostrarMazmorra(Habitacion mazmorra[FILAS][COLUMNAS], Jugador jugador) {
    for (int i = 0; i < FILAS; i++) {
        for (int j = 0; j < COLUMNAS; j++) {
            if (i == jugador.fila && j == jugador.columna)
                printf("J ");
            else if (mazmorra[i][j].visitado)
                printf("%c ", mazmorra[i][j].tipo);
            else
                printf("? ");
        }
        printf("\n");
    }
}

void inicializarPreguntas(Pregunta preguntas[]) {
    strcpy(preguntas[0].pregunta, "Que es un puntero");
    strcpy(preguntas[0].opciones[0], "Es un tipo de dato que almacena numeros enteros y caracteres.");
    strcpy(preguntas[0].opciones[1], "Es un componente de hardware que gestiona la asignacion de memoria.");
    strcpy(preguntas[0].opciones[2], "Es un dato que representa una direccion de memoria fisica.");
    preguntas[0].respuestaCorrecta = 2;

    strcpy(preguntas[1].pregunta, "Que son las listas doblemente enlazadas");
    strcpy(preguntas[1].opciones[0], "Son listas que solo pueden recorrerse desde el primer nodo hacia el ultimo.");
    strcpy(preguntas[1].opciones[1], "Son listas que permiten recorrerse en ambas direcciones.");
    strcpy(preguntas[1].opciones[2], "Son listas donde cada nodo almacena unicamente un valor.");
    preguntas[1].respuestaCorrecta = 1;

    strcpy(preguntas[2].pregunta, "Que es una lista circular");
    strcpy(preguntas[2].opciones[0], "Es una lista que se ordena automaticamente en forma de circulo.");
    strcpy(preguntas[2].opciones[1], "Es una lista lineal donde el ultimo nodo apunta al primero.");
    strcpy(preguntas[2].opciones[2], "Es una lista que almacena datos en formato de matriz circular.");
    preguntas[2].respuestaCorrecta = 1;

    strcpy(preguntas[3].pregunta, "Que es un caso recursivo");
    strcpy(preguntas[3].opciones[0], "Es una solucion que involucra llamar a la funcion original.");
    strcpy(preguntas[3].opciones[1], "Es un caso especial de una funcion que nunca termina.");
    strcpy(preguntas[3].opciones[2], "Es un caso en el que la funcion resuelve el problema sin llamarse.");
    preguntas[3].respuestaCorrecta = 0;

    strcpy(preguntas[4].pregunta, "Que es un arbol binario completo");
    strcpy(preguntas[4].opciones[0], "Todos los nodos tienen un hijo.");
    strcpy(preguntas[4].opciones[1], "Los nodos pueden tener entre uno y tres hijos.");
    strcpy(preguntas[4].opciones[2], "Todos los nodos tienen dos hijos y las hojas estan al mismo nivel.");
    preguntas[4].respuestaCorrecta = 2;

    strcpy(preguntas[5].pregunta, "Que es un arbol binario de busqueda o ABB");
    strcpy(preguntas[5].opciones[0], "Es un arbol que almacena datos en orden aleatorio.");
    strcpy(preguntas[5].opciones[1], "Es un arbol binario donde los hijos izquierdo y derecho siguen ciertas reglas.");
    strcpy(preguntas[5].opciones[2], "Es un arbol en el que todos los nodos tienen el mismo valor.");
    preguntas[5].respuestaCorrecta = 1;

    strcpy(preguntas[6].pregunta, "Que es un arbol AVL");
    strcpy(preguntas[6].opciones[0], "Un arbol sin relacion con el orden de los valores.");
    strcpy(preguntas[6].opciones[1], "Es un arbol binario balanceado."); 
    strcpy(preguntas[6].opciones[2], "Un arbol donde los nodos tienen al menos tres hijos.");
    preguntas[6].respuestaCorrecta = 1;

    strcpy(preguntas[7].pregunta, "De cuantas fases basicas consta la insercion de un elemento");
    strcpy(preguntas[7].opciones[0], "Consta de 1.");
    strcpy(preguntas[7].opciones[1], "Consta de 3.");
    strcpy(preguntas[7].opciones[2], "Consta de 5.");
    preguntas[7].respuestaCorrecta = 1;
}

void combate(Jugador *jugador, Pregunta preguntas[], int preguntasUsadas[]) {
    int preguntaIndex;
    do {
        preguntaIndex = rand() % MAX_PREGUNTAS;
    } while (preguntasUsadas[preguntaIndex]);

    preguntasUsadas[preguntaIndex] = 1;
    printf("%s\n", preguntas[preguntaIndex].pregunta);
    for (int i = 0; i < 3; i++) {
        printf("%d) %s\n", i + 1, preguntas[preguntaIndex].opciones[i]);
    }

    int respuesta;
    printf("Selecciona tu respuesta (1-3): ");
    scanf("%d", &respuesta);

    if (respuesta - 1 == preguntas[preguntaIndex].respuestaCorrecta) {
        printf("Respuesta correcta. Ganaste 20 puntos.\n");
        jugador->puntuacion += 20;
    } else {
        printf("Respuesta incorrecta. Perdiste 15 de salud.\n");
        jugador->salud -= 15;
    }
}

int moverJugador(Jugador *jugador, char movimiento) {
    int nuevaFila = jugador->fila;
    int nuevaColumna = jugador->columna;

    if (movimiento == 'w') nuevaFila--;
    if (movimiento == 's') nuevaFila++;
    if (movimiento == 'a') nuevaColumna--;
    if (movimiento == 'd') nuevaColumna++;

    if (nuevaFila >= 0 && nuevaFila < FILAS && nuevaColumna >= 0 && nuevaColumna < COLUMNAS) {
        jugador->fila = nuevaFila;
        jugador->columna = nuevaColumna;
        return 1;
    }
    return 0;
}

int main() {
    Habitacion mazmorra[FILAS][COLUMNAS];
    Jugador jugador = {100, 0, 0, 0};
    Pregunta preguntas[MAX_PREGUNTAS];
    int preguntasUsadas[MAX_PREGUNTAS] = {0};

    inicializarMazmorra(mazmorra);
    inicializarPreguntas(preguntas);

    char movimiento;
    while (jugador.salud > 0) {
        mostrarMazmorra(mazmorra, jugador);
        printf("Salud: %d, Puntuacion: %d\n", jugador.salud, jugador.puntuacion);
        printf("Movimiento (w/a/s/d): ");
        scanf(" %c", &movimiento);

        if (movimiento != 'w' && movimiento != 'a' && movimiento != 's' && movimiento != 'd') {
            printf("Esa tecla no hace nada.\n");
            continue;
        }

        if (moverJugador(&jugador, movimiento)) {
            Habitacion *habitacion = &mazmorra[jugador.fila][jugador.columna];
            if (habitacion->visitado == 0) {
                habitacion->visitado = 1;
                switch (habitacion->tipo) {
                    case 'E':
                        printf("Enemigo encontrado. Inicia combate!\n");
                        combate(&jugador, preguntas, preguntasUsadas);
                        break;
                    case 'T':
                        printf("Encontraste un tesoro! +30 puntos.\n");
                        jugador.puntuacion += 30;
                        break;
                    case 'R':
                        printf("Caiste en una trampa! Perdiste 20 de salud.\n");
                        jugador.salud -= 20;
                        break;
                    case 'S':
                        printf("Encontraste la salida! Felicitaciones, ganaste el juego.\n");
                        return 0;
                    case '.':
                        printf("Estas en una casilla vacia.\n");
                        break;
                }
            } else {
                printf("Ya visitaste esta habitacion.\n");
            }
        } else {
            printf("Movimiento invalido.\n");
        }
    }

    printf("Fin del juego. Salud agotada.\n");
    return 0;
}
