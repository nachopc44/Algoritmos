' Una obra social lleva el control de los costos que le insume cada afiliado. Considerando como costos, los pagos que la misma debe realizar (en conceptos de honorarios, pagos a farmacias, etc) por los distintos servicios que el afiliado utiliza. Para esto la empresa cuenta con un archivo COSTOS_POR_AFILIADO, en el cual se registran la cantidad de atenciones y/o servicios que solicita el empleado y el costo total (en pesos) que la empresa debe pagar por estos. Este archivo está conformado por registros con el siguiente formato, y está ordenado Cod_Afiliado

' COSTOS_POR_AFILIADO Ordenado por Cod_Afiliado
' Cod_Afiliado|Fecha_Alta|Fecha_Baja|Cant_Servicios|Costo

' Cada viernes en la organización, se lleva a cabo un proceso de actualización del archivo COSTOS_POR_AFILIADO. Para poder realizarlo se cuenta con un archivo SERVICIOS_SEMANALES, ordenado por cod_afiliado y fecha_at, en el cual se registran los servicios que solicitaron los afiliados durante cada semana. Cada registro de este archivo presenta el siguiente formato,

' SERVICIOS_SEMANALES Ordenado por Cod_Afiliado
' Cod_Afiliado|Fecha_At|Cod_Servicio|Costo

' En el archivo SERVICIOS_SEMANALES puede existir más de un registro por cada afiliado.

' Para realizar el proceso de actualización se deben tener en cuenta las siguientes consideraciones.

' Si algún Cod_Afiliado de serviciosSemanales, no se encuentra en ningún registro del archivo COSTOS_POR_AFILIADO, y el primer Cod_Servicio asociado al mismo es igual a 001 entonces se trata de un nuevo afiliado que fue dado de alta. (Mae>Mov)

' Si Cod_Afiliado de serviciosSemanales es igual al de COSTOS_POR_AFILIADO y el Cod_Servicio es igual a 000 se trata de un afiliado que fue dado de baja y se considera como fecha de baja el valor que reside en Fecha_At. Si en cambio, el Cod_Servicio tiene algún otro valor este representa un servicio o atención que solicitó el afiliado; por lo tanto deben contabilizarse la cantidad de servicios que solicitó; como así también los costos que estos insumen. (Mae=Mov)

' Si algún Cod_Afiliado de COSTOS_POR_AFILIADO no se encuentra en el archivo SERVICIOS_SEMANALES, se trata de un afiliado que no utilizó los servicios en la semana que se realiza la actualización. (Mae<Mov)

' Cualquier otro caso distinto a los considerados anteriormente se toma como un error, y deben ser informados por pantalla; indicando claramente el motivo del error.

Accion 2224 es
    AMBIENTE
        Fecha = Registro
            AA: N(4)
            MM: 1..12
            DD: 1..31
        FinRegistro

        CostoAfiliado = Registro
            Cod_Afiliado: N(5)
            Fecha_Alta: Fecha
            Fecha_Baja: Fecha
            Cant_Servicios: N(3)
            Costo: N(6)
        FinRegistro

        Mae, MaeS: archivo de CostoAfiliado ordenado por Cod_Afiliado
        RegMae, aux: CostoAfiliado

        ServiciosSemanales = Registro
            Cod_Afiliado: N(5)
            Fecha_At: Fecha
            Cod_Servicio: N(3)
            Costo: N(6)
        FinRegistro

        Mov: archivo de ServiciosSemanales ordenado por Cod_Afiliado
        RegMov: ServiciosSemanales

        Procedimiento LeerMae() es
            Leer(Mae,RegMae)
            Si FDA(Mae) entonces
                RegMae.Cod_Afiliado:= HV
            FinSi
        FinProcedimiento

        Procedimiento LeerMov() es
            Leer(Mov,RegMov)
            Si FDA(Mae) entonces
                RegMov.Cod_Afiliado:= HV
            FinSi
        FinProcedimiento

    PROCESO
        Abrir E/ (Mae)
        Abrir E/ (Mov)
        Abrir /S (MaeS)
        LeerMae()
        LeerMov()

        Mientras (RegMae.Cod_Afiliado <> HV) o (RegMov.Cod_Afiliado <> HV) hacer
            Si (RegMae.Cod_Afiliado < RegMov.Cod_Afiliado) entonces
                Grabar(MaeS,RegMae)
                LeerMae()
            Sino
                Si (RegMae.Cod_Afiliado = RegMov.Cod_Afiliado) entonces
                    aux:= RegMae
                    Mientras (aux.Cod_Afiliado = RegMov.Cod_Afiliado) hacer
                        Si (RegMov.Cod_Servicio <> 000) entonces
                            aux.Cant_Servicios:= aux.Cant_Servicios + 1
                            aux.Costo:= aux.Costo + RegMov.Costo
                        Sino
                            aux.Fecha_Baja:= RegMov.Fecha_At
                        FinSi
                        LeerMov()
                    FinMientras
                    Grabar(MaeS,aux)
                    LeerMae()
                Sino 'RegMae>RegMov
                    Si (RegMov.Cod_Servicio = 001) entonces
                        aux.Cod_Afiliado:= RegMov.Cod_Afiliado
                        aux.Fecha_Alta:= RegMov.Fecha_At
                        Mientras (aux.Cod_Afiliado = RegMov.Cod_Afiliado) hacer
                            Si (RegMov.Cod_Servicio = 000) entonces
                                aux.Fecha_Baja := RegMov.Fecha_At
                            Sino
                                aux.Cant_Servicios := aux.Cant_Servicios + 1
                                aux.Costo := aux.Costo + RegMov.Costo
                            FinSi
                            LeerMov()
                        FinMientras
                        Grabar(MaeS,aux)
                        LeerMae()
                    FinSi
                FinSi
            FinSi
        FinMientras

        Cerrar(Mae)
        Cerrar(MaeS)
        Cerrar(Mov)
    FinProceso
FINACCION