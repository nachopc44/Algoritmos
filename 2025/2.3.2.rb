# Una empresa dispone de un fichero secuencial con datos de sus empleados, ordenado por número de sucursal, y categoría, con los siguientes datos:

# EMPLEADOS Ordenado por Nro_Sucursal, Categoria
# Nro_Sucursal|Categoria (A,B,C)|Nombre_Empleado|Cod_Curso|Tecnico (si,no)

# Y un fichero con datos de cursos, indexado por código de curso:

# CURSO Indexado por Cod_Curso
# Cod_Curso|Nombre|Fecha|Cant_Horas

# Emitir un listado informando:

# Para cada empleado: sucursal, categoría, nombre del empleado y nombre del curso que debe realizar.

# Por sucursal, categoría y toda la empresa:
# Total empleados técnicos
# Total empleados no técnicos
# Total empleados

Accion 232 es 
    AMBIENTE
        Fech = Registro
            AA: N(4)
            MM: 1..12
            DD: 1..31
        FinRegistro

        Empleados = Registro 
            Nro_Sucursal: N(3)
            Categoria: {"A","B","C"}
            Nombre_Empleado: AN(30)
            Cod_Curso: N(3)
            Tecnico: {"si","no"}
        FinRegistro

        ArchEmp: archivo de Empleados ordenado por Nro_Sucursal, Categoria
        RegEmp: Empleados

        Curso = Registro
            Cod_Curso: N(3)
            Nombre: AN(30)
            Fecha: Fech
            Cant_Horas: N(3)
        FinRegistro

        ArchCur: archivo de Curso indexado por Cod_Curso
        RegCur: Curso

        ResSuc: N(3)
        ResCat: {"A","B","C"}

        TotSTec, TotSNoTec, TotCTec, TotCNoTec, TotETec, TotENoTec: entero

        Procedimiento Corte_Categoria es 
            Escribir("Para la categoria ", ResCat, ", la cantidad de empleados tecnicos es de: ", TotCTec, ", de empleados no tecnicos es de: ", TotCNoTec, ", y el total es de:", (TotCTec + TotCNoTec))
            TotSTec:= TotSTec + TotCTec
            TotSNoTec:= TotSNoTec + TotCNoTec
            TotCTec:= 0
            TotCNoTec:= 0
            ResCat:= RegEmp.Categoria
        FinProcedimiento 

        Procedimiento Corte_Sucursal es 
            Corte_Categoria()
            Escribir("Para la sucursal ", ResSuc, ", la cantidad de empleados tecnicos es de: ", TotSTec, ", de empleados no tecnicos es de: ", TotSNoTec, ", y el total es de:", (TotSTec + TotSNoTec))
            TotETec:= TotETec + TotSTec
            TotENoTec:= TotENoTec + TotSNoTec
            TotSTec:= 0
            TotSNoTec:= 0
            ResSuc:= RegEmp.Nro_Sucursal
        FinProcedimiento

    PROCESO
        Abrir E/ (ArchEmp)
        Abrir E/ (ArchCur)
        Leer(ArchEmp,RegEmp)

        TotSTec:= 0
        TotSNoTec:= 0 
        TotCTec:= 0
        TotCNoTec:= 0
        TotETec:= 0
        TotENoTec:= 0

        ResSuc:= RegEmp.Nro_Sucursal
        ResCat:= RegEmp.Categoria

        Escribir("Sucursal | Categoria | Nombre empleado | Nombre curso")

        Mientras (NFDA(ArchEmp)) hacer
            Si (ResSuc <> RegEmp.Nro_Sucursal) hacer
                Corte_Sucursal()
            Sino
                Si (ResCat <> RegEmp.Categoria) hacer
                    Corte_Categoria()
                FinSi
            FinSi

            Si (RegEmp.Tecnico = "si") entonces
                TotCTec:= TotCTec + 1
            Sino
                TotCNoTec:= TotCNoTec + 1
            FinSi

            Leer(ArchCur,Cod_Curso)
            Si Existe entonces
                Escribir(RegEmp.Nro_Sucursal, " | ",RegEmp.Categoria, " | ",RegEmp.Nombre_Empleado, " | ",RegCur.Nombre)
            Sino
                Escribir(RegEmp.Nro_Sucursal, " | ",RegEmp.Categoria, " | ",RegEmp.Nombre_Empleado, " | Ninguno")
            FinSi
            
            Leer(ArchEmp,RegEmp)
        FinMientras

        Corte_Sucursal()
        Escribir("Para la empresa actual, la cantidad de empleados tecnicos es de: ", TotETec, ", de empleados no tecnicos es de: ", TotENoTec, ", y el total es de:", (TotETec + TotENoTec))

        Cerrar(ArchCur)
        Cerrar(ArchEmp)
    FinProceso
FINACCION