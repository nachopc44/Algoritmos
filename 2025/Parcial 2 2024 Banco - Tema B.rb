# EJERCICIO 1

Accion Ej1 es 
    AMBIENTE
        Fecha = Registro
            AA: N(4)
            MM: (1..12)
            DD: (1..31)
        FinRegistro

        Cliente = Registro
            Clave = Registro
                IdSucursal: N(2)
                IdCliente: N(5)
            FinRegistro
            NomyAp: AN(30)
            SaldoFech: N(7)
            FechAlt: Fecha
            FechBaj: Fecha
        FinRegistro

        ArchMae,ArchAct: archivo de Cliente ordenado por Clave
        RegMae: Cliente
        
        Movimientos = Registro
            Clave = Registro
                IdSucursal: N(2)
                IdCliente: N(5)
            FinRegistro
            CodMov: (0..99)
            NomyAp: AN(30)
            FechMov: Fecha
            Monto: N(7)
            Detalle: AN(30)
            Categoria: (1..6)
            Tipo: {"I","E"}
        FinRegistro

        ArchMov: archivo de Movimientos ordenado por Clave, CodMov
        RegMov: Movimientos

        Procedimiento LeerMae() es
            Leer(ArchMae,RegMae)
            Si FDA(ArchMae) hacer
                RegMae.Clave:= HV
            FinSi 
        FinProcedimiento

        Procedimiento LeerMov() es
            Leer(ArchMov,RegMov)
            Si FDA(ArchMov) hacer
                RegMov.Clave:= HV
            FinSi 
        FinProcedimiento 

        CantBaja: entero

    PROCESO
        Abrir E/ (ArchMae)
        Abrir E/ (ArchMov)
        Abrir /S (ArchAct)
        LeerMae()
        LeerMov()
        CantBaja:= 0

        Mientras (RegMae.Clave <> HV) o (RegMov.Clave <> HV) hacer
            Si (RegMae.Clave < RegMov.Clave) entonces
                Grabar(ArchAct,RegMae)
                LeerMae()
            Sino
                Si (RegMae.Clave = RegMov.Clave) entonces
                    Si (RegMov.CodMov = 0) entonces
                        Escribir("Error, no se puede hacer alta, el cliente ya existe")
                    Sino
                        Si (RegMov.CodMov >= 1) y (RegMov.CodMov <= 98) entonces
                            Si (RegMov.Tipo = "I") entonces
                                RegMae.SaldoFech:= RegMae.SaldoFech + RegMov.Monto
                            Sino
                                RegMae.SaldoFech:= RegMae.SaldoFech - RegMov.Monto
                            FinSi
                        Sino
                            RegMae.FechBaj:= RegMov.FechMov
                            CantBaja:= CantBaja + 1
                    FinSi
                    Grabar(ArchAct,RegMae)
                    LeerMae()
                    LeerMov()
                Sino
                    Si (RegMov.CodMov = 0) entonces
                        RegMae.Clave:= RegMov.Clave
                        RegMae.NomyAp:= RegMov.NomyAp 
                        RegMae.SaldoFech:= RegMov.Monto
                        RegMae.FechAlt:= RegMov.FechMov
                        RegMae.FechBaj:= " "
                        Grabar(ArchAct,RegMae)
                    Sino
                        Si (RegMov.CodMov = 99) entonces
                            Escribir("Error, no se puede hacer baja, el cliente no existe")
                        Sino
                            Escribir("Error, no se puede hacer modificacion, el cliente no existe")
                        FinSi
                    FinSi
                    LeerMov()
                FinSi
            FinSi
        FinMientras
        Escribir("Un total de ", CantBaja, " clientes se dieron de baja")
        Cerrar(ArchMae)
        Cerrar(ArchMov)
        Cerrar(ArchAct)
    FinProceso
FINACCION

# EJERCICIO 2

Accion Ej2 es
    AMBIENTE
        Fecha = Registro
            AA: N(4)
            MM: (1..12)
            DD: (1..31)
        FinRegistro

        Cliente = Registro
            IdSucursal: (1..15)
            IdCliente: N(5)
            NomyAp: AN(30)
            SaldoFech: N(7)
            FechAlt: Fecha
            FechBaj: Fecha
        FinRegistro

        ArchMae: archivo de Cliente ordenado por IdSucursal, IdCliente
        RegMae: Cliente

        Sucursales = Registro
            IdSucursal: (1..15)
            NomSucursal: AN(30)
            Direccion: AN(30)
            Localidad: AN(30)
        FinRegistro

        ArchIndex: archivo de Sucursales indexado por IdSucursal
        RegIndex: Sucursales

        A: arreglo de (1..16,1..4) de entero

        i,j: entero

        ResSuc: (1..15)

    PROCESO
        Abrir E/ (ArchMae)
        Abrir E/ (ArchIndex)
        Leer(ArchMae,RegMae)
 
        Para i:= 1 a 16 hacer
            Para j:= 1 a 4 hacer
                A[i,j]:= 0
            FinPara
        FinPara

        Escribir("Nombre sucursal | Categoria diamante | Categoria oro | Categoria estandar | Totales por sucursal")
        i:= 1

        Mientras NFDA(ArchMae) hacer
            ResSuc:= RegMae.IdSucursal

            Mientras (ResSuc = RegMae.IdSucursal) y (NFDA(ArchMae)) hacer
                Si (RegMae.FechBaj <> " ") entonces
                    A[16,4]:= A[16,4] + 1
                    Si (RegMae.SaldoFech < 100000) entonces
                        A[i,3]:= A[i,3] + 1
                        A[16,3]:= A[16,3] + 1
                        A[i,4]:= A[i,4] + 1
                    Sino
                        Si (RegMae.SaldoFech < 1500000) entonces
                            A[i,2]:= A[i,2] + 1
                            A[16,2]:= A[16,2] + 1
                            A[i,4]:= A[i,4] + 1 
                        Sino 
                            A[i,1]:= A[i,1] + 1
                            A[16,1]:= A[16,1] + 1
                            A[i,4]:= A[i,4] + 1
                        FinSi
                    FinSi
                FinSi
                Leer(ArchMae,RegMae)
            FinMientras

            RegIndex.IdSucursal:= ResSuc
            Leer(ArchIndex.RegIndex)

            Escribir(RegIndex.NomSucursal, " | ", A[i,1], " | ", A[i,2], " | ", A[i,3], " | ", A[i,4])

            i:= i + 1
        FinMientras

        Escribir("Totales por categoria | ", A[1,16], " | ", A[2,16], " | ", A[3,16], " | ", A[4,16])
        Cerrar(ArchMae)
        Cerrar(ArchIndex)
    FinProceso
FINACCION