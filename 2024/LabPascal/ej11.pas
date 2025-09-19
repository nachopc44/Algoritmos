program ej11;

var
x: integer;

begin
    x:=0;
    while x >= 0 do
        begin
            write('Ingresa un numero: ');
            readln(x);
            if x >= 0 then
                writeln ('La raiz es igual a ', sqrt(X));
        end;
    if x<0 then writeln('No se puede hallar la raiz de un numero negativo');
end.

