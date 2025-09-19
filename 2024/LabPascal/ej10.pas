program ej10;

var
LadoCuadrado, perimetro, superficie: integer;

begin
    write('Ingresa la medida de un lado del cuadrado: ');
    read(LadoCuadrado);
    perimetro:= LadoCuadrado*4;
    superficie:= LadoCuadrado*LadoCuadrado;
    writeln('La superficie del cuadrado es: ', superficie,'. Y el perimetro es: ', perimetro);
end.