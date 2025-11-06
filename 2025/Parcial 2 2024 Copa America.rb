#=============
# EJERCICIO 1
#=============

Accion Ej1 es
    AMBIENTE
        Fecha = Registro
            AA: N(4)
            MM: (1..12)
            DD: (1..31)
        FinRegistro

        Paises = Registro
            CodPais: N(2)
            ApuestasFavor: N(7)
            ApuestasContra: N(7)
            GolesEsperados: N(2)
            TarjRojasEsp: N(3)
        FinRegistro

        ArchMae, ArchAct: archivo de Paises ordenado por CodPais 
        RegMae, Aux: Paises

        Prode = Registro
            CodPais: N(2)
            FechApuesta: Fecha
            ApaFav: {"S","N"}
            Goles: N(3)
            TarjRojas: N(3)
        FinRegistro

        ArchMov: archivo de Prode ordenado por CodPais, FechApuesta
        RegMov: Prode

        Trofeos = Registro
            CodPais: N(2)
            CantCopas: N(2)
        FinRegistro

        ArchIndex: archivo de Trofeos indexado por CodPais
        RegIndex: Trofeos
        
        Populares = Registro
            CodPais: N(2)
        FinRegistro

        ArchPop: archivo de Populares
        RegPop: Populares

        Flag: booleano      #verdadero si voy a copiar en popular

        Procedimiento LeerMae() es
            Leer(ArchMae,RegMae)
            Si FDA(ArchMae) entonces
                RegMae.CodPais:= HV
            FinSi
        FinProcedimiento

        Procedimiento LeerMov() es
            Leer(ArchMov,RegMov)
            Si FDA(ArchMov) hacer
                RegMov.CodPais:= HV
            FinSi
        FinProcedimiento

        Procedimiento VerificarPopular(x:Paises) es
            Flag:= falso
            RegIndex.CodPais:= x.CodPais
            Leer(ArchIndex,RegIndex)
            Si (Existe) y (RegIndex.CantCopas > 2) entonces
                Si (x.ApuestasFavor > (x.ApuestasContra * 3))
                    Flag:= verdadero
                FinSi
            FinSi

            Si Flag entonces
                RegPop.CodPais:= x.CodPais
                Grabar(ArchPop,RegPop)
            Sino
                Grabar(ArchAct,x)
            FinSi
        FinProcedimiento

        Procedimiento ProcesarMovimientos() es
            Mientras (Aux.CodPais = RegMov.CodPais) hacer
                Si (RegMov.ApaFav = "S") entonces
                    Aux.ApuestasFavor:= Aux.ApuestasFavor + 1
                Sino 
                    Aux.ApuestasContra:= Aux.ApuestasContra + 1
                FinSi
                Aux.GolesEsperados:= Aux.GolesEsperados + RegMov.Goles
                Aux.TarjRojasEsp:= Aux.TarjRojasEsp + RegMov.TarjRojas
                LeerMov()
            FinMientras
        FinProcedimiento
    
    PROCESO
        Abrir E/ (ArchMae)
        Abrir E/ (ArchMov)
        Abrir E/ (ArchIndex)
        Abrir /S (ArchAct)
        Abrir /S (ArchPop)

        LeerMae()
        LeerMov()

        Mientras (RegMae.CodPais <> HV) o (RegMov.CodPais <> HV) hacer

            Si (RegMae.CodPais < RegMov.CodPais) entonces 
                VerificarPopular(RegMae)
                LeerMae()

            Sino
                Si (RegMae.CodPais > RegMov.CodPais) entonces
                    Aux.CodPais:= RegMov.CodPais
                    Aux.ApuestasContra:= 0
                    Aux.ApuestasFavor:= 0
                    Aux.GolesEsperados:= 0
                    Aux.TarjRojasEsp:= 0

                    ProcesarMovimientos()
                    VerificarPopular(Aux)

                Sino
                    Aux:= RegMae
                    ProcesarMovimientos()
                    VerificarPopular(Aux)
                    LeerMae()

                FinSi
            FinSi
        FinMientras

        Cerrar(ArchMae)
        Cerrar(ArchMov)
        Cerrar(ArchAct)
        Cerrar(ArchIndex)
        Cerrar(ArchPop)
    FinProceso
FINACCION