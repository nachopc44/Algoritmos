(*Esto es un comentario*)
program ejcase;

var 
n: integer;

begin
    writeln('Decime un numero del 1 al 3');
    readln(n);

    case n of
        1: writeln('Uno');
        2: writeln('Dos');
        3:writeln('Tres');
        else writeln('Numero incorrecto');
    end;
end.