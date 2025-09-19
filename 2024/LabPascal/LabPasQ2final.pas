//Dado un archivo que almacena datos de restaurantes del mundo:
//Pregunta: Cuál es la cantidad de restaurantes que no tienen reserva de mesa (Has table booking = No) pero que sí ofrecen Delivery online (Has Delivery online = Yes)

program Restaurantes;

uses
  SysUtils, Classes;

var
  archivo: TextFile;
  linea: String;
  campos: TStringList;
  nombre, ciudad, direccion, localidad, cocina, reservaMesa, entregaOnline: String;
  contador: Integer;

begin
  Assign(archivo, 'restaurantesMedium.csv');
  Reset(archivo);

  contador := 0;

  ReadLn(archivo, linea);

  campos := TStringList.Create;
  campos.Delimiter := ';';
  campos.StrictDelimiter := True;

  while not EOF(archivo) do
  begin
    ReadLn(archivo, linea);

    campos.DelimitedText := linea;

    nombre := campos[1];
    ciudad := campos[3];
    direccion := campos[4];
    localidad := campos[5];
    cocina := campos[6];
    reservaMesa := campos[7];
    entregaOnline := campos[8];

    if (reservaMesa = 'No') and (entregaOnline = 'Yes') then
    begin
      Inc(contador);
    end;
  end;

  campos.Free;
  Close(archivo);

  WriteLn('Cantidad de restaurantes que no tienen reserva de mesa pero que si ofrecen Delivery online: ', contador);
end.