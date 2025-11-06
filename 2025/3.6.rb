# Escribir un algoritmo que permita cargar un arreglo de N nombres, considerando que cada nombre debe tener entre 1 y 10 caracteres.

Accion 36 es
    AMBIENTE
        A: arreglo de [1..N] de texto
        i, N: entero
        flag:= booleano
    
    PROCESO
        Escribir("Ingresar el numero de nombres a cargar")
        Leer(N)

        Para i:= 1 a N hacer
            flag:= falso
            Mientras (flag = falso) hacer
                Escribir("Ingresar un nombre de entre 1 a 10 caracteres")
                Leer(A[i])
                Si (Longitud(A[i]) >= 1) y (Longitud(A[i]) <= 10) entonces
                    flag:= verdadero
                Sino
                    Escribir("El nombre ingresado no cumple el requisito solicitado")
                FinSi
            FinMientras
        FinPara

    FinProceso
FINACCION