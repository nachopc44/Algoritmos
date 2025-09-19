//Crear un programa en Pascal que lea una lista de edades (números enteros) desde un archivo de texto llamado problema31.txt, 
//calcule cuantas personas de la categoría “niños y jóvenes” (de 0 a 14 años) hay, y el porcentaje de “niños y jóvenes” sobre el total de personas. 
//El programa debe mostrar el porcentaje de “niños y jóvenes” sobre el total de personas.
//PREGUNTA: ¿Cuál es el porcentaje de edades que corresponden a “niños y jóvenes” sobre el total de edades del archivo dado?

program PorcNinosYJovenes;

uses SysUtils;

var
  archivoEntrada: TextFile;
  edad: Integer;
  totalPersonas, ninosYJovenes: Integer;
  porcentaje: Real;

begin
  Assign(archivoEntrada, 'C:\Users\nacho\Documents\algoritmos\LabPascal\problema31.txt'); 
  Reset(archivoEntrada);

  totalPersonas := 0;
  ninosYJovenes := 0;

  while not Eof(archivoEntrada) do
  begin
    ReadLn(archivoEntrada, edad); 
    Inc(totalPersonas); 
    if (edad >= 0) and (edad <= 14) then
      Inc(ninosYJovenes); 
  end;

  Close(archivoEntrada);

  if totalPersonas > 0 then
  begin
    porcentaje := (ninosYJovenes / totalPersonas) * 100;
    WriteLn('El porcentaje de niños y jovenes (edades de 0 a 14 años) es: ', porcentaje:0:2, '%');
  end
  else
    WriteLn('No se encontraron edades en el archivo.');
end.