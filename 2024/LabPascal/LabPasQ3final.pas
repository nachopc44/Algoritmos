//Una veterinaria tiene registro de sus pacientes en el archivo animales.txt que contiene los nombres de los animales (termina con %), 
//si es perro (p) o gato (g) y su edad (dos caracteres).
//PREGUNTA: ¿Porcentaje de perros?

program PorcentajePerros;

uses
  SysUtils;

var
  archivo: TextFile;
  linea: String;
  nombre: String;
  tipo: Char;
  edad: String[2];
  totalAnimales, totalPerros: Integer;
  i, longitud: Integer;

begin
  totalAnimales := 0;
  totalPerros := 0;

  Assign(archivo, 'animales.txt');
  Reset(archivo);

  ReadLn(archivo, linea);
  Close(archivo);

  longitud := Length(linea);
  i := 1;
  while i <= longitud do
  begin
    nombre := '';
    while (i <= longitud) and (linea[i] <> '%') do
    begin
      nombre := nombre + linea[i];
      Inc(i);
    end;
    Inc(i); 
    
    if i > longitud then Break;
    
    tipo := linea[i];
    Inc(i); 
    Inc(i); 

    if i > longitud then Break;

    edad := linea[i] + linea[i + 1];
    Inc(i, 2); 

    Inc(totalAnimales);
    if tipo = 'p' then
      Inc(totalPerros);

    Inc(i);
  end;

  if totalAnimales > 0 then
    WriteLn('Porcentaje de perros: ', (totalPerros / totalAnimales) * 100:0:2, '%')
  else
    WriteLn('No hay animales en el registro.');
end.
