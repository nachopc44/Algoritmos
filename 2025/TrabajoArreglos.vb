ACCION ArregloTP ES
    AMBIENTE
        sistemas: arreglo de [1..4] de caracteres
        vulnerabilidades: arreglo de [1..4] de caracteres
        dias: arreglo de [1..4] de entero
        i, j: entero
        actualSistema: caracteres
        actualVulnerabilidad: caracteres
        actualDias: entero

    PROCESO
        //Ejemplo de carga inicial
        sistemas[1] := "ServidorMail"
        vulnerabilidades[1] := "CVE-2023-1234"
        dias[1] := 45

        sistemas[2] := "Firewall"
        vulnerabilidades[2] := "CVE-2024-5678"
        dias[2] := 10

        sistemas[3] := "ServidorWeb"
        vulnerabilidades[3] := "CVE-2022-7788"
        dias[3] := 60

        sistemas[4] := "BaseDatos"
        vulnerabilidades[4] := "CVE-2025-0022"
        dias[4] := 20

        //Ordenamiento por inserción
        Para i := 2 hasta 4 hacer
            actualSistema := sistemas[i]
            actualVulnerabilidad := vulnerabilidades[i]
            actualDias := dias[i]

            j := i - 1

            Mientras j >= 1 y dias[j] > actualDias hacer
                dias[j+1] := dias[j]
                sistemas[j+1] := sistemas[j]
                vulnerabilidades[j+1] := vulnerabilidades[j]
                j := j - 1
            Fin_Mientras

            dias[j+1] := actualDias
            sistemas[j+1] := actualSistema
            vulnerabilidades[j+1] := actualVulnerabilidad
        Fin_Para

        //Mostrar vector ordenado
        Para i := 1 hasta 4 hacer
            Esc("Sistema: ", sistemas[i],"Vulnerabilidad: ", vulnerabilidades[i],"Días sin parche: ", dias[i])
        FinPara
    FinProceso
FINACCION