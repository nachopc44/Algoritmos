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
        ResGrupo: N(12)
        ResCat: 1..50
        ResAnio: N(4)

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

        ADeuda, ACobros, CDeuda, CCobros, GDeuda, GCobros, TDeuda, TCobros, ContDeuda: real
        ResPatenteAct: N(8)

        Procedimiento CorteAnio() es
            Escribir("Para los vehiculos fabricados en el anio ", ResAnio, " hubo $", ACobros, " en cobros y $", ADeuda, " en deudas.")
            CCobros:= CCobros + ACobros
            CDeuda:= CDeuda + ADeuda
            ACobros:= 0
            ADeuda:= 0
            ResAnio:= RegAutos.Clave.Anio_Fab
        FinProcedimiento

        Procedimiento CorteCat() es
            CorteAnio()
            Escribir("Para los vehiculos de categoria ", ResCat, " hubo $", CCobros, " en cobros y $", CDeuda, " en deudas.")
            GCobros:= GCobros + CCobros
            GDeuda:= GDeuda + CDeuda
            CCobros:= 0
            CDeuda:= 0
            ResCat:= RegAutos.Clave.Categoria
        FinProcedimiento

        Procedimiento CorteGrupo() es
            CorteCat()
            Escribir("Para los vehiculos del grupo ", ResGrupo, " hubo $", GCobros, " en cobros y $", GDeuda, " en deudas.")
            TCobros:= TCobros + GCobros
            TDeuda:= TDeuda + GDeuda
            GCobros:= 0
            GDeuda:= 0
            ResGrupo:= RegAutos.Clave.Grupo
        FinProcedimiento

    PROCESO
        Abrir E/ (ArchAutos); Leer(ArchAutos,RegAutos)
        Abrir E/ (ArchDeudas)
        Abrir E/ (ArchCuotas)

        ADeuda:= 0 
        ACobros:= 0 
        CDeuda:= 0 
        CCobros:= 0 
        GDeuda:= 0 
        GCobros:= 0 
        TDeuda:= 0 
        TCobros:= 0 

        ResGrupo:= RegAutos.Clave.Grupo
        ResCat:= RegAutos.Clave.Categoria
        ResAnio:= RegAutos.Clave.Anio_Fab

        Escribir("|CLAVE|DNI|APYNOM|DOMIC|DEUDA|4to TRIMESTRE|")

        Mientras NFDA(ArchAutos) hacer
            ContDeuda:= 0
            Si (RegAutos.Clave.Grupo <> ResGrupo) entonces
                CorteGrupo()
            Sino 
                Si (RegAutos.Clave.Categoria <> ResCat) entonces
                    CorteCat()
                Sino
                    Si (RegAutos.Clave.Anio_Fab <> ResAnio) entonces
                        CorteAnio()
                    FinSi
                FinSi
            FinSi

            RegCuotas.Clave.Grupo:= RegAutos.Clave.Grupo
            RegCuotas.Clave.Categoria:= RegAutos.Clave.Categoria
            RegCuotas.Clave.Anio_Fab:= RegAutos.Clave.Anio_Fab
            Leer(ArchCuotas,RegCuotas)
            ACobros:= ACobros + RegCuotas.Importe

            ResPatenteAct:= RegAutos.Clave.Nro_Patente
            RegDeudas.Clave.Nro_Patente:= RegAutos.Clave.Nro_Patente
            Leer(ArchDeudas,RegDeudas)
            Si Existe entonces 
                Mientras (NFDA(ArchDeudas)) y (RegDeudas.Nro_Patente = ResPatenteAct) hacer
                    ContDeuda:= RegDeudas.Importe
                    Leer(ArchDeudas,RegDeudas)
                FinMientras
                ADeuda:= ADeuda + ContDeuda
            FinSi

            Escribir("|", RegAutos.Clave, "|", RegAutos.DNI, "|", RegAutos.ApyNom, "|", RegAutos.Domicilio, "|", ContDeuda, "|", RegCuotas.Importe, "|")
            Leer(ArchCuotas,RegCuotas)
        FinMientras
        CorteGrupo()
        Escribir("TOTAL | DEUDA: ",TDeuda" | 4to TRIMESTRE: ",TCobros)

        Cerrar(ArchAutos)
        Cerrar(ArchDeudas)
        Cerrar(ArchCuotas)

    FinProcedimiento
FINACCION