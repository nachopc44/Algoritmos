//La empresa Agronorte SA posee los datos de sus empleados en el archivo de registros EMPRESA.dat. El formato del mismo es el siguiente:
//PREGUNTA: ¿Cuál es el porcentaje de empleados de Marketing?

program ContarEmpleadosMarketing;

type
    TEmpleado = record
        Nombre: array[1..50] of char;
        Departamento: array[1..20] of char;
    end;

var
    archivo: file of TEmpleado;
    empleado: TEmpleado;
    totalEmpleados, empleadosMarketing: integer;
    porcentajeMarketing: real;

function CharArrayToString(cArray: array of char): string;
var
    i: integer;
    s: string;
begin
    s := '';
    for i := 1 to Length(cArray) do
    begin
        if cArray[i] = #0 then
            break;
        s := s + cArray[i];
    end;
    CharArrayToString := s;
end;

begin
    Assign(archivo, 'EMPRESA.dat');
    Reset(archivo);

    totalEmpleados := 0;
    empleadosMarketing := 0;

    while not Eof(archivo) do
    begin
        Read(archivo, empleado);
        Inc(totalEmpleados);
        if CharArrayToString(empleado.Departamento) = 'Marketing' then
            Inc(empleadosMarketing);
    end;

    Close(archivo);

    if totalEmpleados > 0 then
        porcentajeMarketing := (empleadosMarketing / totalEmpleados) * 100
    else
        porcentajeMarketing := 0;

    writeln('El porcentaje de empleados en Marketing es: ', porcentajeMarketing:0:2, '%');
end.
