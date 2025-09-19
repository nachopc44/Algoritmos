//Dado un archivo de registros “LD05.dat” con información del inventario de productos de un supermercado, con el siguiente formato:
//form_reg = registro
        //codigo_producto: entero;
        //categoria: entero; // 1 - Verduleria, 2 - Electronica, 3 - Limpieza, 4 - Juguetes
        //cantidad_existente: entero;
        //stock_seguridad: entero;
    //fin;

//PREGUNTA: ¿Cuál es la categoría con mayor cantidad de stock?

program MayorStock;

type
  form_reg = record
    codigo_producto: Integer;
    categoria: Integer; 
    cantidad_existente: Integer;
    stock_seguridad: Integer;
  end;

var
  archivo: File of form_reg;
  registro: form_reg;
  totalStock: array[1..4] of Integer;
  i, categoriaMayor: Integer;
  nombreCategoria: array[1..4] of String;

begin
  for i := 1 to 4 do
    totalStock[i] := 0;

  nombreCategoria[1] := 'Verduleria';
  nombreCategoria[2] := 'Electronica';
  nombreCategoria[3] := 'Limpieza';
  nombreCategoria[4] := 'Juguetes';

  Assign(archivo, 'LD05.dat');
  Reset(archivo);

  while not EOF(archivo) do
  begin
    Read(archivo, registro);
    totalStock[registro.categoria] := totalStock[registro.categoria] + registro.cantidad_existente;
  end;

  Close(archivo);

  categoriaMayor := 1;
  for i := 2 to 4 do
  begin
    if totalStock[i] > totalStock[categoriaMayor] then
      categoriaMayor := i;
  end;

  WriteLn('La categoria con mayor cantidad de stock es: ', nombreCategoria[categoriaMayor], ' con ', totalStock[categoriaMayor], ' unidades.');
end.