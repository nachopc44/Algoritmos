# Considerando un arreglo de 50 números enteros, confeccione un algoritmo para resolver las siguientes consignas:
# Modificar el arreglo dado, de modo que todos sus elementos sean múltiplos de 3.
# Crear otro arreglo que contenga los números que no cumplieron la condición.
# Informar cuántos números cumplieron la condición.

Accion 34 es
    AMBIENTE
        Vector1: arreglo de [1..50] de entero
        Vector2: arreglo de [1..n] de entero
        i, j, cont: entero
        flag: booleano

    PROCESO
        cont:= 0
        j:= 0

        Para i:= 1 a 50 hacer
            flag:= falso
            Si (Vector1[i] MOD 3 = 0) entonces
                cont:= cont + 1
            Sino
                j:= j + 1
                Vector2[j]:= Vector1[i]

                Mientras (flag = falso) hacer
                    Escribir("Ingresar numero multiplo de 3")
                    Leer(Vector1[i])
                    Si Vector1[i] MOD 3 = 0 entonces
                        flag:= verdadero
                    Sino
                        Escribir("El numero ingresado no es multiplo de 3")
                    FinSi
                FinMientras
            FinSi
        FinPara
        Escribir("La cantidad de numeros que cumplieron la condicion fue de: ", cont)
    
    FinProceso
FINACCION