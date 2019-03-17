unit ucVERSAOEXE;

interface

uses
  Classes, SysUtils, Windows, Forms;

type
  TcVersaoExe = class
  private
    FArquivo: String;
    function GetVersao(pArquivoStr : String; pSistema : Boolean) : String;
    function GetVersaoExe: String;
    function GetVersaoSis: String;
  public
    constructor Create;
  published
    property _Arquivo : String read FArquivo write FArquivo;
    property _VersaoExe : String read GetVersaoExe;
    property _VersaoSis : String read GetVersaoSis;
  end;

  function Instance : TcVersaoExe;

implementation

var
  _instance : TcVersaoExe;

  function Instance : TcVersaoExe;
  begin
    if not Assigned(_instance) then
      _instance := TcVersaoExe.Create;
    Result := _instance;
  end;

constructor TcVersaoExe.Create;
begin
  _Arquivo := Application.ExeName;
end;

function TcVersaoExe.GetVersao(pArquivoStr : String; pSistema : Boolean) : String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F : PFFI;
  Handle : Dword;
  Len : Longint;
  Data : Pchar;
  Buffer : Pointer;
  Tamanho : Dword;
  pArquivoChar : Pchar;
begin
  Result := '';

  pArquivoChar := StrAlloc(Length(pArquivoStr) + 1);
  StrPcopy(pArquivoChar, pArquivoStr);
  Len := GetFileVersionInfoSize(pArquivoChar, Handle);
  if Len > 0 then begin
    Data := StrAlloc(Len + 1);

    if GetFileVersionInfo(pArquivoChar, Handle, Len, Data) then begin
      VerQueryValue(Data, '\', Buffer, Tamanho);
      F := PFFI(Buffer);

      if (pSistema) then
        Result := FormatFloat('00', HiWord(F^.dwFileVersionMs)) + '.' +
                  FormatFloat('00', LoWord(F^.dwFileVersionMs)) + '.' +
                  FormatFloat('00', HiWord(F^.dwFileVersionLs))
      else
        Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs),
                                         LoWord(F^.dwFileVersionMs),
                                         HiWord(F^.dwFileVersionLs),
                                         Loword(F^.dwFileVersionLs)]);
    end;

    StrDispose(Data);
  end;

  StrDispose(pArquivoChar);
end;

function TcVersaoExe.GetVersaoExe: String;
begin
  Result := GetVersao(FArquivo, False);
end;

function TcVersaoExe.GetVersaoSis: String;
begin
  Result := GetVersao(FArquivo, True);
end;

end.
