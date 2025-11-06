# Se precisa ordenar un arreglo de enteros de menor a mayor, eliminando los números repetidos

Accion 315 es
    AMBIENTE
        A, B: arreglo de (1..N) de entero 
        i, j, k, x: entero
        flag: booleano 

    PROCESO
        k:= 1
        Para i:= 1 a N hacer
            j:= 1

            Mientras (j < N) y (B[j] <> A[i]) hacer 
                j:= j + 1
            FinMientras

            Si (B[j] = A[i]) entonces 
                flag:= falso
            Sino
                flag:= verdadero
            FinSi
            
            Si flag entonces
                B[k]:= A[i]
                k:= k + 1
            FinSi 
        FinPara

        Para i:= 2 a (k - 1) hacer
            x:= B[i]
            j:= i - 1
            Mientras (j > 0) y (x < B[j]) hacer
                B[j + 1]:= B[j]
                j:= j - 1
            FinMientras
            B[j + 1]:= x
        FinPara
    FinProceso
FINACCION