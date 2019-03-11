unit ucEXPORTARAQUIVO;

interface

uses
  Classes, SysUtils, StrUtils, Dialogs, Forms, DB,
  ucPREVIEW, QRExport;

type
  TcEXPORTARAQUIVO = class
  public
    class function NomeArquivo(v_Arq : String = ''; v_Dir : String = '') : String;

    class procedure ExportaArquivo(v_PREVIEW : TcPREVIEW; v_Arq : String);
    class procedure ExportaToPlanilha(v_ClientDataSet : TDataSet; v_Arq : String);
  end;

implementation

uses
  ucFUNCAO;

{ ucEXPORTARAQUIVO }

class function TcEXPORTARAQUIVO.NomeArquivo(v_Arq, v_Dir : String) : String;
begin
  Result := '';

  if v_Arq = '' then
    v_Arq := AnsiReplaceStr(ExtractFileName(Application.ExeName),
      ExtractFileExt(Application.ExeName), '');

  if v_Dir = '' then
    v_Dir := ExtractFilePath(Application.ExeName) + '\Tempi';

  with TOpenDialog.Create(nil) do begin
    InitialDir := v_Dir;
    FileName := v_Arq;
    Filter := 'Arquivo CSV (*.csv)|*.csv|'+
              'Arquivo DOC (*.doc)|*.doc|'+
              'Arquivo EXCEL (*.xls)|*.xls|'+
              'Arquivo HTML (*.html)|*.html|'+
              'Arquivo OpenOffice (*.ods)|*.ods|'+
              'Arquivo Report (*.qrp)|*.qrp|'+
              'Arquivo Texto (*.txt)|*.txt';
    DefaultExt := '*.doc';

    if Execute then
      Result := FileName;
  end;
end;

class procedure TcEXPORTARAQUIVO.ExportaArquivo(v_PREVIEW : TcPREVIEW; v_Arq: String);
begin
  if not Assigned(v_PREVIEW) then
    Exit;
    
  if v_Arq = '' then
    Exit;

  if FileExists(v_Arq) then
    DeleteFile(v_Arq);

  with v_PREVIEW do begin
    if ExtractFileExt(v_Arq) = '.csv' then begin
      if Assigned(_ClientDataSet) then
        ExportaToPlanilha(_ClientDataSet, v_Arq)
      else
        _Preview.QRPrinter.ExportToFilter(TQRCommaSeparatedFilter.Create(v_Arq));

    end else if ExtractFileExt(v_Arq) = '.doc' then begin
      _Preview.QRPrinter.ExportToFilter(TQRAsciiExportFilter.Create(v_Arq));

    //end else if ExtractFileExt(v_Arq) = '.htm' then begin
    //  _Preview.QRPrinter.ExportToFilter(TQRHTMLDocumentFilter.Create(v_Arq));

    end else if ExtractFileExt(v_Arq) = '.txt' then begin
      _Preview.QRPrinter.ExportToFilter(TQRAsciiExportFilter.Create(v_Arq));

    end else if ExtractFileExt(v_Arq) = '.qrp' then begin
      _Preview.QRPrinter.Save(v_Arq);

    end else if ExtractFileExt(v_Arq) <> '.qrp' then begin
      ExecutePrograma(v_Arq, '', '');
      
    end;
  end;
end;

class procedure TcEXPORTARAQUIVO.ExportaToPlanilha(v_ClientDataSet : TDataSet; v_Arq: String);
var
  v_Aux, v_Esp, v_Sep, v_Cpo : String;
  I : Integer;
  F : TextFile;
begin
  if v_Arq = '' then
    Exit;

  if not Assigned(v_ClientDataSet) then
    Exit;

  if FileExists(v_Arq) then
    DeleteFile(v_Arq);

  v_Esp := Replicate(' ', 200);
  v_Sep := '|';

  AssignFile(F, v_Arq);
  Rewrite(F);

  with v_ClientDataSet do begin
    v_Aux:='';

    with Fields do
      for I:=0 to Count-1 do
        with Fields[I] do
          if (Pos(FieldName, v_Cpo) > 0) then
            v_Aux := v_Aux + v_Sep + Copy(DisplayLabel + v_Esp, 1, DisplayWidth);

    Writeln(F, v_Aux + v_Sep);

    First;
    while not EOF do begin

      v_Aux := '';
      with Fields do
        for I:=0 to Count-1 do
          with Fields[I] do
            if (Pos(FieldName, v_Cpo) > 0) then
              v_Aux := v_Aux + v_Sep + Copy(AsString + v_Esp, 1, DisplayWidth);

      Writeln(F,v_Aux+v_Sep);

      Next;
    end;
  end;

  CloseFile(F);
end;

end.
