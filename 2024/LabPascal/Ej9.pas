program ej9;

var
LadoCuadrado: integer;
perimetro: integer;
superficie: integer;

begin
    write('Ingresa la medida de un lado del cuadrado: ');
    read(LadoCuadrado);
    perimetro:= LadoCuadrado*4;
    superficie:= LadoCuadrado*LadoCuadrado;
    write('La superficie del cuadrado es: ');
    writeln(superficie);
    write('El perimetro del cuadrado es: ');
    writeln(perimetro);
end.