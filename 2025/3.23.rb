# En un sector de un hospital, donde se encuentran internados 50 pacientes, se toma la temperatura de cada paciente 4 veces al día durante una semana.

# Lectura	Dom	Lun	Mar	Mie	Jue	Vie	Sab
# 1	        XX	XX	XX	XX	XX	XX	XX
# 2	        XX	XX	XX	XX	XX	XX	XX
# 3	        XX	XX	XX	XX	XX	XX	XX
# 4	        XX	XX	XX	XX	XX	XX	XX
# Se dispone de un arreglo con la información recopilada de todos los pacientes.

# Construir un algoritmo que:

# Liste por pantalla las temperaturas máxima y mínima de cada paciente, indicando el día y lectura en la que ocurrieron.
# Genere un nuevo arreglo que contenga la temperatura promedio por día de cada paciente.

Accion 323 es 
    AMBIENTE
        A: arreglo de [1..4,1..7,1..50] de real
        B: arreglo de [1..50,1..7] de real
        i,j,k: entero
        tempmay,tempmin,promdia: real 
        diamay,diamin,lectmay,lectmin: entero
    
    PROCESO
        Para k:= 1 a 50 hacer
            tempmay:= 0
            tempmin:= HV 
            Para j:= 1 a 7 hacer
                promdia:= 0
                Para i:= 1 a 4 hacer
                    Si (A[i,j,k] > tempmay) entonces
                        tempmay:= A[i,j,k]
                        diamay:= j
                        lectmay:= i
                    FinSi
                    Si (A[i,j,k] < tempmin) entonces
                        tempmin:= A[i,j,k]
                        diamin:= j
                        lectmin:= i
                    FinSi
                    promdia:= promdia + A[i,j,k]
                FinPara
                promdia:= promdia / 4
                B[k,j]:= promdia
            FinPara
            Escribir("El paciente numero ", k, " presento la mayor temperatura (", tempmay, "ºC) el dia ", diamay, " de la semana, en la lectura numero ", lectmay)
            Escribir("El paciente numero ", k, " presento la menor temperatura (", tempmin, "ºC) el dia ", diamin, " de la semana, en la lectura numero ", lectmin)
        FinPara
    FinProceso
FINACCION