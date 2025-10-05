# Dado un fichero secuencial de Facturas, ordenado por Nro. de Cliente y Nro. de Factura, con la siguiente estructura:

# FACTURAS Ordenado por Nro_Cliente, Nro_Factura
# Nro_Cliente|Nro_Factura|Fecha|Importe

# Se desea un listado con el siguiente detalle:
# Nro. Cliente|Nombre Cliente|Total Facturado|Cantidad de Facturas

# Los datos del cliente se encuentran en un fichero indexado por Nro. de Cliente, que tiene la siguiente estructura:

# CLIENTES Indexado por Nro_Cliente
# Nro_Cliente|Nombre|DNI|CUIT|Domicilio

Accion 231b es 
    AMBIENTE 
        Fech = Registro
            AA: N(4)
            MM: (1..12)
            DD: (1..31)
        FinRegistro

        Facturas = Registro
            Clave = Registro
                Nro_Cliente: N(5)
            FinRegistro
            Nro_Factura: N(6)
            Fecha: Fech
            Importe: N(7)
        FinRegistro

        Arch: archivo de Facturas ordenado por Clave y Nro_Factura
        Reg: Facturas 

        Clientes = Registro
            Clave = Registro
                Nro_Cliente: N(5)
            FinRegistro
            Nombre: AN(30)
            DNI: N(8)
            CUIT: N(11)
            Domicilio: AN(20)
        FinRegistro

        Index: archivo de Clientes indexado por Clave
        RegIndex: Clientes

        TotFact: real
        CantFact: entero

    PROCESO
        Abrir E/(Arch)
        Abrir E/(Index)
        Leer(Arch,Reg)

        Mientras NFDA(Arch) hacer
            TotFact:= 0
            CantFact:= 0

            RegIndex.Clave:= Reg.Clave
            Leer(Index,RegIndex)

            Si Existe entonces
                Mientras NFDA(Arch) y (Reg.Clave = RegIndex.Clave) hacer
                    CantFact:= CantFact + 1
                    TotFact:= TotFact + Reg.Importe
                    Leer(Arch,Reg)
                FinMientras
                Escribir("Nro. Cliente: ", RegIndex.Clave,". Nombre Cliente: ", RegIndex.Nombre,". Total Facturado: ",TotFact,". Cantidad de Facturas: ", CantFact)
            Sino
                Escribir("Error, no existe este cliente")
                Leer(Arch,Reg)
            FinSi
        FinMientras
    
        Cerrar(Arch)
        Cerrar(Index)
    FinProceso
FINACCION