# Se precisa ordenar un arreglo de N alumnos de mayor a menor, de acuerdo a la cantidad de materias aprobadas. Cada elemento del arreglo contiene Nro. de Legajo y Cantidad de materias aprobadas.

Accion 313 es
    AMBIENTE
        Alumnos = Registro
            NroLegajo: N(5)
            CantAprobadas: N(2)
        FinRegistro

        A: arreglo de [1..N] de Alumnos
        i, j, max: entero
        x: Alumnos
    
    PROCESO
        Para i:= 1 a N - 1 hacer
            x:= A[i]
            max:= i
            
            Para j:= i + 1 a N hacer
                Si (x < A[j]) entonces
                    max:= j
                    x:= A[j]
                FinSi
            FinPara

            A[max]:= A[i]
            A[i]:= x
        FinPara

    FinProceso
FINACCION