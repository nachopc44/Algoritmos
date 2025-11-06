# Escribir un algoritmo que permita localizar un nombre en un arreglo de N nombres, ordenados alfabéticamente. Cada nombre puede tener, como máximo, 10 caracteres.

Accion 37 es
    AMBIENTE
        A: arreglo de [1..N] de texto
        i, N, iz, de, cen: entero 
        nombre: texto
    
    PROCESO
        Repetir
            Escribir("Ingrese el nombre a buscar (máximo 10 caracteres):")
            Leer(nombre)
        Hasta que (longitud(nombre) <= 10)

        iz:= 1
        de:= N
        cen:= (iz + de) DIV 2

        Mientras (iz < de) y (A[cen] <> nombre) hacer
            Si (A[cen] > nombre) entonces
                de:= cen - 1
            Sino
                iz:= cen + 1
            FinSi
            cen:= (iz + de) DIV 2
        FinMientras

        Si (A[cen] = nombre) entonces
            Escribir('El elemento buscado está en la posición ',cen)
        Sino
            Escribir('El elemento buscado no está en el arreglo');
        FinSi
        
    FinProceso
FINACCION