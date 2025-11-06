Accion 235 es
    AMBIENTE
        CabeceraSueldo = Registro
            DNI: N(8)
            Periodo: N(6)
            NroRecibo: N(15)
            ApyNom: AN(50)
            Empresa: AN(50)
        FinRegistro

        ArchCS: archivo de CabeceraSueldo indexado por DNI, Periodo, NroRecibo
        RegCS: CabeceraSueldo

        Recibo = Registro
            NroRecibo: N(15)
            Concepto: N(8)
            Tipo: 0..2
            Monto: N(15,2)
        FinRegistro

        ArchRec: archivo de Recibo indexado por NroRecibo
        RegRec: Recibo

        Cuenta = Registro
            DNI: N(8)
            NroCuenta: N(25)
            Saldo: N(15,2)
        FinRegistro

        ArchCue: archivo de Cuenta indexado por DNI
        RegCue: Cuenta

        Doc, Recibo, i, MM, AA, ResNroRecibo, fecha, fechaact, prom: entero
        preg: {"si","no"}
    
    PROCESO
        Abrir E/ (ArchCS)
        Abrir E/ (ArchRec)
        Abrir E/S (ArchCue)

        Escribir("Desea iniciar? (si,no)")
        Leer(preg)

        Mientras (preg = "si") hacer
            Escribir("Ingresar fecha actual. (AAAA/MM)")
            Leer(AA,MM)
            fechaact:= (AA * 100) + MM
            
            Escribir("Desea analizar un cliente? (si,no)")
            Mientras (preg = "si") hacer
                Escribir("Ingresar DNI de cliente. (XX.XXX.XXX)")
                Leer(Doc)
                