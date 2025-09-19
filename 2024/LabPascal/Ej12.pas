program ej12;

var
n: integer;
suma: integer;

begin
n:=0;
suma:=0;
repeat
    write('Ingresa un numero ');
    readln(n);
    if n>0 then 
        suma:= suma + n
    else 
        writeln('Ingresaste 0 o negativo');
until n<=0;
writeln('La suma de los numeros es: ', suma)
end.