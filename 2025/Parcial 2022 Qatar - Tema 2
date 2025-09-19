Accion SecQatar es 
	AMBIENTE
		secE: secuencia de caracter
		v1: caracter
		secS: secuencia de entero
		ContEm, ContPa, ContPr, ContUs: entero
		ZonaUs: caracter

	PROCESO
		arr(secE)
		avz(secE,v1)
		crear(secS)
		ContEm:= 0
		ContPa:= 0
		ContPr:= 0

		Mientras NFDS(secE) hacer
			ContEm:= 0
			ContPa:= 0
			ContPr:= 0
			ContUs:= 0

			Escribir("Ingrese la zona que desea analizar")
			Leer(ZonaUs)

			Mientras v1<>"@" hacer
				Mientras v1<>"#" hacer
					avz(secE,v1)
				FinMientras
				avz(secE,v1)
				Mientras v1<>"@" hacer
					Mientras v1<>"_" hacer
						Segun v1 hacer
							="E": ContEm:= ContEm + 1
							="P": ContPa:= ContPa + 1
							="Y": ContPr:= ContPr + 1
						FinSegun
						Mientras v1<>"%" hacer
							avz(secE,v1)
						FinMientras
						avz(secE,v1)
						Si v1=ZonaUs entonces
							ContUs:= ContUs + 1
						FinSi
						Mientras v1<>"_" hacer
							avz(secE,v1)
						FinMientras
					FinMientras
					avz(secE,v1)
				FinMientras
				avz(secE,v1)
				Grabar(secS,ContEm+ContPa+ContPr)
				Grabar(secS,-1) //Marca de separacion entre estadios 
				Escribir("Hubieron ", ContEm, " reservas de empresa, ", ContPa, " de particular y ", ContPr, " de protocolo. De las cuales ", ContUs, " pertenecen a la zona ", ZonaUs)
			FinMientras
			Cerrar(secE)
			Cerrar(secS)
		FinMientras
	FinProceso
FINACCION

Accion CorQatar es 
	AMBIENTE
		Entrada = Registro
			Cod_cadena: AN(15)
			Nivel_hotel: (1...5)
			Cod_hotel: N(4)
			Nom_hotel: AN(50)
			Es_ciud_sede: booleano
			Cant_hab: N(4)
		FinRegistro
		
		ArchE: archivo de Entrada ordenado por Cod_cadena, Nivel_hotel
		RegE: Entrada
		ResCad: AN(15)
		ResNiv: (1...5)

		Salida = Registro
			Cod_cadena: AN(15)
			Nivel_hotel: (1...5)
			Cod_hotel: N(4)
			Nom_hotel: AN(50)
			Cant_hab: N(4)
		FinRegistro

		ArchS: archivo de Salida
		RegS: Salida

		ContNiv, ContCad, ContTot: entero

		Procedimiento corteN() es
			Escribir("El total de hoteles de nivel ", ResNiv, " con mas de 300 habitaciones, ubicados en ciudades sedes, es de ", ContNiv)
			ContCad:= ContCad + ContNiv
			ContNiv:= 0
			ResNiv:= RegE.Nivel_hotel
		FinProcedimiento

		Procedimiento corteC() es
			corteN()
			Escribir("El total de hoteles de la cadena ", ResCad, " con mas de 300 habitaciones, ubicados en ciudades sedes, es de ", ContCad)
			ContTot:= ContTot + ContCad
			ContCad:= 0
			ResCad:= RegE.Cod_cadena
		FinProcedimiento

	PROCESO
		Abrir E/ (ArchE)
		Abrir /S (ArchS)
		Leer(ArchE,RegE)

		ContNiv:= 0
		ContCad:= 0
		ContTot:= 0

		ResNiv:= RegE.Nivel_hotel
		ResCad:= RegE.Cod_cadena

		Mientras NFDA(ArchE) hacer
			Si (ResCad<>RegE.Cod_cadena) entonces
				corteC()
			Sino
				Si (ResNiv<>RegE.Nivel_hotel) entonces
					corteN()
				FinSi
			FinSi

			Si RegE.Es_ciud_sede entonces
				RegS.Cod_cadena:= RegE.Cod_cadena
				RegS.Nivel_hotel:= RegE.Nivel_hotel
				RegS.Cod_hotel:= RegE.Cod_hotel
				RegS.Nom_hotel:= RegE.Nom_hotel
				RegS.Cant_hab:= RegE.Cant_hab
				Grabar(ArchS,RegS)
				Si (RegE.Cant_hab>300) entonces
					ContNiv:= ContNiv + 1
				FinSi
			FinSi

			Leer(ArchE,RegE)
		FinMientras

		corteC()

		Escribir("El total general de hoteles con mas de 300 habitaciones, ubicados en ciudades sedes, es de ", ContTot)

		Cerrar(ArchE)
		Cerrar(ArchS)
	FinProceso
FINACCION