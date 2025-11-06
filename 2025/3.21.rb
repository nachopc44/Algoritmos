# Dada una matriz de 6 x 6 de enteros, cuya última fila y columna contienen ceros, calcular la suma de cada fila y guardar en la última celda de la misma; y la suma de cada columna y guardar en la última celda de la misma. Calcular también el total general y guardar en la posición (6,6).

Accion 321 es
    AMBIENTE
        matriz: arreglo de [1..6,1..6] de entero 
        i,j: entero
    
    PROCESO
        Para i:= 1 a 5 hacer
            Para j:= 1 a 5 hacer 
                matriz[i,6]:= matriz[i,6] + matriz[i,j]
                matriz[6,j]:= matriz[6,j] + matriz[i,j]
                matriz[6,6]:= matriz[6,6] + matriz[i,j]
            FinPara
        FinPara
    FinProceso
FINACCION