# Los automovilistas pasan por el peaje del Puente Gral. Belgrano y deben pagar según su categoría, pero además, si ya han pasado previamente dentro del día tienen pase libre.
# Teniendo en cuenta el archivo siguiente, construya el algoritmo que realice lo que corresponda: genere el comprobante, indicando el importe a pagar o emita un mensaje indicando que ya pasó anteriormente. Además indique cuales deberían ser los datos de entrada.

# PEAJE Indexado por Patente, Fecha
# Patente XXX-NNN | Fecha N(8) | Ult_Hora N(4) | Costo XXX,XX

# Costo por categoria
# Categoria	 Costo
# 1	         1,20
# 2	         2,50
# 3	         4,00
# 4	         5,00

Accion 233 es 
    AMBIENTE
        Peaje = Registro
            Patente: AN(7)
            Fecha: N(8)
            Ult_Hora: N(4)
            Costo: N(5,2)
        FinRegistro

        Arch: archivo de Peaje indexado por Patente, Fecha
        Reg: Peaje

        fecha: N(8)
        preg: {"si","no"}
        cat: 1..4

    PROCESO
        Abrir E/S (Arch)
        
        Escribir("Ingrese la fecha actual (DDMMAAAA)")
        Leer(fecha)

        Escribir("Desea iniciar? (si,no)")
        Leer(preg)

        Mientras (preg = "si") hacer
            Escribir("Ingresar patente del vehiculo")
            Leer(Arch,Reg.Patente)
            Si (Existe) entonces
                Si (fecha = Reg.Fecha) entonces
                    Escribir("Este vehiculo ya paso anteriormente, no se debe cobrar")
                Sino
                    Reg.Fecha:= fecha
                    Escribir("Ingresar hora actual (HHMM)")
                    Leer(Reg.Ult_Hora)
                    Regrabar(Arch,Reg)
                    Escribir("Importe a pagar: ", Reg.Costo)
                FinSi 
            Sino
                Reg.Fecha:= fecha
                Escribir("Ingresar hora actual (HHMM)")
                Leer(Reg.Ult_Hora)
                Escribir("Ingresar categoria del vehiculo (1,2,3,4)")
                Leer(cat)
                Segun cat hacer
                    = 1: Reg.Costo:= 1,20
                    = 2: Reg.Costo:= 2,50
                    = 3: Reg.Costo:= 4,00
                    = 4: Reg.Costo:= 5,00
                FinSegun
                Escribir("Importe a pagar: ", Reg.Costo)
                Regrabar(Arch,Reg)
            FinSi
            Escribir("Desea continuar? (si,no)")
            Leer(preg)
        FinMientras

        Cerrar(Arch)
    FinProceso
FINACCION