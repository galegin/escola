unit ucFUNCOES; // mFuncao

interface

{Módulos externos - Inclua nesta lista os nomes das Unit's necessárias às suas funções}

uses
  WinProcs, Forms, SysUtils, DB, IniFiles, ShellApi, StrUtils, //DBClient,
  Classes, Typinfo, WinSock, DateUtils, ucFORMATAR;

  {Protótipos das Funções de Validação Disponíveis}

  function CamIni(Tag : String = '') : String;

  function LerIni(Tag, Campo : String; Padrao : String = '') : String; overload;
  function LerIni(Campo : String) : String; overload;
  function LerIniB(Campo : String) : Boolean;
  function LerIniD(Campo : String) : TDateTime;
  function LerIniF(Campo : String) : Real;
  function LerIniI(Campo : String) : Integer;

  procedure fGravaIni(Tag, Campo : String; Valor : Variant); overload;
  procedure fGravaIni(Campo : String; Valor : Variant); overload;

  function IfNull(pString : String; pStringOut : String) : String;
  function IfNullB(pString : String; pStringOut : Boolean) : Boolean;
  function IfNullD(pString : String; pStringOut : TDateTime) : TDateTime;
  function IfNullF(pString : String; pStringOut : Real) : Real;
  function IfNullI(pString : String; pStringOut : Integer) : Integer;

  function IffThen(pString : Boolean; pStringIn, pStringOut : String) : String;
  function IffThenB(pString : Boolean; pStringIn, pStringOut : Boolean) : Boolean;
  function IffThenD(pString : Boolean; pStringIn, pStringOut : TDateTime) : TDateTime;
  function IffThenF(pString : Boolean; pStringIn, pStringOut : Real) : Real;
  function IffThenI(pString : Boolean; pStringIn, pStringOut : Integer) : Integer;
  function IffThenV(pString : Boolean; pStringIn, pStringOut : Variant) : Variant;

  procedure ExecutePrograma(sFileName: String; sParam: String = ''; sDir: String = '');

  function decript(Dado : String) : String;
  function encript(Dado : String) : String;
  function cripto_m(Dado : String) : String;

  procedure Mensagem(Mem : String);
  function Pergunta(Mem : String) : Boolean;

  function ASC(pStr : String) : Byte;
  function AllTrim(pString : String; pDem : String = ' ') : String;

  function MasCNPJCPF(Dado : String) : String;
  function MasCNPJ(Dado : string) : String;
  function MasCPF(Dado : string) : String;

  function ValidaCNPJCPF(Dado : string) : boolean;
  function ValidaCNPJ(Dado : string) : boolean;
  function ValidaCPF(Dado : string) : boolean;
  function ValidaPIS(Dado : string) : boolean;

  function Replicate(Caractere : string; nString : integer) : string;
  function TiraAcentos(texto : string): string;
  function TiraAcentosChar(Ch : char): char;
  function PrimeiroNome(Nome : string) : String;
  function Arredonda(valor, mais : real) : Real;

  function Alinhar(pStr : String; pLar : Integer; pTip : TAlignment; pPre : String = ' ') : String;

  function Formatar(pStr : String; pFmt : String) : String; overload;
  function Formatar(pStr : String; pFmt : TpFormatar) : String; overload;

  function DiaDaSemana(Dia : Integer) : String;
  function MesExtenso(Mes : Integer) : String;
  function DataExtenso(Data : String) : String;

  function iff(Expr : Boolean; c1, c2 : String) : String;

  function PriMaiuscula(S : String) : String;
  function SoDigitos(S : String) : String;
  function SoDigitosAlfa(S : String) : String;

  function MMYYYYtoYYYYMM(S : String) : String;
  function YYYYMMtoMMYYYY(S : String) : String;

  procedure p_SetPropValue(Comp: TObject; Const PropName: string; Val: Variant);
  function p_GetPropValue(Comp: TObject; Const PropName: string): string;

  function VerDiasUtil(DI, DF : TDateTime): integer;
  function ChecaEstado(Dado : string) : boolean;
  function ObterListaUF : String;
  function InverteNomeCarta(Nome : String) : String;

  function GetData(pData : TDateTime; pTip : String) : Real; overload;
  function GetData(pData : TDateTime; pHor, pMin, pSeg : Integer) : TDateTime; overload;
  function GetData(pAno, pMes, pDia, pHor, pMin, pSeg : Integer) : TDateTime; overload;

  function PriDiaMes(data: TDateTime) : TDateTime;
  function UltDiaMes(data: TDateTime) : TDateTime;
  function PriDiaAno(data: TDateTime) : TDateTime;
  function UltDiaAno(data: TDateTime) : TDateTime;

  function MultiploPor(I,P : Integer) : Integer;

  procedure p_Grava_Log(sMSG : String);
  procedure f_SubsStr(v_Linhas : TStringList; S1, S2 : String; pAlin : TAlignment = taLeftJustify);

  function AchaComponente(Nome: string; F: TForm): TComponent;

  procedure PegarIP(piParams : String; var poParams : String);
  function GetIpComputador() : String;
  function GetNmComputador() : String;

  function ReplaceStr(pS1, pS2 : String; pS3 : Variant) : String;

  function GetLeftStr(pStr, pCod : String) : String;
  function GetRightStr(pStr, pCod : String) : String;

  function startsWiths(pStr, pVal : String) : Boolean;
  function endWiths(pStr, pVal : String) : Boolean;

  function PosIni(pVal, pVar : String; pIni : Integer) : Integer;
  function PosInv(S, V : String) : Integer;

  function IsDelphiOpen() : Boolean;

  function PathWithDelim(const APath : String; ADelim : String = PathDelim) : String;
  function PathWithDelimDIR(const APath : String) : String;
  function PathWithDelimEXT(const APath : String) : String;
  function PathWithDelimURL(const APath : String) : String;

  (* Procedure Le_Imagem_JPEG(Campo:TBlobField; Foto:TImage);
  Procedure Grava_Imagem_JPEG(Tabela:TClientDataSet;
      Campo:TBlobField; Foto:TImage; Dialog:TOpenPictureDialog); *)

  {Declaração de Variáveis Constantes}

const
  UF : array[1..28] of String = ('AC','AL','AM','AP','BA','CE',
                                 'DF','ES','FN','GO','MA','MG',
                                 'MS','MT','SC','SP','PA','PB',
                                 'PE','PI','PR','RJ','RO','RN',
                                 'RR','RS','SE','TO');

  Dia_Semana : array[1..7] of String = ('Domingo','Segunda','Terça','Quarta',
                                        'Quinta','Sexta','Sábado');
  Meses   : array[1..12] of String = ('Janeiro','Fevereiro','Março','Abril',
                                      'Maio','Junho','Jullho','Agosto',
                                      'Setembro','Outubro','Novembro','Dezembro');
  ACENT : array[1..9] of String =
                       ('Cento', 'Duzentos', 'Trezentos', 'Quatrocentos', 'Quinhentos',
                        'Seiscentos', 'Setecentos', 'Oitocentos', 'Novecentos');
  ADEZ  : array[1..9] of String =
                       ('Dez', 'Vinte', 'Trinta', 'Quarenta', 'Cinquenta', 'Sessenta', 'Setenta',
                        'Oitenta', 'Noventa');
  AVINT : array[1..9] of String =
                       ('Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze', 'Dezesseis', 'Dezessete',
                        'Dezoito', 'Dezenove');
  AUNID : array[1..9] of String =
                       ('Um', 'Dois', 'Três', 'Quatro', 'Cinco', 'Seis', 'Sete', 'Oito', 'Nove');

  ACIFRA : array[1..12] of String =
                       ('Trilhão','Trilhões','Bilhão','Bilhões','Milhão','Milhões',
                        'Mil','Mil','  ','  ','Centavo','Centavos');

  //CR    = Chr(13);
  //LF    = Chr(10);
  //FF    = Chr(12);
  //ESC   = Chr(27);
  //BS    = Chr(08);
  //Space = ' ';
  //Yes   = True;
  //No    = False;

  cLST_TRUE = 'S|T|SIM|TRUE|1';
  cLST_FALSE = 'N|F|NAO|FALSE|0';

var
   Segment : Word;         { Preset to zero }
   GMT : Boolean;
   Suppress : Boolean;
   cArquivoIni : String;

implementation

{Declaração das funções e procedures}

uses
  ucCONST, ucITEM, ucXML;

//--

function CamIni(Tag : String) : String;
begin
  if (Tag = '') then begin
    Result := 'system.ini';
  end else begin
    cArquivoIni := ifNull(cArquivoIni, ChangeFileExt(ParamStr(0), '.ini'));
    Result := cArquivoIni;
  end;
end;

//--

function LerIni(Tag, Campo : String; Padrao : String) : String;
var
  vTag, vArquivo : String;
  ArqIni : TIniFile;
begin
  vArquivo := CamIni(Tag);
  vTag := iff(Tag='',Application.Title,Tag);

  ArqIni := TIniFile.Create(vArquivo);
  with ArqIni do begin
    Result := ReadString(vTag, Campo, Padrao);
    Free;
  end;

  if (Result = '') and (Padrao <> '') then
    Result := Padrao;
end;

function LerIni(Campo : String) : String;
begin
  Result := LerIni('GERAL', Campo);
end;

function LerIniB(Campo : String) : Boolean;
begin
  Result := Pos(UpperCase(LerIni(Campo)), cLST_TRUE) > 0;
end;

function LerIniD(Campo : String) : TDateTime;
begin
  Result := StrToDateTimeDef(LerIni(Campo), 0);
end;

function LerIniF(Campo : String) : Real;
begin
  Result := StrToFloatDef(LerIni(Campo), 0);
end;

function LerIniI(Campo : String) : Integer;
begin
  Result := StrToIntDef(LerIni(Campo), 0);
end;

//--

procedure fGravaIni(Tag, Campo : String; Valor : Variant);
var
  vTag, vArquivo, vVal : String;
  ArqIni: TIniFile;
begin
  vArquivo := CamIni(Tag);
  vTag := iff(Tag='',Application.Title,Tag);
  vVal := Valor;

  ArqIni := TIniFile.Create(vArquivo);
  with ArqIni do begin
    WriteString(vTag, Campo, vVal);
    Free;
  end;
end;

procedure fGravaIni(Campo : String; Valor : Variant);
begin
  fGravaIni('GERAL', Campo, Valor);
end;

//--

function IfNull(pString : String; pStringOut : String) : String;
begin
  Result := IfThen(pString<>'', pString, pStringOut);
end;

function IfNullB(pString : String; pStringOut : Boolean) : Boolean;
begin
  if (pString <> '') then Result := Pos(UpperCase(pString), cLST_TRUE) > 0 else Result := pStringOut;
end;

function IfNullD(pString : String; pStringOut : TDateTime) : TDateTime;
begin
  Result := StrToDateTimeDef(pString, pStringOut);
end;

function IfNullF(pString : String; pStringOut : Real) : Real;
begin
  Result := StrToFloatDef(pString, pStringOut);
end;

function IfNullI(pString : String; pStringOut : Integer) : Integer;
begin
  Result := StrToIntDef(pString, pStringOut);
end;

//--

function IffThen(pString : Boolean; pStringIn, pStringOut : String) : String;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

function IffThenB(pString : Boolean; pStringIn, pStringOut : Boolean) : Boolean;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

function IffThenD(pString : Boolean; pStringIn, pStringOut : TDateTime) : TDateTime;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

function IffThenF(pString : Boolean; pStringIn, pStringOut : Real) : Real;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

function IffThenI(pString : Boolean; pStringIn, pStringOut : Integer) : Integer;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

function IffThenV(pString : Boolean; pStringIn, pStringOut : Variant) : Variant;
begin
  if (pString) then Result := pStringIn else Result := pStringOut;
end;

//--

procedure ExecutePrograma(sFileName: String; sParam: String = ''; sDir: String = '');
var
  St1:array[0..255] of char;
  St2:array[0..255] of char;
  St3:array[0..255] of char;
begin
  ShellExecute(0,'open',StrPCopy(St1,sFileName),StrPCopy(St2,sParam),StrPCopy(St3,sDir),SW_SHOW);
end;

//--

function decript(Dado : String) : String;
const
  ch = 'RarbOcodNenfAgahLiljDkolmSnsoCpcqHrhsMwmxIyizTtzhk';
var
  l, i, j : integer;
begin
  Result := '';

  j := 0;
  for i := 1 to length(dado) do begin
    j := j + 1;
    l := asc(Copy(dado, i, 1)) - asc(Copy(ch, j, 1));
    if (j = 50) then
      j := 1;
    if (l < 0) then
      l := l + 256;
    Result := Result + chr(l);
  end;
end;

function encript(Dado : String) : String;
const
  ch = 'RarbOcodNenfAgahLiljDkolmSnsoCpcqHrhsMwmxIyizTtzhk';
var
  l, i, j : integer;
begin
  Result := '';

  j := 0;
  for i := 1 to length(dado) do begin
    j := j + 1;
    l := asc(Copy(dado, i, 1)) + asc(Copy(ch, j, 1));
    if (j = 50) then
      j := 1;
    if (l > 255) then
      l := l - 256;
    Result := Result + Chr(l)
  end;
end;

function cripto_m(Dado : String) : String;
var
  l, i, j : integer;
begin
  Result := '';

  j := 10;
  for i := 1 to length(dado) do begin
    l := asc(Copy(dado, i, 1));
    if (l mod 2) = 0 then
      l := l + J * 2
    else
      l := l + J * 3;
    Result := Result + chr(l);
  end;
end;

//--

procedure Mensagem(Mem : String);
begin
  MessageBeep(65536);
  Application.MessageBox(PChar(Mem),'.: Informação :.',MB_OK + MB_ICONEXCLAMATION);
end;

function Pergunta(Mem : String) : Boolean;
begin
  MessageBeep(65536);
  Pergunta := (Application.MessageBox(PChar(Mem),'.: Confirmação :.',MB_YESNO + MB_ICONINFORMATION) = IDYES);
end;

//--

function MasCNPJCPF(Dado : String) : String;
begin
  Result := Dado;
  
  Dado := SoDigitos(Dado);

  if length(Dado) = 14 then
    Result := MasCNPJ(Dado)
  else if length(dado) = 11 then
    Result := MasCPF(Dado)
end;

function MasCNPJ(Dado : String) : String;
begin
  Dado := SoDigitos(Dado);

  if length(Dado) = 14 then
    Result := Formatar(Dado, tfCNPJ)
  else
    Result := Dado;
end;

function MasCPF(Dado : String) : String;
begin
  Dado := SoDigitos(Dado);

  if length(Dado) = 11 then
    Result := Formatar(Dado, tfCPF)
  else
    Result := Dado;
end;

//--

function ValidaCNPJCPF(Dado : String) : boolean;
begin
  Result := False;

  Dado := SoDigitos(Dado);

  if length(dado) = 14 then
    Result := ValidaCNPJ(Dado)
  else if length(dado) = 11 then
    Result := ValidaCPF(Dado);
end;

function ValidaCNPJ(Dado : String) : boolean;
var
  D1 : array[1..12] of byte;
  I, DF1, DF2, DF3, DF4, DF5, DF6,
  Resto1, Resto2,
  PrimeiroDigito, SegundoDigito : integer;
begin
  Result := true;
  if Length(Dado) = 14 then begin
    for I := 1 to 12 do
      if Dado[I] in ['0'..'9'] then
        D1[I] := StrToInt(Dado[I])
      else
        Result := false;
    if Result then begin
      DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0;
      DF1 := 5*D1[1] + 4*D1[2] + 3*D1[3] + 2*D1[4] + 9*D1[5] + 8*D1[6] +
             7*D1[7] + 6*D1[8] + 5*D1[9] + 4*D1[10] + 3*D1[11] + 2*D1[12];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;
      DF4 := 6*D1[1] + 5*D1[2] + 4*D1[3] + 3*D1[4] + 2*D1[5] + 9*D1[6] +
             8*D1[7] + 7*D1[8] + 6*D1[9] + 5*D1[10] + 4*D1[11] + 3*D1[12] +
             2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(Dado[13]))
      or (SegundoDigito <> StrToInt(Dado[14])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
end;

function ValidaCPF(Dado : String) : boolean;
var
  D1 : array[1..9] of byte;
  I, DF1, DF2, DF3, DF4, DF5, DF6,
  Resto1, Resto2,
  PrimeiroDigito, SegundoDigito : integer;
begin
  Result := true;
  if Length(Dado) = 11 then begin
    for I := 1 to 9 do
      if Dado[I] in ['0'..'9'] then
        D1[I] := StrToInt(Dado[I])
      else
        Result := false;
    if Result then begin
      DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0;
      DF1 := 10*D1[1] + 9*D1[2] + 8*D1[3] + 7*D1[4] + 6*D1[5] + 5*D1[6] +
             4*D1[7] + 3*D1[8] + 2*D1[9];
      DF2 := DF1 div 11;
      DF3 := DF2 * 11;
      Resto1 := DF1 - DF3;
      if (Resto1 = 0) or (Resto1 = 1) then
        PrimeiroDigito := 0
      else
        PrimeiroDigito := 11 - Resto1;
      DF4 := 11*D1[1] + 10*D1[2] + 9*D1[3] + 8*D1[4] + 7*D1[5] + 6*D1[6] +
             5*D1[7] + 4*D1[8] + 3*D1[9] + 2*PrimeiroDigito;
      DF5 := DF4 div 11;
      DF6 := DF5 * 11;
      Resto2 := DF4 - DF6;
      if (Resto2 = 0) or (Resto2 = 1) then
        SegundoDigito := 0
      else
        SegundoDigito := 11 - Resto2;
      if (PrimeiroDigito <> StrToInt(Dado[10]))
      or (SegundoDigito <> StrToInt(Dado[11])) then
        Result := false;
    end;
  end else
    if Length(Dado) <> 0 then
      Result := false;
end;

function ValidaPIS(Dado : String) : boolean;
var
  i,wsoma,Wm11,Wdv,wdigito : Integer;
begin
  wdv := strtoint(copy(Dado, 11, 1));
  wsoma := 0;
  wm11 := 2;
  for i := 1 to 10 do begin
    wsoma := wsoma + (wm11 * strtoint(copy(Dado, 11 - I, 1)));
    if wm11 < 9 then
      wm11 := wm11+1
    else
      wm11 := 2;
  end;

  wdigito := 11 - (wsoma MOD 11);
  if wdigito > 9 then
    wdigito := 0;

  if wdv = wdigito then begin
    Result := true;
  end else begin
    mensagem('PIS é Inválido!');
    Result := false;
  end;
end;

//--

function Replicate(Caractere : String; nString : integer) : String;
var
  n : integer;
begin
  Result := '';
  for n := 1 to nString do
    Result := Result + Caractere;
end;

function AllTrim(pString, pDem : String): String;
var
  pTam : Integer;
begin
  Result := pString;

  pTam := Length(pDem);

  // retirar inicio
  while (Copy(Result, 1, pTam) = pDem) do
    Delete(Result, 1, pTam);

  // retirar final
  while (Copy(Result, Length(Result), pTam) = pDem) do
    Delete(Result, Length(Result), pTam);

  pDem := pDem + pDem;

  // retirar entre
  while (Pos(pDem, Result) > 0) do
    Delete(Result, Pos(pDem, Result), pTam);
end;

function ASC(pStr : String) : Byte;
Begin
  if Length(pStr) > 0 then
    Result := Ord(pStr[1])
  else
    Result := 0;
end;

//--

function SerialNum(FDrive : String): String;
var
  Serial : DWord;
  DirLen, Flags : DWord;
  DLabel : PChar;
begin
  try
    GetVolumeInformation(PChar(FDrive+':\'), dLabel, 12,@Serial,DirLen,Flags,nil,0);
    Result := IntToHex(Serial,8);
  except
    Result := '';
  end;
end;

//--

function TiraAcentos(texto : String): String;
var
  i : integer;
begin
  texto := UpperCase(texto);
  for i := 1 to length(texto) do
    texto[i] := TiraAcentosChar(texto[i]);
    case texto[i] of
      'á','Á','à','À','ã','Ã','â','Â': texto[i] := 'A';
      'é','É','ê','Ê': texto[i] := 'E';
      'í','Í': texto[i] := 'I';
      'ó','Ó','õ','Õ','ô','Ô': texto[i] := 'O';
      'ú','Ú': texto[i] := 'U';
      'ç','Ç': texto[i] := 'C';
    end;
  Result := texto;
end;

function TiraAcentosChar(Ch : char): char;
begin
  Ch := UpCase(Ch);
  case Ch of
    'á','Á','à','À','ã','Ã','â','Â': Ch := 'A';
    'é','É','ê','Ê': Ch := 'E';
    'í','Í': Ch := 'I';
    'ó','Ó','õ','Õ','ô','Ô': Ch := 'O';
    'ú','Ú': Ch := 'U';
    'ç','Ç': Ch := 'C';
  end;
  Result := Ch;
end;

function PrimeiroNome(Nome : String) : String;
begin
  Result := '';
  if pos (' ', Nome) > 0 then
    Result := copy (Nome, 1, pos (' ', Nome) - 1);
end;

function Arredonda(valor, mais : real) : Real;
begin
  Result := Int(valor) + mais;
end;

//--

function Alinhar(pStr : String; pLar : Integer; pTip : TAlignment; pPre : String) : String;
var
  vStr : String;
begin
  vStr := copy(pStr, 1, pLar);

  if pTip = taRightJustify then begin
    Result := Replicate(pPre, pLar - Length(vStr)) + vStr;
  end else if pTip = taLeftJustify then begin
    Result := pStr + Replicate(pPre, pLar - Length(vStr));
  end else if pTip = taCenter then begin
    pLar := (pLar - Length(vStr)) div 2;
    Result := Replicate(pPre, pLar) + vStr + Replicate(' ', pLar);
  end;
end;

//--

function Formatar(pStr : String; pFmt : String) : String;
var
  vPre : String;

  procedure prcPrefixo();
  var
    vStr, vFmt, vAux : String;
    I, J, vPos : Integer;
  begin
    vPre := '';
    vStr := '';
    vPos := Pos('X', pFmt);

    if vPos > 0 then begin
      vFmt := Copy(pFmt, 1, vPos - 1);
      Delete(pFmt, 1, vPos - 1);
      vAux := SoDigitosAlfa(vFmt);
      vStr := Copy(pStr, 1, Length(vAux));
      Delete(pStr, 1, Length(vAux));
    end;

    if vStr <> '' then begin
      J := Length(vStr);
      for I:=1 to Length(vFmt) do begin
        if vFmt[I] in ['0'..'9', 'A'..'Z', 'a'..'z'] then begin
          vPre := vPre + vStr[J];
          Dec(J);
        end else begin
          vPre := vPre + vFmt[I];
        end;
      end;
    end;
  end;

var
  I, J : Integer;
begin
  Result := '';

  if Pos('#', pFmt) > 0 then begin
    Result := FormatFloat(pFmt, StrToFloatDef(pStr,0));
    Exit;
  end;

  if Pos('Z', pFmt) > 0 then
    pStr := SoDigitosAlfa(pStr)
  else
    pStr := SoDigitos(pStr);

  prcPrefixo();

  J := Length(pStr);
  for I:=Length(pFmt) downto 1 do begin
    if pFmt[I] in ['0'..'9', 'A'..'Z', 'a'..'z'] then begin
      if J > 0 then begin
        Result := pStr[J] + Result;
        Dec(J);
      end;  
    end else begin
      Result := pFmt[I] + Result;
    end;
  end;

  Result := vPre + ReplaceStr(Result, 'X', '');
end;

function Formatar(pStr : String; pFmt : TpFormatar) : String;
begin
  Result := Formatar(pStr, GetTpFormatarFmt(pFmt));
end;

//--

function iff(Expr : Boolean; c1, c2 : String) : String;
begin
  if Expr then Result := c1 else Result := c2;
end;

//--

function DiaDaSemana(Dia : Integer) : String;
begin
  Result := Dia_Semana[Dia];
end;

function MesExtenso(Mes : Integer) : String;
begin
  Result := Meses[Mes];
end;

function DataExtenso(Data : String) : String;
begin
  Result := FormatDateTime('dddd, d " de " mmmm " de " yyyy', StrToDate(Data));
end;

//--

function PriMaiuscula(S : String) : String;
begin
  if (S <> '') then begin
    Result := LowerCase(S);
    Result[1] := UpCase(Result[1]);
  end else
    Result := '';
end;

function SoDigitos(S : String) : String;
var
  I : Integer;
begin
  Result := '';
  for I:=1 to Length(S) do
    if S[I] in ['0'..'9'] then
      Result := Result + Copy(S,I,1);
end;

function SoDigitosAlfa(S : String) : String;
var
  I : Integer;
begin
  Result := '';
  for I:=1 to Length(S) do
    if S[I] in ['0'..'9', 'A'..'Z', 'a'..'z'] then
      Result := Result + Copy(S,I,1);
end;

//--

function MMYYYYtoYYYYMM(S : String) : String;
begin
  Result := FormatDateTime('yyyy/mm',StrToDate('01/'+S));
end;

function YYYYMMtoMMYYYY(S : String) : String;
begin                                              // 1234/67
  Result := FormatDateTime('mm/yyyy',StrToDate('01/'+Copy(S,6,2)+'/'+Copy(S,1,4)));
end;

//--

procedure p_SetPropValue(Comp: TObject; Const PropName: string; Val: Variant);
var
  PInfo: PPropInfo;
  vVal : String;
begin
  if Comp = nil then
    Exit;

  vVal := Val;
  PInfo := GetPropInfo(Comp, PropName);
  if PInfo <> nil then
    SetPropValue(Comp, PropName, vVal);
end;

function p_GetPropValue(Comp: TObject; Const PropName: string): string;
var
  PInfo: PPropInfo;
begin
  Result := '';

  if Comp = nil then
    Exit;

  PInfo := GetPropInfo(Comp, PropName);
  if PInfo <> nil then
    Result := GetPropValue(Comp, PropName);
end;

//--

function VerDiasUtil(DI, DF : TDateTime): Integer;
var
  D : TDateTime;
begin
  Result := 0;

  D := DI;
  while (D <= DF) do begin
    if (DayOfWeek(D) = 1) or (DayOfWeek(D) = 7) then
    else Inc(Result);
    D := D + 1;
  end;
end;

//--

function ChecaEstado(Dado : String) : boolean;
begin
  Result := Pos(UpperCase(Dado), cLST_UF) > 0;
end;

function ObterListaUF : String;
begin
  Result := cLST_UF;
end;

//--

function InverteNomeCarta(Nome : String) : String;
var
  vAux : String;
begin
  Result := Alltrim(Nome);
  if (Pos(' ',Result) > 0) then begin
    vAux := '';
    while (Copy(Result,Length(Result),1) <> ' ') and (Length(Result)>0) do begin
      vAux := Copy(Result,Length(Result),1) + vAux;
      Delete(Result,Length(Result),1);
    end;
    Result := vAux + ', ' + Result;
  end;
end;

//--

{
Procedure Le_Imagem_JPEG(Campo:TBlobField; Foto:TImage);
var
  BS:TBlobStream;
  MinhaImagem:TJPEGImage;
Begin
  if Campo.AsString <> '' Then Begin
    BS := TBlobStream.Create((Campo as TBlobField), BMREAD);
    MinhaImagem := TJPEGImage.Create;
    MinhaImagem.LoadFromStream(BS);
    Foto.Picture.Assign(MinhaImagem);
    BS.Free;
    MinhaImagem.Free;
  End
  Else Foto.Picture.LoadFromFile('c:\temp\limpa.jpg');
End;

Procedure Grava_Imagem_JPEG(Tabela:TClientDataSet; Campo:TBlobField; Foto:TImage; Dialog:TOpenPictureDialog);
var
  BS:TBlobStream;
  MinhaImagem:TJPEGImage;
Begin
  Dialog.InitialDir := 'c:\temp';
  Dialog.Execute;
  if Dialog.FileName <> '' Then Begin
    if not (Tabela.State in [dsEdit, dsInsert]) Then
    Tabela.Edit;
    BS := TBlobStream.Create((Campo as TBlobField), BMWRITE);
    MinhaImagem := TJPEGImage.Create;
    MinhaImagem.LoadFromFile(Dialog.FileName);
    MinhaImagem.SaveToStream(BS);
    Foto.Picture.Assign(MinhaImagem);
    BS.Free;
    MinhaImagem.Free;
    Tabela.Post;
    DBISaveChanges(Tabela.Handle);
  End;
End;
}

function GetData(pData : TDateTime; pTip : String) : Real;
var
  vAno, vMes, vDia, vHor, vMin, vSeg, vMil : Word;
begin
  pTip := UpperCase(pTip);

  DecodeDateTime(pData, vAno, vMes, vDia, vHor, vMin, vSeg, vMil);

  if Pos(pTip, 'A,Y') > 0 then Result := vAno
  else if Pos(pTip, 'M') > 0 then Result := vMes
  else if Pos(pTip, 'D') > 0 then Result := vDia
  else if Pos(pTip, 'H') > 0 then Result := vHor
  else if Pos(pTip, 'N') > 0 then Result := vMin
  else if Pos(pTip, 'S') > 0 then Result := vSeg
  else Result := 0;
end;

function GetData(pData : TDateTime; pHor, pMin, pSeg : Integer) : TDateTime;
var
  vAno, vMes, vDia, vHor, vMin, vSeg, vMil : Word;
begin
  DecodeDateTime(pData, vAno, vMes, vDia, vHor, vMin, vSeg, vMil);
  Result := EncodeDateTime(vAno, vMes, vDia, pHor, pMin, pSeg, 0);
end;

function GetData(pAno, pMes, pDia, pHor, pMin, pSeg : Integer) : TDateTime;
begin
  Result := EncodeDateTime(pAno, pMes, pDia, pHor, pMin, pSeg, 0);
end;

function PriDiaMes(data : TDateTime) : TDateTime;
begin                                  //12/45/7890
  Result := StrToDate('01/'+FormatDateTime('mm/yyyy',Data));
end;

function UltDiaMes(data : TDateTime) : TDateTime;
var
  mes : integer;
begin
  mes := StrToInt(FormatDateTime('mm',Data));
  if mes = 2 then begin
    if (mes mod 4 = 0) then Result := StrToDate('29/'+FormatDateTime('mm/yyyy',Data))
    else Result := StrToDate('28/'+FormatDateTime('mm/yyyy',Data));
  end else begin
    if (mes in [1,3,5,7,8,10,12]) then Result := StrToDate('31/'+FormatDateTime('mm/yyyy',Data))
    else Result := StrToDate('30/'+FormatDateTime('mm/yyyy',Data));
  end;
end;

function PriDiaAno(data : TDateTime) : TDateTime;
begin
  Result := StrToDate('01/01/'+FormatDateTime('yyyy',Data));
end;

function UltDiaAno(data : TDateTime) : TDateTime;
begin
  Result := StrToDate('31/12/'+FormatDateTime('yyyy',Data));
end;

//--

function MultiploPor(I,P : Integer) : Integer;
var
  M : Integer;
begin
  M := I div P;
  Result := M * P
end;

//--

procedure p_Grava_Log(sMSG : String);
var
  v_Dir, v_Arq, v_Exe : String;
  F: TextFile;
begin
  v_Dir := ExtractFilePath(Application.ExeName) + 'log\';
  ForceDirectories(v_Dir);

  v_Arq := v_Dir + Application.Name + '.' + FormatDateTime('yyyy.mm.dd',Now) + '.txt';
  AssignFile(F, v_Arq);

  try
    if FileExists(v_Arq) then
      Append(F)
    else
      Rewrite(F);

    WriteLn(F, '[' + DateTimeToStr(now) + ']', sMSG);
  finally
    CloseFile(F)
  end;
end;

//--

procedure f_SubsStr(v_Linhas : TStringList; S1, S2 : String; pAlin : TAlignment);
//const
//  E = '                                                            ';
var
  I, vPos, vTam : Integer;
  vLinha, vAux : String;
begin
  for I:=0 to v_Linhas.Count-1 do begin
    vPos := Pos(S1, v_Linhas[I]);
    if (vPos > 0) then begin
      vLinha := v_Linhas[I];
      vAux := Copy(vLinha,1,vPos-1);
      Delete(vLinha, 1, vPos);
      Delete(vLinha,1, Pos(',',vLinha));
      vTam := StrToIntDef(Copy(vLinha, 1, Pos('>',vAux)-1), 0);
      Delete(vLinha,1,Pos('>',vLinha));
      v_Linhas[I] := vAux + Alinhar(S2,vTam,pAlin) + vLinha;
    end;
  end;
end;

//--

function AchaComponente(Nome: String; F: TForm): TComponent;
var
  i: integer;
  C: TComponent;
begin
  Result := nil;
  Nome := UpperCase(Nome);
  for i := 0 to F.ComponentCount - 1 do begin
    C := F.Components[i];
    if UpperCase(C.Name) = Nome then begin
      Result := C;
      Exit;
    end;
  end;
end;

//--

procedure PegarIP(piParams : String; var poParams : String);
var
  s1 : array[0..128] of char;
  wVersionRequested : WORD;
  wsaData : TWSAData;
  p1 : PHostEnt;
  p2 : pchar;
begin
  poParams := '';

  wVersionRequested := MAKEWORD(1, 1);
  WSAStartup(wVersionRequested, wsaData);

  GetHostName(@s1, 128);
  p1 := GetHostByName(@s1);
  putitem(poParams, 'DS_NAME', StrPas(p1^.h_Name));

  p2 := iNet_ntoa(PInAddr(p1^.h_addr_list^)^); // HostName
  putitem(poParams, 'DS_IP', StrPas(p2));

  WSACleanup;
end;

function GetIpComputador() : String;
begin
  PegarIP('', Result);
  Result := item('DS_IP', Result);
end;

function GetNmComputador() : String;
begin
  PegarIP('', Result);
  Result := item('DS_NAME', Result);
end;

//--

function ReplaceStr(pS1, pS2 : String; pS3 : Variant) : String;
var
  vS3 : String;
begin
  vS3 := pS3;
  Result := StringReplace(pS1, pS2, vS3, [rfReplaceAll, rfIgnoreCase]);
end;

//--

function GetLeftStr(pStr, pCod : String) : String;
var
  P : Integer;
begin
  Result := '';
  P := Pos(pCod, pStr);
  if (P > 0) then begin
    Result := Copy(pStr, 1, P - 1);
  end;
end;

function GetRightStr(pStr, pCod : String) : String;
var
  P : Integer;
begin
  Result := '';
  P := Pos(pCod, pStr);
  if (P > 0) then begin
    Result := Copy(pStr, P + Length(pCod), Length(pStr));
  end;
end;

//--

//startsWiths('miguel franco galego', 'miguel');
//startsWiths('miguel franco galego', 'jose');
function startsWiths(pStr, pVal : String) : Boolean;
begin
  pStr := LowerCase(pStr);
  pVal := LowerCase(pVal);
  Result := (Copy(pStr, 1, Length(pVal)) = pVal);
  Result := Result;
end;

//endWiths('miguel franco galego', 'galego');
//endWiths('miguel franco galego', 'silva');
function endWiths(pStr, pVal : String) : Boolean;
var
  pTam : Integer;
begin
  pStr := LowerCase(pStr);
  pVal := LowerCase(pVal);
  pTam := Length(pVal);
  Result := (Copy(pStr, Length(pStr) - pTam + 1, pTam) = pVal);
  Result := Result;
end;

//--

function PosIni(pVal, pVar : String; pIni : Integer) : Integer;
var
  P : Integer;
begin
  Result := 0;
  if (pIni > 0) then Delete(pVar, 1, pIni);
  P := Pos(pVal, pVar);
  if (P > 0) then Result := P + pIni;
end;

function PosInv(S, V : String) : Integer;
begin
  Result := Length(V);

  while (Copy(V, Result, Length(S)) <> S) and (Result > 0) do begin
    Copy(V, Result, 1);
    Dec(Result);
  end;
end;

//--

function IsDelphiOpen() : Boolean;
begin
  Result := (FindWindow('TAppBuilder', nil) > 0) and LerIniB(IND_DEB);
end;

//--

{-----------------------------------------------------------------------------
  Verifica se <APath> possui "PathDelim" no final. Retorna String com o Path
  já ajustado
---------------------------------------------------------------------------- }
function PathWithDelim(const APath : String; ADelim : String) : String;
begin
  Result := Trim(APath);
  if Result <> '' then
    if RightStr(Result,1) <> ADelim then { Tem delimitador no final ? }
       Result := Result + ADelim;
end;

function PathWithDelimDIR(const APath : String) : String;
begin
  Result := PathWithDelim(APath, '\');
end;

function PathWithDelimEXT(const APath : String) : String;
begin
  Result := PathWithDelim(APath, '.');
end;

function PathWithDelimURL(const APath : String) : String;
begin
  Result := PathWithDelim(APath, '/');
end;

//--

begin
  //Mensagem( Formatar('02681433908', '999.999.999-99') );
  //Mensagem( Formatar('87205104', tfCEP) );
  //Mensagem( Formatar('074316315000111', tfCNPJ) );
  //Mensagem( Formatar('74316315000111', tfCNPJ) );
  //Mensagem( Formatar('02681433908', tfCPF) );
  //Mensagem( Formatar('12122015', tfDATA) );
  //Mensagem( Formatar('443611449', tfFONE) );
  //Mensagem( Formatar('4430191449', tfFONE) );
  //Mensagem( Formatar('44999851449', tfFONE) );
  //Mensagem( Formatar('123456789012', tfINSC) );
  //Mensagem( Formatar('1500', tfNUMERO) );
  //Mensagem( Formatar('15,00', tfNUMERO) );
  //Mensagem( Formatar('AYC3043', tfPLACA) );

  //Mensagem( MasCNPJCPF('02681433908') );
  //Mensagem( MasCNPJ('74123456000168') );
  //Mensagem( MasCPF('02681433908') );

end.
