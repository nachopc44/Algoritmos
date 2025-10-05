# Dado un fichero secuencial de Facturas, ordenado por Nro. de Cliente y Nro. de Factura, con la siguiente estructura:

# FACTURAS Ordenado por Nro_Cliente, Nro_Factura
# Nro_Cliente|Nro_Factura|Fecha|Importe

# Se desea un listado con el siguiente detalle:
# Nro. Cliente|Nombre Cliente|Numero Factura

# Los datos del cliente se encuentran en un fichero indexado por Nro. de Cliente, que tiene la siguiente estructura:

# CLIENTES Indexado por Nro_Cliente
# Nro_Cliente|Nombre|DNI|CUIT|Domicilio

Accion 231a es 
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

    PROCESO
        Abrir E/(Arch)
        Abrir E/(Index)

        Mientras NFDA(Arch) hacer 
            Leer(Arch,Reg)
            RegIndex.Clave:= Reg.Clave
            Leer(Index,RegIndex)
            Si Existe entonces
                Escribir("Nro. Cliente: ", RegIndex.Clave,". Nombre Cliente: ", RegIndex.Nombre,". Numero Factura: ", Reg.Nro_Factura)
            Sino
                Escribir("No existe este cliente")
            FinSi
        FinMientras

        Cerrar(Arch)
        Cerrar(Index)
    FinProceso
FINACCION