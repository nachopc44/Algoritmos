ACCION CORTE CONTROL ES

AMBIENTE
FECHA1= registro
    Año: N(4)
    Mes: N(2)
    Dia: (2)
FinRegistro

VENTAS = registro
    Provincia: AN(30)
    Ciudad: AN(40)
    Plataforma: AN(15)
    Fecha: FECHA1
    Entradas: N(4)
FinRegistro

SALIDA = registro
    Provincia: AN(30)
    Ciudad:AN(40)
    Entradas: N(4)
Finregistro

ArchE: Archivo de VENTAS ordenado por Provincia, Ciudad, Plataforma y Fecha
RegEntrada: VENTAS
ArchS: Archivo de SALIDA 
RegS: SALIDA

ResgProv: AN(30)
ResgCiud: AN(40)
ResgPlat: AN(15)

TotalProv; TotalCiu; TotalPlat,TotalCiu2,TotPlat2: Entero

Procediento corteplataforma() es
    Esc("el total de ventas de",ResgPlat,"Del 1 de junio al 1 de julio es de:",TotalPlat)//B
    TotalCiu:= TotalCiu + TotalPlat
    TotalCiu2:= TotalCiu2 + TotalPlat2
    TotalPlat:=0
    TotalPlat2:=0
    ResgPlat:= RegE.plataforma
FinProcedimiento

Procedimiento corteCiudad() es
    corteplataforma()
    Esc("el total de ventas de",ResgCiud,"Del 1 de junio al 1 de julio es de:",TotalCiu)// B
    Si TotalCiu2 > 1000 entonces
        RegS.Provincia:= ResgProv 
        RegS.Ciudad:= ResgCiud
        RegS.Entradas:= TotalCiu
        Grabar(ArchS; RegS)
    Finsi
    TotalProv:= TotalProv + TotalCiu
    Totalciu:= 0
    TotalCiu2:= 0
    ResgCiud:= RegE.Ciudad
FinProcedimiento

Procedimiento corteprovincia() es
    corteCiudad()
    TotalProv:= 0
    ResgProv:= RegE.Prov 
FinProcedimiento


Proceso
Abrir E/ (archE)
Leer(ArchE, RegE)
Abrir /S (archS)
ResgProv:= RegE.Prov
ResgCiud:= RegE.Ciu
ResgPlat:= RegE.Plat
TotalProv:=0
TotalCiu:=0
TotalPlat:=0

Mientras NFDA (ArchE) hacer
    Si ResgProv <> RegE.Provincia entonces
       corteprovincia()
    Sino 
       Si ResgCiudad <> RegE.Ciudad entonces
        Corteciudad()
       Sino 
           Si ResgPlat <> RegE.Plataforma entonces
             Corteplataforma()
            Finsi
        Fin si
    Finsi
    Si (RegE.fecha.mes = 6 ) o (RegE.fecha.mes = 7)   entonces
        TotalPlat:= TotalPlat + RegE.Entradas
    Finsi
    TotalPlat2:= TotalPlat2 + RegE.Entradas
    Leer(ArchE,RegE)
Finmientras
corteprovincia()
Cerrar(archS)
Cerrar(archE)

Fin Proceso