# Dada una matriz cuadrada de 5 x 5 de números, sumar filas y columnas y guardar en una matriz de 2 x 5, de modo que la fila 1 contenga la suma de cada fila y la fila 2, la suma de cada columna)

Accion 322 es 
    AMBIENTE
        A: arreglo de (1..5,1..5) de reales
        B: arreglo de (1..2,1..5) de reales
        i,j: entero
    
    PROCESO
        Para i:= 1 a 2 hacer
            Para j:= 1 a 5 hacer
                B[i,j]:= 0
            FinPara
        FinPara

        Para i:= 1 a 5 hacer
            Para j:= de 1 a 5 hacer
                B[1,i]:= B[1,i] + A[i,j]
                B[2,j]:= B[2,j] + A[i,j]
            FinPara
        FinPara

    FinProceso
FINACCION