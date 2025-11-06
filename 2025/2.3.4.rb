# Crear un algoritmo que simule el trabajo de una caja de supermercado. El algoritmo debe permitir imprimir el ticket de compra y realizar el descuento de stock del producto. Al generar el comprobante del ticket debe guardar los datos en los archivos TICKET y DETALLE_TICKET (el cliente es: "consumidor final" y el NroTicket se genera automáticamente, mediante la función OBTENER_TICKET). Archivos:

# PRODUCTOS Indexado por Cod_Prod
# Cod_Prod|Nombre|Stock|Precio

# TICKET Indexado por Nro_Ticket
# Nro_Ticket|Fecha|Cliente

# DETALLE_TICKET Indexado por Nro_Ticket
# Nro_Ticket|Nro_Linea|Cod_Prod|Cantidad

# Comprobante:

# Empresa:	....................  CUIT:.... - ............ - ...  Fecha:... / ... / ...
# Cliente	...........................................................................
# Producto	Cantidad  Subtotal
# ........	........  ........
# ........	........  ........
# ........	........  ........
# Total	......................

Accion 234 es 
    AMBIENTE
        Fech = Registro
            AA: N(4)
            MM: 1..12
            DD: 1..31
        FinRegistro

        Productos = Registro
            Cod_Prod: N(4)
            Nombre: AN(30)
            Stock: N(5)
            Precio: N(6)
        FinRegistro

        ArchProd: archivo de Productos indexado por Cod_Prod
        RegProd: Productos  

        Ticket = Registro
            Nro_Ticket: N(5)
            Fecha: Fech
            Cliente: "Consumidor Final"
        FinRegistro

        ArchTick: archivo de Ticket indexado por Nro_Ticket
        RegTick: Ticket

        DetalleTicket = Registro
            Nro_Ticket: N(5)
            Nro_Linea: N(2)
            Cod_Prod: N(4)
            Cantidad: N(4)
        FinRegistro

        ArchDet: archivo de DetalleTicket indexado por Nro_Ticket
        RegDet: DetalleTicket

        Total: real
        Rta: {"si","no"}

    PROCESO
        