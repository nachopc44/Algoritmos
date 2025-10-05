# Crear un algoritmo que imprima un reporte como el que se indica, incluyendo totales por Obra Social y Clínica de liquidaciones a médicos. Los archivos que intervienen son:

# LIQUIDACIONES Ordenado por O.S. y Clinica
# O.S.|Clinica|Nro_Leg|Mes|Anio|Bruto|Descuento_AFIP|Descuento_DGR

# Neto = Bruto – (Desc_AFIP + Desc_DGR)

# OBRAS_SOCIALES Indexado por Cod_Os
# Cod_OS|Nombre

# CLÍNICAS Indexado por Cod_Cli
# Cod_Cli|Nombre

# MÉDICOS Indexado por Nro_Leg
# Nro_Leg|ApyNom|Especialidad|DNI

# Reporte:

# Obra Social:	
# Clinica:	
# Médicos	
# Nro Legajo     Nombre     Neto
# ..........     ......     .....
# ..........     ......     .....
# Total Clínica	 ................
# Total Obra Social  ............

Accion 237 es 
    AMBIENTE 
        Liquidaciones = Registro
            OS: N(4)
            Clinica: N(4)
            Nro_Leg: N(9)
            Mes: (1..12)
            Anio: N(4)
            Bruto: N(8)
            Desc_AFIP: N(5)
            Desc_DGR: N(5)
        FinRegistro

        Mae: archivo de Liquidaciones ordenado por OS y Clinica
        RegMae: Liquidaciones

        ObrasSociales = Registro
            Cod_OS: N(4)
            Nombre: AN(30)
        FinRegistro

        OS: archivo de ObrasSociales indexado por Cod_OS
        RegOS: ObrasSociales

        Clinicas = Registro
            Cod_Cli: N(4)
            Nombre: AN(30)
        FinRegistro

        Clini: archivo de Clinicas indexado por Cod_Cli
        RegClini: Clinicas

        Medicos = Registro
            Nro_Leg: N(9)
            ApyNom: AN(30)
            Especialidad: AN(30)
            DNI: N(8)
        FinRegistro

        Meds: archivo de Medicos indexado por Nro_Leg
        RegMeds: Medicos

        Neto, TotCli, TotOS: real

    PROCESO
        Abrir E/ (Mae)
        Abrir E/ (OS)
        Abrir E/ (Clini)
        Abrir E/ (Meds)

        Leer(Mae,RegMae)

        Mientras NFDA(Mae) hacer
            RegOS.Cod_OS:= RegMae.OS
            Leer(OS,RegOS)

            Si Existe entonces
                TotOS:= 0
                Escribir("Obra Social: ", RegOS.Nombre)

                Mientras NFDA(Mae) y (RegMae.OS = RegOS.Cod_OS) hacer
                    RegClini.Cod_Cli:= RegMae.Clinica
                    Leer(Clini,RegClini)

                    Si Existe entonces
                        TotCli:= 0
                        Escribir("Clinica: ", RegClini.Nombre)
                        Escribir("Medicos: ")

                        Mientras NFDA(Mae) y (RegMae.OS = RegOS.Cod_OS) y (RegMae.Clinica = RegClini.Cod_Cli) hacer
                            RegMeds.Nro_Leg := RegMae.Nro_Leg
                            Leer(Meds,RegMeds)

                            Si Existe entonces
                                Neto:= RegMae.Bruto - (RegMae.Desc_AFIP + RegMae.Desc_DGR)
                                Escribir("Nro Legajo: ", RegMae.Nro_Leg,". Nombre: ", RegMeds.ApyNom,". Neto: ", Neto)
                                TotCli := TotCli + Neto
                            Sino
                                Escribir("Error, número de legajo no existe")
                            FinSi

                            Leer(Mae,RegMae)
                        FinMientras

                        TotOS := TotOS + TotCli
                        Escribir("Total Clínica: ", TotCli)
                    Sino
                        Escribir("Error, clínica no existe")
                        Leer(Mae,RegMae)
                    FinSi
                FinMientras

                Escribir("Total Obra Social: ", TotOS)
            Sino
                Escribir("Error, obra social no existe")
                Leer(Mae,RegMae)
            FinSi
        FinMientras

        Cerrar(Mae)
        Cerrar(OS)
        Cerrar(Clini)
        Cerrar(Meds)
    FinProceso
FINACCION