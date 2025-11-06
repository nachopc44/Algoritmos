# Se posee un arreglo de 200 libros con el siguiente formato:
# NRO_LIBRO|TITULO|AUTOR|CANT_HOJAS
# ordenado por AUTOR y se presentan las siguientes premisas:

# Se necesita saber que libros se poseen de “Nicklaus Wirth”.
# Se necesita saber en qué posición se encuentra “Algoritmos + Estructuras de Datos=Programa”.
# Se necesita saber cual es el libro de “Nicklaus Wirth” de mayor volumen.

Accion 39 es
    AMBIENTE
        Libro = Registro
            NroLibro: N(3)
            Titulo: AN(50)
            Autor: AN(30)
            CantHojas: N(4)
        FinRegistro

        A: arreglo de [1..200] de Libro

        i, volmay: entero
        titmay: texto

    PROCESO
        volmay:= 0
        Para i:= 1 a 200 hacer
            Si (A[i].Autor = "Nicklaus Wirth") entonces 
                Escribir("Titulo: ", A[i].Titulo, ". Autor: ", A[i].Autor)
                Si (A[i].CantHojas > volmay) entonces
                    volmay:= A[i].CantHojas
                    titmay:= A[i].Titulo
                FinSi
            FinSi

            Si (A[i].Titulo = "Algoritmos + Estructuras de Datos=Programa") entonces
                Escribir("El libro ", A[i].Libro, " se encuentra en la posicion ", i)
            FinSi
        FinPara

        Escribir("El libro con mas volumen de Nicklaus Wirth es '", titmay, "', con un total de ", volmay, " hojas.")
        
    FinProceso
FINACCION