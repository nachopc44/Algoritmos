# Dados 2 vectores:
# A: arreglo [1..30] de reales B: arreglo [1..30] de reales
# Ambos ordenados de forma creciente, escribir un algoritmo que realice la mezcla de ambos para obtener otro vector tambien ordenado de forma creciente
# C: arreglo [1..60] de reales

Accion 35 es
    AMBIENTE
        A: arreglo [1..30] de entero
        B: arreglo [1..30] de entero
        C: arreglo [1..60] de entero
        i, j, k: entero
    
    PROCESO
        i:= 1
        j:= 1

        Mientras (i <= 30) y (j <= 30) hacer
            Si (A[i] < B[j]) entonces
                C[k]:= A[i]
                i:= i + 1
            Sino
                Si (A[i] > B[j]) entonces
                    C[k]:= B[j]
                    j:= j + 1
                Sino
                    C[k]:= A[i]
                    i:= i + 1
                FinSi
            FinSi
            k:= k + 1
        FinMientras

        Mientras (i <= 30) hacer
            C[k]:= A[i]
            i:= i + 1
            k:= k + 1
        FinMientras

        Mientras (j <= 30) hacer
            C[k]:= B[j]
            j:= j + 1
            k:= k + 1
        FinMientras
    
    FinProceso
FINACCION