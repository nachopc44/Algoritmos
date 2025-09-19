' En un práctico para la Facultad un grupo de alumnos debe implementar una Red Social llamada UTNBook. Para lo cual debe utilizar los siguientes archivos:
' AMIGOS Ordenado por Cod_Usuario y Cod_Amigo
' Cod_Usuario | Cod_Amigo | Fecha_Amistad | Mensaje_Muro
' Cada registro indica la fecha desde que los usuarios son amigos y el último mensaje que un amigo ha escrito en el muro del usuario.
' NOTIFICACIONES Ordenado por Cod_Usuario y Cod_Amigo
' Cod_Usuario | Cod_Amigo | Cod_Movimiento | Fecha_Amistad | Mensaje_Muro
' Periódicamente se debe actualizar el archivo Amigos, con el fin de que refleje las amistades que posee cada usuario. En el archivo notificaciones pueden existir tres tipos de acciones: la solicitud de una amistad (Cod_mov = 'A'); la eliminación de una amistad (Cod_mov = 'B'); o la información de un mensaje que un amigo ha escrito en el muro del usuario (Cod_mov = 'M'). Considerar que la eliminación de una amistad implica la baja física de un registro y que hay un solo registro de Notificaciones por cada registro de Amigo.

' 2.2.22:
' IDEM ejercicio 2.21 pero agregando al enunciado: “Al finalizar el proceso se desea conocer: el usuario que posee más amigos.”

Accion 2221 es 
    AMBIENTE

        maxAmigos, maxUsuario, usuarioActual, cantActual: entero

        Fecha = Registro
            AA: N(4)
            MM: 1...12
            DD: 1...31
        FinRegistro

        AMIGOS = Registro
            Clave = Registro
                Cod_Usuario: N(4) 
                Cod_Amigo: N(4)
            FinRegistro
            Fecha_Amistad: Fecha
            Mensaje_Muro: AN(30)
        FinMientras

        Mae, MaeS: archivo de AMIGOS ordenado por Clave
        RegMae: AMIGOS 

        NOTIFICACIONES = Registro
            Clave = Registro
                Cod_Usuario: N(4)
                Cod_Amigo: N(4)
            FinRegistro
            Cod_Mov: {"A","M","B"}
            Fecha_Amistad: Fecha
            Mensaje_Muro: AN(30)
        FinRegistro

        Mov: archivo de NOTIFICACIONES ordenado por Clave
        RegMov: NOTIFICACIONES

        Procedimiento ContarAmistad() es 
            Si (RegMae.Cod_Usuario <> usuarioActual) entonces
                Si (cantActual > maxAmigos) entonces
                    maxAmigos:= cantActual
                    maxUsuario:= usuarioActual
                FinSi
                usuarioActual:= RegMae.Cod_Usuario
                cantActual:= 0
            FinSi
            cantActual:= cantActual + 1
        FinProcedimiento

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

        Procedimiento Iguales() es
            Si (RegMov.Cod_Mov = "A") entonces
                Escribir("Error, alta no existe")
            Sino
                Si (RegMov.Cod_Mov = "M") entonces
                    RegMae.Clave:= RegMov.Clave
                    RegMae.Fecha_Amistad:= RegMov.Fecha_Amistad
                    RegMae.Mensaje_Muro:= RegMov.Mensaje_Muro
                    Grabar(MaeS,RegMae)
                    ContarAmistad()
                FinSi
            FinSi
            LeerMae()
            LeerMov()        
        FinProcedimiento

        Procedimiento MaeMayor() es 'Mae>Mov 
            Si (RegMov.Cod_Mov = "A") entonces
                RegMae.Clave:= RegMov.Clave
                RegMae.Fecha_Amistad:= RegMov.Fecha_Amistad
                RegMae.Mensaje_Muro:= RegMov.Mensaje_Muro
                Grabar(MaeS,RegMae)
                ContarAmistad()
            Sino
                Si (RegMov.Cod_Mov = "M") entonces
                    Escribir("Error, modificacion no existe")
                Sino
                    Escribir("Error, baja no existe")
                FinSi
            FinSi
            LeerMov()
        FinProcedimiento

    PROCESO
        Abrir E/ (Mae); LeerMae()
        Abrir E/ (Mov); LeerMov()
        Abrir /S (MaeS)

        maxAmigos:= 0
        maxUsuario:= HV
        cantActual:= 0
        usuarioActual:= HV

        Mientras (RegMae.Clave <> HV) o (RegMov.Clave <> HV) hacer
            Si (RegMae.Clave < RegMov.Clave) entonces
                Grabar(MaeS,RegMae)
                ContarAmistad()
                LeerMae()
            Sino 
                Si (RegMae.Clave > RegMov.Clave) entonces
                    MaeMayor()
                Sino
                    Iguales()
                FinSi
            FinSi
        FinMientras

        Si (cantActual > maxAmigos) entonces
            maxAmigos := cantActual
            maxUsuario := usuarioActual
        FinSi

        Escribir("Usuario con mas amigos: ", maxUsuario, " con ", maxAmigos, " amigos")

        Cerrar(Mae)
        Cerrar(Mov)
        Cerrar(MaeS)
    FinProceso
FINACCION