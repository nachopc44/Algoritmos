' Dadas dos matrices A y B, cuadradas, de 5 x 5, con números enteros, cargar una matriz C, de 5 x 5 teniendo en cuenta las siguientes condiciones: la diagonal principal completar con ceros, en las posiciones que están por encima de la diagonal principal, copiar los correspondientes elementos de la matriz A y en las posiciones que están por debajo de la diagonal principal, copiar los elementos correspondientes de la matriz B.

Accion 320 es
    AMBIENTE
        A,B,C; arreglo de [1..5,1..5] de entero
        i,j: entero
    
    PROCESO
        Para i:= 1 a 5 hacer
            Para j:= 1 a 5 hacer
                Si (i = j) entonces
                    C[i,j]:= 0
                Sino 
                    Si (i < j) entonces
                        C[i,j]:= A[i,j]
                    Sino
                        C[i,j]:= B[i,j]
                    FinSi
                FinSi
                Escribir(C[i,j])
            FinPara
        FinPara
    FinProceso
FINACCION