# Diseñar un algoritmo para acceder, eliminar o insertar el k-ésimo elemento de una lista (siendo k una posición dada). Si la lista está vacía o si el valor de k esta fuera del rango del índice de la lista, invocar al procedimiento de ERROR. En cualquier otro caso, efectuar el procedimiento solicitado.

Accion ListaKEsima es (PRIM: Puntero a Nodo)
    AMBIENTE
        Nodo = Registro
            dato: entero
            prox: Puntero a Nodo
        FinRegistro

        p, ant, nuevo: Puntero a Nodo
        k, op: entero

    PROCESO
        Si (PRIM = nil) Entonces
            ERROR()
        Sino
            Escribir("Ingrese la posición k:")
            Leer(k)
            Escribir("Ingrese '1' para acceder, '2' para eliminar o '3' para insertar:")
            Leer(op)

            Si (op = 1) entonces #ACCEDER
                p:= PRIM
                Mientras (p <> nil) y (p < k) hacer
                    p:= *p.prox
                FinMientras
                Si (p = nil) entonces
                    ERROR()
                Sino
                    Escribir("Elemento en posición ", k, ": ", *p.dato)
                FinSi

            Sino
                Si (op = 2) entonces #ELIMINAR
                    p:= PRIM
                    ant:= nil
                    Mientras (p <> nil) y (p < k) hacer
                        ant:= p
                        p:= *p.prox
                    FinMientras
                    Si (p = nil) entonces
                        ERROR()
                    Sino
                        Si (ant = nil) entonces  #primer Nodo
                            PRIM:= *p.prox
                        Sino
                            *ant.prox:= *p.prox
                        FinSi
                        DISPONER(p)
                    FinSi

                Sino #INSERTAR 
                    NUEVO(nuevo)
                    Esc("Ingrese el valor a insertar:")
                    Leer(*nuevo.dato)
                    
                    Si (k = 1) Entonces
                        *nuevo.prox:= PRIM
                        PRIM:= nuevo
                    Sino
                        p:= PRIM
                        Mientras (p <> nil) y (p < k - 1) hacer
                            p:= *p.prox
                        FinMientras
                        Si (p = nil) Entonces
                            ERROR()
                        Sino
                            *nuevo.prox:= *p.prox
                            *p.prox:= nuevo
                        FinSi
                    FinSi
                FinSi
            FinSegun
        FinSi
    FinProceso
FINACCION