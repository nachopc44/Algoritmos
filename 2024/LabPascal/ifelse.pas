program ifelse;

var
n1: integer;
n2: integer;

begin
    writeln('Ingresar un numero');
    readln(n1);
    writeln('Ingresar otro numero');
    readln(n2);
    if n1 > n2 then
        writeln('El primer valor es mayor')
    else if n1 < n2 then
        writeln('El segundo valor es mayor')
    else
        writeln('Son iguales')
end.