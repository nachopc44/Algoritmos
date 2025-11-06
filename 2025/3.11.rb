# Dado un arreglo de 100 elementos, que contiene la siguiente información sobre videos: Título de la película, Nombre del Director, Categoría de película, Cantidad de personas que la vieron, Alquilado (si/no); y está ordenado por el Título de la película, diseñe un algoritmo que, ingresando una categoría, liste todas las películas que pertenecen a dicha categoría.

Accion 311 es
    AMBIENTE
        Pelis = Registro
            Titulo: AN(50)
            Director: AN(30)
            Categoria: AN(30)
            CantidadVistas: N(4)
            Alquilado: {"si","no"}
        FinRegistro

        A: arreglo de [1..100] de Pelis
        i: entero
        CatSoli: texto

    PROCESO
        Escribir("Ingresar categoria que desea buscar: ")
        Leer(CatSoli)

        Para i:= 1 a 100 hacer
            Si (A[i].Categoria = CatSoli) entonces
                Escribir("Titulo: ", A[i].Titulo, ". Categoria: ", A[i].Categoria)
            FinSi
        FinPara
    
    FinProceso
FINACCION