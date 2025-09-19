program Crucigrama;

uses crt;

const
    N = 7;  
    Palabra1 = 'LAPIZ'; 
    Palabra2 = 'LOBO';  
    Palabra3 = 'GLOBO'; 
    Palabra4 = 'LUPA';  
    Palabra5 = 'CHINA'; 
    
var
    grid: array[1..N, 1..N] of char;
    i, j: integer;
    respuesta: string;
    adivinadas: array[1..5] of boolean;  

procedure InicializarGrid;
begin
    for i := 1 to N do
        for j := 1 to N do
            grid[i, j] := ' ';
    
    grid[1, 1] := '#';
    grid[1, 2] := '#';
    grid[1, 3] := '#';
    grid[1, 4] := '#';
    grid[1, 5] := '#';
    grid[1, 6] := '#';
    grid[1, 7] := '2';
    grid[2, 1] := '#';
    grid[2, 2] := '#';
    grid[2, 3] := '#';
    grid[2, 4] := '1';
    grid[2, 5] := '#';
    grid[2, 6] := '#';
    grid[3, 1] := '#';
    grid[3, 2] := '3';
    grid[4, 1] := '#';
    grid[4, 2] := '#';
    grid[4, 3] := '#';
    grid[4, 5] := '#';
    grid[4, 6] := '#';
    grid[5, 1] := '4';
    grid[5, 6] := '#';
    grid[6, 1] := '5';
    grid[6, 7] := '#';
    grid[7, 1] := '#';
    grid[7, 2] := '#';
    grid[7, 3] := '#';
    grid[7, 5] := '#';
    grid[7, 6] := '#';
    grid[7, 7] := '#';
end;

procedure MostrarGrid;
begin
    for i := 1 to N do
    begin
        for j := 1 to N do
            write(grid[i, j], ' ');
        writeln;
    end;
end;

procedure ColocarPalabra1;
begin
    grid[3, 4] := 'L';
    grid[4, 4] := 'A';
    grid[5, 4] := 'P';
    grid[6, 4] := 'I';
    grid[7, 4] := 'Z';
end;

procedure ColocarPalabra2;
begin
    grid[2, 7] := 'L';
    grid[3, 7] := 'O';
    grid[4, 7] := 'B';
    grid[5, 7] := 'O';
end;

procedure ColocarPalabra3;
begin
    grid[3, 3] := 'G';
    grid[3, 4] := 'L';
    grid[3, 5] := 'O';  
    grid[3, 6] := 'B';
    grid[3, 7] := 'O';
end;

procedure ColocarPalabra4;
begin
    grid[5, 2] := 'L';
    grid[5, 3] := 'U';
    grid[5, 4] := 'P';
    grid[5, 5] := 'A';
end;

procedure ColocarPalabra5;
begin
    grid[6, 2] := 'C'; 
    grid[6, 3] := 'H';
    grid[6, 4] := 'I';
    grid[6, 5] := 'N';
    grid[6, 6] := 'A';
end;

procedure MostrarPistas;
begin
    writeln('Pistas:');
    writeln('Palabras horizontales:');
    writeln('1. Se usa para escribir y se borra con un borrador (5 letras)');
    writeln('3. Es redondo y puede ser de muchos colores, se usa para decorar en fiestas (5 letras)');
    writeln('4. Es un objeto redondo de vidrio que ayuda a ver las cosas en mayor dimension (4 letras)');
    writeln('Palabras verticales:');
    writeln('2. Es un animal salvaje, parecido a un perro, que aulla (4 letras)');
    writeln('5. Es un pais en Asia, conocido por su gran poblacion y la forma de sus ojos (5 letras)');
    writeln('NOTA: Ingrese las respuestas en MAYUSCULAS.');
end;

procedure VerificarPalabras;
begin
    repeat
        writeln('Ingrese la palabra 1 (Se usa para escribir y se borra con un borrador):');
        readln(respuesta);
        if respuesta = Palabra1 then
        begin
            writeln('¡Correcto!');
            ColocarPalabra1;
            adivinadas[1] := true;
        end
        else
            writeln('Palabra incorrecta. Intentalo de nuevo.');
    until adivinadas[1];
    MostrarGrid;

    repeat
        writeln('Ingrese la palabra 2 (Es un animal salvaje, parecido a un perro, que aulla):');
        readln(respuesta);
        if respuesta = Palabra2 then
        begin
            writeln('¡Correcto!');
            ColocarPalabra2;
            adivinadas[2] := true;
        end
        else
            writeln('Palabra incorrecta. Intentalo de nuevo.');
    until adivinadas[2];
    MostrarGrid;

    repeat
        writeln('Ingrese la palabra 3 (Es redondo y puede ser de muchos colores, se usa para decorar en fiestas):');
        readln(respuesta);
        if respuesta = Palabra3 then
        begin
            writeln('¡Correcto!');
            ColocarPalabra3;
            adivinadas[3] := true;
        end
        else
            writeln('Palabra incorrecta. Intentalo de nuevo.');
    until adivinadas[3];
    MostrarGrid;

    repeat
        writeln('Ingrese la palabra 4 (Es un objeto redondo de vidrio que ayuda a ver las cosas en mayor dimesion):');
        readln(respuesta);
        if respuesta = Palabra4 then
        begin
            writeln('¡Correcto!');
            ColocarPalabra4;
            adivinadas[4] := true;
        end
        else
            writeln('Palabra incorrecta. Intentalo de nuevo.');
    until adivinadas[4];
    MostrarGrid;

    repeat
        writeln('Ingrese la palabra 5 (Es un pais en Asia, conocido por su gran poblacion y la forma de sus ojos):');
        readln(respuesta);
        if respuesta = Palabra5 then
        begin
            writeln('¡Correcto!');
            ColocarPalabra5;
            adivinadas[5] := true;
        end
        else
            writeln('Palabra incorrecta. Intentalo de nuevo.');
    until adivinadas[5];
    MostrarGrid;
end;

begin
    clrscr;
    InicializarGrid;
    MostrarPistas;

    for i := 1 to 5 do
        adivinadas[i] := false;

    MostrarGrid;

    VerificarPalabras;
end.