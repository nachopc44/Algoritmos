' IDEM 2.21 pero suponiendo que hay mas de un registro de notificaciones por cada registro de amigos.

' 2.21:
' En un práctico para la Facultad un grupo de alumnos debe implementar una Red Social llamada UTNBook. Para lo cual debe utilizar los siguientes archivos:

' AMIGOS Ordenado por Cod_Usuario y Cod_Amigo
' Cod_Usuario | Cod_Amigo | Fecha_Amistad | Mensaje_Muro

' Cada registro indica la fecha desde que los usuarios son amigos y el último mensaje que un amigo ha escrito en el muro del usuario.

' NOTIFICACIONES Ordenado por Cod_Usuario y Cod_Amigo
' Cod_Usuario | Cod_Amigo | Cod_Movimiento | Fecha_Amistad | Mensaje_Muro

' Periódicamente se debe actualizar el archivo Amigos, con el fin de que refleje las amistades que posee cada usuario. En el archivo notificaciones pueden existir tres tipos de acciones: la solicitud de una amistad (Cod_mov = 'A'); la eliminación de una amistad (Cod_mov = 'B'); o la información de un mensaje que un amigo ha escrito en el muro del usuario (Cod_mov = 'M'). Considerar que la eliminación de una amistad implica la baja física de un registro y que hay un solo registro de Notificaciones por cada registro de Amigo.

Accion 2225 es
    AMBIENTE
        Fecha = Registro
            AA: N(4)
            MM: 1..12
            DD: 1..31
        FinRegistro

        Amigos = Registro
            Clave = Registro
                Cod_Usuario: N(4)
                Cod_Amigo: N(4)
            FinRegistro
            Fecha_Amistad: Fecha
            Mensaje_Muro: AN(30)
        FinRegistro

        Mae, MaeS: archivo de Amigos ordenado por Clave
        RegMae, aux: Amigos

        Notificaciones = Registro
            Clave = Registro
                Cod_Usuario: N(4)
                Cod_Amigo: N(4)
            FinRegistro
            Cod_Movimiento: {"A","B","M"}
            Fecha_Amistad: Fecha
            Mensaje_Muro: AN(30)
        FinRegistro

        Mov: archivo de Notificaciones ordenado por Clave
        RegMov: Notificaciones

        BajaFisica: booleano

        Procedimiento LeerMae() es
            Leer(Mae,RegMae)
            Si FDA(Mae) entonces
                RegMae.Clave:= HV
            FinSi
        FinProcedimiento

        Procedimiento LeerMov() es
            Leer(Mov,RegMov)
            Si FDA(Mov) entonces
                RegMov.Clave:= HV
            FinSi
        FinProcedimiento        

    PROCESO
        Abrir E/ (Mae); LeerMae()
        Abrir E/ (Mov); LeerMov()
        Abrir /S (MaeS)

        Mientras (RegMae.Clave <> HV) o (RegMov.Clave <> HV) hacer
            Si (RegMae.Clave < RegMov.Clave) entonces
                Grabar(MaeS,RegMae)
                LeerMae()
            Sino
                Si (RegMae.Clave = RegMov.Clave) entonces
                    aux:= RegMae
                    BajaFisica:= Falso
                    Mientras (RegMae.Clave = RegMov.Clave) hacer
                        Segun RegMov.Cod_Movimiento hacer
                            = "M": aux.Mensaje_Muro:= RegMov.Mensaje_Muro
                            = "B": BajaFisica:= Verdadero
                            = "A": Escribir("Error, no se admite alta de usuario que ya existe")
                        FinSegun
                        LeerMov()
                    FinMientras

                    Si (NO BajaFisica) entonces
                        Grabar(MaeS,aux)
                    FinSi
                    LeerMae()
                Sino 'RegMae>RegMov
                    aux.Clave:= RegMov.Clave
                    aux.Fecha_Amistad:= RegMov.Fecha_Amistad
                    aux.Mensaje_Muro:= RegMov.Mensaje_Muro
                    LeerMov()

                    BajaFisica:= Falso

                    Mientras (aux.Clave = RegMov.Clave) hacer
                        Segun RegMov.Cod_Movimiento hacer
                            = "M": aux.Mensaje_Muro:= RegMov.Mensaje_Muro
                            = "B": BajaFisica:= Verdadero
                            = "A": Escribir("Error, no se admite alta de usuario que ya existe")
                        FinSegun
                        LeerMov()
                    FinMientras

                    Si (NO BajaFisica) entonces
                        Grabar(MaeS,aux)
                    FinSi
                FinSi
            FinSi
        FinMientras
    
    Cerrar(Mae)
    Cerrar(MaeS)
    Cerrar(Mov)
FINACCION