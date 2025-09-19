program CensoChaco;

var
  archivo: TextFile;
  linea: string;
  Nro_Vivienda: string;
  Tipo_vivienda: char;
  Condicion_Vivienda: char;
  totalParticulares: Integer;
  muyBuenasParticulares: Integer;
  porcentaje: Real;
  i: Integer;

begin
  Assign(archivo, 'C:\Users\nacho\Documents\algoritmos\LabPascal\censo_phv.txt');
  Reset(archivo);
  totalParticulares:=0;
  muyBuenasParticulares:=0;
  linea:=0;

  while not Eof(archivo) do
  begin
    Readln(archivo, linea);
    i := 1;
    while i <= Length(linea) do
    begin
      Nro_Vivienda := '';
      while (i <= Length(linea)) and (linea[i] <> '#') do
      begin
        Nro_Vivienda := Nro_Vivienda + linea[i];
        Inc(i);
      end;
      Inc(i); 

      if i <= Length(linea) then
      begin
        Tipo_vivienda := linea[i];
        Inc(i);
      end;

      if i <= Length(linea) then
      begin
        Condicion_Vivienda := linea[i];
        Inc(i);
      end;

      if Tipo_vivienda = 'P' then
      begin
        Inc(totalParticulares);
        if Condicion_Vivienda = 'Y' then
          Inc(muyBuenasParticulares);
      end;
    end;
  end;

  Close(archivo);

  if totalParticulares > 0 then
    porcentaje := (muyBuenasParticulares / totalParticulares) * 100
  else
    porcentaje := 0;

  writeln('Porcentaje de viviendas "particulares" en condición "muy buena": ', porcentaje:0:2, '%');
end.
