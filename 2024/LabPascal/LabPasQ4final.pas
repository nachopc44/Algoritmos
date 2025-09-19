//Dado un archivo que almacena datos de equipos masculinos de Esports:
//Pregunta: Cuál es la cantidad de equipos que juegan en la Premier League (league_name), 
//en un nivel de liga 2 (league_level) y con un prestigio internacional (international_prestige) mayor a 15

program ContarEquipos;

uses
  SysUtils, Classes;

var
  archivo: TextFile;
  linea: String;
  campos: TStringList;
  leagueName: String;
  leagueLevel, internationalPrestige: Integer;
  contador: Integer;

begin
  contador := 0;

  Assign(archivo, 'Team_Esports.csv');
  Reset(archivo);

  ReadLn(archivo, linea);

  campos := TStringList.Create;
  campos.Delimiter := ',';
  campos.StrictDelimiter := True;

  while not EOF(archivo) do
  begin
    ReadLn(archivo, linea);

    campos.DelimitedText := linea;

    if campos.Count >= 4 then
    begin
      leagueName := campos[1];
      leagueLevel := StrToInt(campos[2]);
      internationalPrestige := StrToInt(campos[3]);

      if (leagueName = 'Premier League') and (leagueLevel = 2) and (internationalPrestige > 15) then
      begin
        Inc(contador);
      end;
    end;
  end;

  campos.Free;
  Close(archivo);

  WriteLn('Cantidad de equipos que juegan en la Premier League, en un nivel de liga 2 y con un prestigio internacional mayor a 15: ', contador);
end.
