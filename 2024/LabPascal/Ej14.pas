program triangulo;

var
tamano, filas, columnas, asteriscos: integer;

begin
    write('Ingresar el tamano del triangulo: ');
    readln(tamano);
    asteriscos:= tamano-1;
    for filas:= 1 to tamano do
        begin
            for columnas:= 1 to asteriscos do
                write('*');
            writeln;
            dec(asteriscos);
        end;
end.