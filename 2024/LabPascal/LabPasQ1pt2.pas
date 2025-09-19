program TransaccionesBanco;

uses
  SysUtils;

var
  archivo: TextFile;
  linea: string;
  i: Integer;
  numTransaccion: string;
  tipo, validez: char;
  depositosValidos, depositosNoValidos, retirosValidos, retirosNoValidos: Integer;
  maxTransacciones: Integer;
  tipoMaxTransacciones: string;

begin
  depositosValidos := 0;
  depositosNoValidos := 0;
  retirosValidos := 0;
  retirosNoValidos := 0;

  Assign(archivo, 'C:\Users\nacho\Documents\algoritmos\LabPascal\PROBLEMA4.txt'); 
  Reset(archivo);

  while not Eof(archivo) do
  begin
    Readln(archivo, linea);
    i := 0;
    while i <= Length(linea) do
    begin
      numTransaccion := '0';
      while (i <= Length(linea)) and (linea[i] <> '#') do
      begin
        numTransaccion := numTransaccion + linea[i];
        Inc(i);
      end;
      Inc(i); 

      if i <= Length(linea) then
      begin
        tipo := linea[i];
        Inc(i);
      end;

      if i <= Length(linea) then
      begin
        validez := linea[i];
        Inc(i);
      end;

      if tipo = 'D' then
      begin
        if validez = 'S' then
          Inc(depositosValidos)
        else if validez = 'N' then
          Inc(depositosNoValidos);
      end
      else if tipo = 'R' then
      begin
        if validez = 'S' then
          Inc(retirosValidos)
        else if validez = 'N' then
          Inc(retirosNoValidos);
      end;
    end;
  end;

  Close(archivo);

  maxTransacciones := depositosNoValidos;
  tipoMaxTransacciones := 'Depositos no validos';

  if depositosValidos > maxTransacciones then
  begin
    maxTransacciones := depositosValidos;
    tipoMaxTransacciones := 'Depositos validos';
  end;

  if retirosNoValidos > maxTransacciones then
  begin
    maxTransacciones := retirosNoValidos;
    tipoMaxTransacciones := 'Retiros no validos';
  end;

  if retirosValidos > maxTransacciones then
  begin
    maxTransacciones := retirosValidos;
    tipoMaxTransacciones := 'Retiros validos';
  end;

  writeln('El tipo de operacion con mayor cantidad de transacciones es: ', tipoMaxTransacciones);
end.
