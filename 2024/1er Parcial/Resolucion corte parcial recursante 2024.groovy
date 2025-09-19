Accion "Corte" es;

Peaje = registro  // Archivo de Entrada
    : n(4)
    Mes: 1...12
    Dia: 1...31
    Categoria: an(30)
    Patente: an(30)
    Cantidad_de_Pases: n(10)
fin regiAñostro

Salida = registro // Archivo de Salida
    Año: n(4)
    Mes: 1...12
    Dia: 1...31
    Categoria: an(30)
    Patente: an(30)
fin registro

ArchEntrada: Archivo de Peaje ordenado Año,Mes,Dia,Categoria,Patente // Variable que toma el formato del archivo de entrada
RegEntrada: Peaje //Recorre el archivo de entrada
ArchSalida: Archivo de Salida  // Variable que toma el formato del archivo de salida
RegSalida: Salida // Se va a usar para guardar todo en la salida

// resguardos para comprobar los cortes
res_año: n(4)  
res_mes: 1...12
res_dia: 1...31

contdia,contmes,contaño,totgeneral: entero // contadores para contar la cantidad de vehiculos que pasaron mas 2 de veces

AñoUsuario: n(4) 
MesUsuario: 1...12
DíaUsuario: 1...31

Procedimiento cortedia() es
    Esc("El dia", res_dia, "cant de autos que pasaron mas de 2", contdia) // mostramos la cantidad de autos que pasaron más de 2 veces en el dia
    contmes:= contmes + contdia // pasa al contador de mayor nivel 
    contdia:= 0 // puesto a 0 del contador del nivel 
    res_dia:= RegEntrada.Dia // cambio del resguardo
Fin Procedimiento

Procedimiento cortemes() es
    cortedia() // llama al corte de menor nivel 
    Esc("El mes", res_mes, "cant de autos que pasaron mas de 2", contmes) // mostramos la cantidad de autos que pasaron mas de 2 veces en el mes
    contaño:= contaño + contmes // pasa al de mayor nivel
    contmes:= 0 // puesta a 0 el del nivel 
    res_mes:= RegEntrada.Mes //  cambio del resguardo
Fin Procedimiento

Procedimiento corteaño() es
    cortemes() // llama al corte de menor nivel
    Esc("El año", res_año, "cant de autos que pasaron mas de 2", contaño) // mostramos la cantidad de autos que pasaron mas de 2 veces en el año
    totgeneral:= totgeneral + contaño
    contaño:= 0
    res_año:= RegEntrada.Año
Fin Procedimiento

Proceso
Abrir e/ (ArchivoEntrada)  // Abrimos archivo de entrada
Leer(ArchEntrada,RegEntrada) // Nos ponemos en el primer registro
Abrir /s (ArchSalida) // Creamos la salida
// Asignamos los valores del archivo de entrada a los resguardos
res_año:= RegEntrada.Año
res_mes:= RegEntrada.Mes
res_dia:= RegEntrada.Dia
// contadores a 0
contdia:= 0
contmes:= 0
contaño:= 0

Esc("Ingrese el Año,Mes,Dia para el cual desea generar el archivo")
Leer(AñoUsuario,MesUsuario,DíaUsuario)

Mientras nfda(ArchivoEntrada) hacer
    Si res_año <> RegEntrada.Año entonces // comparamos si el resguardo es igual que en donde estamos parados en el archivo
        corteaño()
    Si no
        Si res_mes <> RegEntrada.Mes entonces 
            cortemes()
        Si no
            Si res_dia <> RegEntrada.Dia entonces
                cortedia()
            Fin Si
        Fin Si
    Fin si

    Si RegEntrada.Cantidad_de_Pases > 2 entonces // comprobamos si el auto paso mas de 2 veces
      contdia:= contdia + 1 // contamos en el de menor nivel
    Fin si

    Si RegEntrada.Año = AñoUsuario y RegEntrada.Mes = MesUsuario y RegEntrada.Dia = DiaUsuario entonces  //comprabamos que el Año,Mes y Dia sean el mismo que ingreso el usuario
        // Asignacion campo a campo ya que el formato del archivo de entrada es distinto al de salida
        RegSalida.Año:= RegEntrada.Año
        RegSalida.Mes:= RegEntrada.Mes
        RegSalida.Dia:= RegEntrada.Dia
        RegSalida.Categoria:= RegEntrada.Categoria
        RegSalida.Patente:= RegEntrada.Patente
        Grabar(ArchSalida,RegSalida)
    Fin si
    Leer(ArchEntrada,RegEntrada) // avanzamos al segundo registro
fIN Mientras
corteaño()

cerrar(ArchEntrada)
cerrar(ArchivoSalida)

Fin proceso