unit ucPATH; // mPath / mProjeto

interface

uses
  Classes, SysUtils, StrUtils, Windows, Dialogs, ShellApi, Forms;

type
  TcPATH = class
  public
    class function Arquivo() : String;
    class function ArquivoDll() : String;

    class function Caminho(pSub : String): String;
    class function CaminhoDll() : String;

    class function Backup(): String;
    class function Config(): String;
    class function Dados(): String;
    class function Foto(): String;
    class function Image(): String;
    class function Log(): String;
    class function Model(): String;
    class function Report(): String;
    class function Schemas(): String;
    class function Temp(): String;

    class function ECF(): String;
    class function NFCe(): String;
    class function NFE(): String;
    class function PAF(): String;
  end;

implementation

uses
  ucFUNCAO, ucITEM, ucXML;

var
  gCaminhoPadrao : String;

  procedure SetCaminhoPadrao(pCaminhoPadrao : String);
  begin
    gCaminhoPadrao := pCaminhoPadrao;
  end;

  function GetCaminhoPadrao() : String;
  begin
    Result := IfThen(gCaminhoPadrao <> '', gCaminhoPadrao,
      AnsiReplaceStr(ExtractFilePath(Application.ExeName), ExtractFileExt(Application.ExeName), ''));
  end;

//--

// c:\caminho\sistema.exe
class function TcPATH.Arquivo() : String;
begin
  Result := Application.ExeName;
end;

// c:\caminho\sistema.dll
class function TcPATH.ArquivoDll() : String;
var
  Buffer : Array[0..260] of Char;
begin
  GetModuleFileName(hInstance, Buffer, Length(Buffer));
  Result := Buffer;
  Result := AnsiReplaceStr(Result, '\\?\', '');
end;

//--

// c:\caminho\
class function TcPATH.Caminho(pSub : String): String;
begin
  Result := GetCaminhoPadrao();

  if pSub <> '' then begin
    Result := Result + pSub;
    ForceDirectories(Result);
  end;
end;

// c:\caminho\
class function TcPATH.CaminhoDll() : String;
begin
  Result := ArquivoDll();
  Result := AnsiReplaceStr(Result, ExtractFileExt(Result), '');
end;

//--

class function TcPATH.Backup(): String;
begin
  Result := Caminho('backup\');
end;

class function TcPATH.Config(): String;
begin
  Result := Caminho('config\');
end;

class function TcPATH.Dados(): String;
begin
  Result := Caminho('dados\');
end;

class function TcPATH.Foto(): String;
begin
  Result := Caminho('foto\');
end;

class function TcPATH.Image(): String;
begin
  Result := Caminho('image\');
end;

class function TcPATH.Log(): String;
begin
  Result := Caminho('log\');
end;

class function TcPATH.Model(): String;
begin
  Result := Caminho('model\');
end;

class function TcPATH.Report(): String;
begin
  Result := Caminho('report\');
end;

class function TcPATH.Schemas(): String;
begin
  Result := Caminho('schemas\');
end;

class function TcPATH.Temp(): String;
begin
  Result := Caminho('temp\');
end;

//--

class function TcPATH.ECF(): String;
begin
  Result := Caminho('path_ecf\');
end;

class function TcPATH.NFCe(): String;
begin
  Result := Caminho('path_nfce\');
end;

class function TcPATH.NFE(): String;
begin
  Result := Caminho('path_nfe\');
end;

class function TcPATH.PAF(): String;
begin
  Result := Caminho('path_paf\');
end;

//--

end.
