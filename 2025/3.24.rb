# Se cuenta con información acerca de los cajeros de un Supermercado, el cual se halla estructurado en 10 cajas registradoras. Dicha información está registrada en una secuencia que contiene Apellido y Nombre del empleado, número de caja que tiene asignada, importe facturado y horario de facturación; la secuencia está ordenada alfabéticamente por Apellido y Nombre. Se solicita una estadística de los importes facturados, discriminado por número de caja y franja de horas y además los montos totales, según el siguiente formato:

# | Cajas         | 8-10 | 10-12 | 12-16 | 16-18 | 18-20 | Total x Caja |
# | ------------- | ---- | ----- | ----- | ----- | ----- | ------------ |
# | 1             | ..   | ..    | ..    | ..    | ..    | ..           |
# | ..            | ..   | ..    | ..    | ..    | ..    | ..           |
# | 10            | ..   | ..    | ..    | ..    | ..    | ..           |
# | Total x horas | ..   | ..    | ..    | ..    | ..    | ..           |

Accion 324 es 
    AMBIENTE
        Super = Registro 
            ApyNom: AN(30)
            NroCaja: (1..10)
            ImpFact: N(7)
            HoraFact: N(4)
        FinRegistro

        Arch: archivo de Super ordenado por ApyNom
        Reg: Super

        A: arreglo de (1..11,1..6)
        i,j:entero

    PROCESO
        Abrir E/ (Arch)
        Leer(Arch,Reg)

        Para i:= 1 a 11 hacer
            Para j:= 1 a 6 hacer
                A[i,j]:= 0
            FinPara
        FinPara

        Mientras NFDA(Arch) hacer
            i:= Reg.NroCaja
            Si (Reg.HoraFact >= 8) y (Reg.HoraFact < 10) entonces
                j:= 1
            Sino
                Si (Reg.HoraFact >= 10) y (Reg.HoraFact < 12) entonces
                    j:= 2
                Sino 
                    Si (Reg.HoraFact >= 12) y (Reg.HoraFact < 16) entonces
                        j:= 3
                    Sino
                        Si (Reg.HoraFact >= 16) y (Reg.HoraFact < 18) entonces
                            j:= 4
                        Sino
                            j:= 5
                        FinSi
                    FinSi
                FinSi
            FinSi

            A[i,j]:= A[i,j] + Reg.ImpFact
            A[11,j]:= A[11,j] + Reg.ImpFact
            A[i,6]:= A[i,6] + Reg.ImpFact
            A[11,6]:= A[11,6] + Reg.ImpFact

            Leer(Arch,Reg)
        FinMientras
    FinProceso
FINACCION