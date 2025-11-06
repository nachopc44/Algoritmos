# Dado un arreglo de 50 elementos, cada uno de los cuales tiene los siguientes datos: Código de localidad y Lluvia caída en un año. Escribir un algoritmo que permita saber dada una localidad, cuanto llovió en el año. Aplicar el método más adecuado considerando que el arreglo esta ordenado por Código de localidad.

Accion 310 es 
    AMBIENTE
        Lluv = Registro
            Loc: entero
            Mm: real
        FinRegistro
        Lluvia: arreglo de [1..50] de Lluv
        iz, de, cen, cod: entero 

    PROCESO
        Escribir("Ingrese el codigo de la localidad deseada")
        Leer(cod)

        iz:= 1
        de:= 50
        cen:= (iz + de) DIV 2

        Mientras (iz < de) y (Lluvia[cen].Loc <> cod) hacer
            Si (Lluvia[cen] > cod) entonces
                de:= cen - 1
            Sino
                iz:= cen + 1
            FinSi
            cen:= (iz + de) DIV 2
        FinMientras

        Si (Lluvia[cen] = cod) entonces
            Escribir("En la localidad solicitada llovió ", Lluvia[cen].Mm, "mm.")
        Sino
            Escribir("El elemento buscado no está en el arreglo")
        FinSi

    FinProceso
FINACCION 