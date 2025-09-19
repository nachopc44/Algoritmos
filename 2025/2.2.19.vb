' En una Empresa Farmacéutica se posee un archivo MAE_REMEDIOS (ordenado por Clave: Farmacia + Medicamento), el que se actualiza semanalmente, a traves de la información que se encuentra cargada en un archivo de MOVIMIENTOS (ordenado por Clavem: Farmacia + Medicamento, y Cod_Mov), de la siguiente forma:
' Si Clave (MAE_REMEDIOS) es menor que Clavem (MOVIMIENTOS), simplemente se transfieren los datos del Maestro a la salida y se graban.
' Si Clave (MAE_REMEDIOS) es igual a Clavem (MOVIMIENTOS) y el Codmov es 1, se considera error y se lista un mensaje indicando el tipo de error; pero si el Codmov es 2, entonces es un remedio que deja de fabricarse y se transfiere el registro al archivo de Remedios vencidos (REM_VENC) ; pero si el Cod_Mov es 3, se modifica la cantidad actual con la cantidad recibida.
' Si Clave (MAE_REMEDIOS) es mayor que Clavem (MOVIMIENTOS) y el Codmov es 1, se incorpora el remedio a nuestro Vademecum, considerando que la cantidad recibida configura la cantidad actual y la Fecha_Vencimiento es 30 días posterior a la fecha actual; pero si el Codmov es 2 o 3 se considera error y se deben producir los correspondientes mensajes de error.
' Se considera que solo existe un registro de movimiento para cada registro del maestro.
' MAE_REMEDIOS Ordenado por Farmacia y Medicamento
' Farmacia | Medicamento | Cant_Actual | Fecha_Vencimiento
' MOVIMIENTOS Ordenado por Farmacia, Medicamento y Cod_Mov
' Farmacia | Medicamento | Cod_Mov | Cant_Recibida
' REM_VENC Ordenado por Medicamento
' Medicamento | Cant_Vencida

Accion 2219 es 
	AMBIENTE
		Fecha = Registro
			AA: N(4)
			MM: 1...12 
			DD:1...31
		FinRegistro

		FechaActual: Fecha

		MAE_REMEDIOS = Registro 
			Clave = Registro
				Farmacia: AN(30)
				Medicamento: AN(30)
			FinRegistro
			Cant_Actual: N(4)
			Fecha_Vencimiento: Fecha
		FinRegistro

		Mae, MaeS: archivo de MAE_REMEDIOS ordenado por Clave
		RegMae: MAE_REMEDIOS

		MOVIMIENTOS = Registro
			Clave = Registro
				Farmacia: AN(30)
				Medicamento: AN(30)
			FinRegistro
			Cod_Mov: 1...3
			Cant_Recibida: N(4)
		FinRegistro

		Mov: archivo de MOVIMIENTOS ordenado por Clave y Cod_Mov
		RegMov: MOVIMIENTOS

		REM_VENC = Registro
			Medicamento: AN(30)
			Cant_Vencida: N(4)
		FinRegistro

		Vencidos: archivo de REM_VENC
		RegVen: REM_VENC

		Procedimiento LeerMov() es
			Leer(Mov, RegMov)
			Si FDA(Mov) entonces
				RegMov.Clave:= HV
			FinSi 
		FinProcedimiento

		Procedimiento LeerMae() es
			Leer(Mae, RegMae)
			Si FDA(Mae) entonces
				RegMae.Clave:= HV
			FinSi
		FinProcedimiento

	PROCESO
		Abrir E/ (Mae); LeerMae()
		Abrir E/ (Mov); LeerMov()
		Abrir /S (Vencidos)
		Abrir /S (MaeS)

		Escribir("Ingresar la fecha actual (DD MM AA)")
		Leer(FechaActual.DD, FechaActual.MM, FechaActual.AA)

		Mientras (RegMae.Clave <> HV) o (RegMov.Clave <> HV) hacer
			Si RegMae.Clave < RegMov.Clave entonces
				Grabar(MaeS,RegMae)
				LeerMae()
			Sino 
				Si RegMae.Clave = RegMov.Clave entonces
					Si RegMov.Cod_Mov = 1 entonces
						Escribir("Error, no se puede hacer un alta")
						Grabar(MaeS,RegMae)
					Sino
						Si RegMov.Cod_Mov = 2 entonces
							RegVen.Medicamento:= RegMae.Clave.Medicamento
							RegVen.Cant_Vencida:= RegMae.Cant_Actual
							Grabar(Vencidos,RegVen)
						Sino 'Cod_Mov = 3
							RegMae.Cant_Actual:= RegMae.Cant_Actual + RegMov.Cant_Recibida
							Grabar(MaeS,RegMae)
						FinSi
					FinSi
					LeerMae()
					LeerMov()
				Sino //RegMae.Clave > RegMov.Clave
					Si RegMov.Cod_Mov = 1 entonces
						RegMae.Clave:= RegMov.Clave
						RegMae.Cant_Actual:= RegMov.Cant_Recibida
						RegMae.Fecha_Vencimiento:= FechaActual
						RegMae.Fecha_Vencimiento.MM:= FechaActual.MM + 1
						Si (RegMae.Fecha_Vencimiento.MM > 12) entonces
							RegMae.Fecha_Vencimiento.AA:= FechaActual.AA + 1
							RegMae.Fecha_Vencimiento.MM:= 1
						FinSi
						Grabar(MaeS,RegMae)
					Sino
						Si RegMov.Cod_Mov = 2 entonces
							Escribir("No se puede hacer baja")
						Sino
							Escribir("No se puede hacer modificacion")
						FinSi
					FinSi
					LeerMov()
				FinSi
			FinSi
		FinMientras
	
		Cerrar(Mae)
		Cerrar(MaeS)
		Cerrar(Mov)
		Cerrar(Vencidos)
	FinProceso
FINACCION