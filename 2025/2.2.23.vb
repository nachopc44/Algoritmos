' Una empresa de distribución de energía eléctrica posee un archivo maestro con los siguientes datos de sus clientes (la fecha de última lectura son las mediciones realizadas hasta el mes de mayo del 2014):

' CLIENTE Ordenado por Id_Casa
' Id_Casa|Fecha_Ult_Lectura|Cant_Lecturas|Prom_Lecturas|Tipo_Consumidor

' El campo tipo de consumidor puede ser:
' A (cuando el promedio de lectura es menor a 20K)
' B (cuando el promedio de lectura es menor a 40K)
' C (cuando el promedio de lectura es igual o supera los 40K)

' Cuenta además con el siguiente archivo con datos de las mediciones realizadas en los dos últimos años (desde junio del 2014 hasta junio del 2016)

' Mediciones Ordenado por Id_Casa
' Id_Casa|Fecha_Medicion|Consumo

' Se pide actualizar el archivo maestro con la información de las lecturas hasta el mes de enero del año 2015 inclusive. Los campos que se deben actualizar son: la fecha de ultima lectura, cantidad de lecturas, el promedio y modificar (en caso de ser necesario) el tipo de consumidor. En caso en que no exista el ID casa (una conexión nueva) se tiene que crear en el maestro y actualizar los otros campos.

Accion 2223 es 
    AMBIENTE

        Fecha = Registro
            AA: N(4)
            MM: 01...12
            DD: 01...31
        FinRegistro

        Cliente = Registro
            Id_Casa: N(6)
            Fecha_Ult_Lect: Fecha
            Cant_Lect: N(3)
            Prom_Lect: N(5)
            Tipo_Cons: {"A","B","C"}
        FinRegistro

        Mae, MaeS: archivo de Cliente ordenado por Id_Casa
        RegMae, aux: Cliente

        Mediciones = Registro
            Id_Casa: N(6)
            Fecha_Med: Fecha
            Consumo: N(5)
        FinRegistro

        Mov: archivo de Mediciones ordenado por Id_Casa
        RegMov: Mediciones

        ContLect, TotCons, PromCalc: real
        FechaLim: Fecha

        Procedimiento LeerMae() es
            Leer(Mae,RegMae)
            Si FDA(Mae) entonces
                RegMae.Id_Casa:= HV
            FinSi
        FinProcedimiento

        Procedimiento LeerMov() es
            Leer(Mov,RegMov)
            Si FDA(Mov) entonces
                RegMov.Id_Casa:= HV
            FinSi
        FinProcedimiento
        
    PROCESO
        Abrir E/ (Mae); LeerMae()
        Abrir E/ (Mov); LeerMov()
        Abrir /S (MaeS)

        FechaLim.AA:= 2015
        FechaLim.MM:= 01
        FechaLim.DD:= 31

        ContLect:= 0
        TotCons:= 0
        PromCalc:= 0

        Mientras (RegMae.Id_Casa <> HV) o (RegMov <> HV) hacer
            Si RegMae.Id_Casa < RegMov.Id_Casa entonces
                Grabar(MaeS,RegMae)
                LeerMae()
            Sino
                Si RegMae.Id_Casa = RegMov.Id_Casa entonces
                    aux:= RegMae
                    ContLect:= 0
                    TotCons:= 0

                    Mientras (RegMae.Id_Casa = RegMov.Id_Casa) hacer
                        Si (RegMov.Fecha_Med <= FechaLim) entonces
                            ContLect:= ContLect + 1
                            TotCons:= TotCons + RegMov.Consumo
                            aux.Fecha_Ult_Lect:= RegMov.Fecha_Med
                        FinSi
                        LeerMov()
                    FinMientras

                    aux.Cant_Lect:= RegMae.Cant_Lect + ContLect
                    aux.Prom_Lect:= (RegMae.Prom_Lect * RegMae.Cant_Lect + TotCons) / aux.Cant_Lect

                    Si (aux.Prom_Lect < 20000) entonces
                        aux.Tipo_Cons:= "A"
                    Sino
                        Si (aux.Prom_Lect >= 20000) y (aux.Prom_Lect < 40000) entonces
                            aux.Tipo_Cons:= "B"
                        Sino
                            aux.Tipo_Cons:= "C"
                        FinSi
                    FinSi

                    Grabar(MaeS,aux)
                    LeerMae()

                Sino 'RegMae.Id_Casa>RegMov.Id_Casa
                    aux.Id_Casa:= RegMov.Id_Casa
                    ContLect:= 0
                    TotCons:= 0

                    Mientras (RegMae.Id_Casa = RegMov.Id_Casa) hacer
                        Si RegMov.Fecha_Med <= FechaLim entonces
                            ContLect:= ContLect + 1 
                            TotCons:= TotCons + RegMov.Consumo
                            aux.Fecha_Ult_Lect:= RegMov.Fecha_Med
                        FinSi
                        LeerMov()
                    FinMientras

                    aux.Cant_Lect:= ContLect
                    aux.Prom_Lect:= TotCons / aux.Cant_Lect

                    Si (aux.Prom_Lect < 20000) entonces
                        aux.Tipo_Cons:= "A"
                    Sino
                        Si (aux.Prom_Lect >= 20000) y (aux.Prom_Lect < 40000) entonces
                            aux.Tipo_Cons:= "B"
                        Sino
                            aux.Tipo_Cons:= "C"
                        FinSi
                    FinSi

                    Grabar(MaeS,aux)
                    LeerMae()
                FinSi
            FinSi
        FinMientras

        Cerrar(Mae)
        Cerrar(MaeS)
        Cerrar(Mov)
    FinProceso
FINACCION