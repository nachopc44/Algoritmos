# Una Municipalidad debe liquidar las patentes de su parque automotor para el cuarto trimestre del año e imprimir un padrón de cobros y deudas, con cortes de importe por grupo, categoría y año de fabricación.

# Los archivos son:

# AUTOS Ordenado por CLAVE
# Grupo N(2)|Categoria 1..50|Anio_Fab N(4)|Nro_Patente N(8)|DNI AN(8)|ApyNom AN(25)|Domicilio AN(30)

# DEUDAS Indexado por CLAVED
# Nro_Patente N(8)|Anio_Deuda N(4)|Trimestre N(1)|Importe N(5,2)

# Para el trimestre actual, la cuota a abonar viene en el siguiente archivo:

# CUOTAS Indexado por CLAVEC
# Grupo N(2)|Categoria 1..50|Anio_Fab N(4)|Importe N(5,2)

# Antes de imprimir el renglón correspondiente a cada nro de patente se debe verificar si existen deudas pendientes, en cuyo caso se sumaran todos los importes adeudados y se consignarán en la columna de deudas.

# PADRON

# CLAVE  DNI  APYNOM  DOMIC  DEUDA	   4to TRIMESTRE
# .....  ...  ......  .....	 $ XXX,XX  $ XXX,XX
#                     TOTAL	 $ XXX,XX  $ XXX,XX

Accion 236 es
    AMBIENTE
        Autos = Registro
            Clave = Registro
                Grupo: N(2)
                Categoria: 1..50
                Anio_Fab: N(4)
                Nro_Patente: N(8)
            FinRegistro
            DNI: N(8)
            ApyNom: AN(25)
            Domicilio: AN(30)
        FinRegistro

        ArchAutos: archivo de Autos ordenado por Clave
        RegAutos: Autos

        Deudas = Registro 
            Clave = Registro 
                Nro_Patente: N(8)
                Anio_Deuda: N(4)
                Trimestre: N(1)
            FinRegistro
            Importe: N(5,2)
        FinRegistro

        ArchDeudas: archivo de Deudas ordenado por Clave
        RegDeudas: Deudas 

        Cuotas = Registro
            Clave = Registro
                Grupo: N(2)
                Categoria: 1..50
                Anio_Fab: N(4)
            FinRegistro
            Importe: N(5,2)
        FinRegistro

        ArchCuotas: archivo de Cuotas ordenado por Clave
        RegCuotas: Cuotas

    PROCESO
        