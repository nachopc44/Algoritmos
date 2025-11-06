# Genere un único algoritmo que resuelva las 3 consignas, usando un arreglo de 100 números enteros:
# Almacenar 100 números.
# Localizar el número de mayor valor y el de menor valor, informar sus valores y sus posiciones.
# Contar y sumar todos los números pares.

Accion 32 es 
    AMBIENTE
        Vector: arreglo de [1..100] de entero
        i, mayorval, menorval, mayorpos, menorpos, contpar, sumpar: entero
    
    PROCESO
        mayorval:= 0
        menorval:= HV
        contpar:= 0
        sumpar:= 0

        Para i:= 1 a 100 hacer
            Escribir("Ingresar el numero entero que desea cargar")
            Leer(Vector[i])

            Si (Vector[i] > mayorval) entonces
                mayorval:= Vector[i]
                mayorpos:= i 
            FinSi

            Si (Vector[i] < menorval) entonces
                menorval:= Vector[i]
                menorpos:= i
            FinSi

            Si (Vector[i] MOD 2 = 0) entonces
                contpar:= contpar + 1
                sumpar:= sumpar + Vector[i]
            FinSi
        FinPara

        Escribir("El mayor valor es: ", mayorval, ", se encuentra en la posicion: ", mayorpos, ".")
        Escribir("El menor valor es: ", menorval, ", se encuentra en la posicion: ", menorpos, ".")
    
    FinProceso
FINACCION