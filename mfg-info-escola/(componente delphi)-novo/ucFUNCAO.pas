unit ucFUNCAO; // mFuncao

interface

{Módulos externos - Inclua nesta lista os nomes das Unit's necessárias às suas funções}

uses
  WinProcs, Forms, SysUtils, DB, IniFiles, ShellApi, StrUtils, //DBClient,
  Classes, Typinfo, WinSock, DateUtils, Variants, 
  ucFORMATAR;

  {Protótipos das Funções de Validação Disponíveis}

  function CamIni(Tag : String = '') : String;

  function LerIni(Tag, Campo : String; Padrao : String = '') : String; overload;
  function LerIni(Campo : String) : String; overload;
  function LerIniB(Campo : String) : Boolean;
  function LerIniD(Campo : String) : TDateTime;
  function LerIniF(Campo : String) : Real;
  function LerIniI(Campo : String) : Integer;

  function IsStringFalse(pString : Variant) : Boolean;
  function IsStringTrue(pString : Variant) : Boolean;

  procedure fGravaIni(Tag, Campo : String; Valor : Variant); overload;
  procedure fGravaIni(Campo : String; Valor : Variant); overload;

  function IfNullB(pStr : String; pNul : Boolean) : Boolean;
  function IfNullD(pStr : String; pNul : TDateTime) : TDateTime;
  function IfNullF(pStr : String; pNul : Real) : Real;
  function IfNullI(pStr : String; pNul : Integer) : Integer;
  function IfNullS(pStr : String; pNul : String) : String;
  function IfNullV(pStr : String; pNul : Variant) : Variant;

  function IfThenB(pExp : Boolean; pSim, pNao : Boolean) : Boolean;
  function IfThenD(pExp : Boolean; pSim, pNao : TDateTime) : TDateTime;
  function IfThenF(pExp : Boolean; pSim, pNao : Real) : Real;
  function IfThenI(pExp : Boolean; pSim, pNao : Integer) : Integer;
  function IfThenS(pExp : Boolean; pSim, pNao : String) : String;
  function IfThenV(pExp : Boolean; pSim, pNao : Variant) : Variant;

  procedure ExecutePrograma(sFileName: String; sParam: String = ''; sDir: String = '');

  function cripto(Dado : String) : String;
  function decript(Dado : String) : String;
  function encript(Dado : String) : String;

  procedure MensagemBal(Mem : String);
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

  function TiraAcentosChar(Ch : char): char;
  function TiraAcentos(texto : string): string;

  function PrimeiroNome(Nome : string) : String;
  function Arredonda(valor, mais : real) : Real;

  function Alinhar(pStr : String; pLar : Integer; pTip : TAlignment; pPre : String = ' ') : String;

  function Formatar(pStr : String; pFmt : String) : String; overload;
  function Formatar(pStr : String; pFmt : TpFormatar) : String; overload;

  function DiaDaSemana(Dia : Integer) : String;
  function MesExtenso(Mes : Integer) : String;
  function DataExtenso(Data : String) : String;

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
  function GetData(pAno, pMes, pDia : Integer) : TDateTime; overload;

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

  procedure putitemD(var pVar: String; pVal: Variant; pDem: String = '');

  function posItem(pVal, pVar : String) : Integer;

  function itemcount(pStr : String) : Integer;

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
  ucPROJETO, ucPATH, ucCONST, ucITEM, ucXML, Math;

//--

function CamIni(Tag : String) : String;
begin
  if (Tag = '') then begin
    Result := 'system.ini';
  end else begin
    cArquivoIni := IfNullS(cArquivoIni, ChangeFileExt(ParamStr(0), '.ini'));
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
  vTag := IfNullS(Tag, TcPROJETO.Codigo());

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

function IsStringFalse(pString : Variant) : Boolean;
begin
  Result := (PosItem(UpperCase(VarToStr(pString)), cLST_FALSE) > 0);
end;

function IsStringTrue(pString : Variant) : Boolean;
begin
  Result := (PosItem(UpperCase(VarToStr(pString)), cLST_TRUE) > 0);
end;

//--

procedure fGravaIni(Tag, Campo : String; Valor : Variant);
var
  vTag, vArquivo, vVal : String;
  ArqIni: TIniFile;
begin
  vArquivo := CamIni(Tag);
  vTag := IfNullS(Tag, TcPROJETO.Codigo());
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

function IfNullB(pStr : String; pNul : Boolean) : Boolean;
begin
  if (pStr <> '') then
    Result := Pos(UpperCase(pStr), cLST_TRUE) > 0
  else
    Result := pNul;
end;

function IfNullD(pStr : String; pNul : TDateTime) : TDateTime;
begin
  Result := StrToDateTimeDef(pStr, pNul);
end;

function IfNullF(pStr : String; pNul : Real) : Real;
begin
  Result := StrToFloatDef(pStr, pNul);
end;

function IfNullI(pStr : String; pNul : Integer) : Integer;
begin
  Result := StrToIntDef(pStr, pNul);
end;

function IfNullS(pStr : String; pNul : String) : String;
begin
  Result := IfThen(pStr <> '', pStr, pNul);
end;

function IfNullV(pStr : String; pNul : Variant) : Variant;
begin
  Result := IfThenV(pStr <> '', pStr, pNul);
end;

//--

function IfThenB(pExp : Boolean; pSim, pNao : Boolean) : Boolean;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

function IfThenD(pExp : Boolean; pSim, pNao : TDateTime) : TDateTime;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

function IfThenF(pExp : Boolean; pSim, pNao : Real) : Real;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

function IfThenI(pExp : Boolean; pSim, pNao : Integer) : Integer;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

function IfThenS(pExp : Boolean; pSim, pNao : String) : String;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

function IfThenV(pExp : Boolean; pSim, pNao : Variant) : Variant;
begin
  if (pExp) then Result := pSim else Result := pNao;
end;

//--

procedure ExecutePrograma(sFileName, sParam, sDir: String);
begin
  ShellExecute(0, 'open', PChar(sFileName), PChar(sParam), PChar(sDir), SW_SHOW);
end;

//--

function cripto(Dado : String) : String;
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

//--

procedure MensagemBal(Mem : String);
begin
  MessageBeep(65536);
  Application.MessageBox(PChar(Mem),'.: Informação :.',MB_OK + MB_ICONEXCLAMATION);
end;

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
      { DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0; }
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
      { DF1 := 0;
      DF2 := 0;
      DF3 := 0;
      DF4 := 0;
      DF5 := 0;
      DF6 := 0;
      Resto1 := 0;
      Resto2 := 0;
      PrimeiroDigito := 0;
      SegundoDigito := 0; }
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
    GetVolumeInformation(PChar(FDrive+':\'), dLabel, 12, @Serial, DirLen, Flags, nil, 0);
    Result := IntToHex(Serial,8);
  except
    Result := '';
  end;
end;

//--

function TiraAcentosChar(Ch : char): char;
begin
  Result := UpCase(Ch);
  case Result of
    'á','Á','à','À','ã','Ã','â','Â': Result := 'A';
    'é','É','ê','Ê': Result := 'E';
    'í','Í': Result := 'I';
    'ó','Ó','õ','Õ','ô','Ô': Result := 'O';
    'ú','Ú': Result := 'U';
    'ç','Ç': Result := 'C';
  end;
end;

function TiraAcentos(texto : String): String;
var
  i : integer;
begin
  Result := UpperCase(texto);
  for i := 1 to length(Result) do
    Result[i] := TiraAcentosChar(Result[i]);
end;

//--

function PrimeiroNome(Nome : String) : String;
begin
  Result := '';
  if pos (' ', Nome) > 0 then
    Result := Copy(Nome, 1, Pos(' ', Nome) - 1);
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
  Result := Formatar(pStr, TcFormatar.fmt(pFmt));
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
  Result := FormatDateTime('dddd, d " de " mmmm " de " yyyy', StrToDateDef(Data,0));
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
  Result := FormatDateTime('yyyy/mm', StrToDate('01/' + S));
end;

function YYYYMMtoMMYYYY(S : String) : String;
begin
  Result := FormatDateTime('mm/yyyy', StrToDate('01/' + Copy(S,6,2) + '/' + Copy(S,1,4)));
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
  if (Pos(' ', Result) > 0) then begin
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

function GetData(pAno, pMes, pDia : Integer) : TDateTime;
begin
  Result := EncodeDateTime(pAno, pMes, pDia, 0, 0, 0, 0);
end;

function PriDiaMes(data : TDateTime) : TDateTime;
var
  vAno, vMes : Integer;
begin
  vAno := trunc(GetData(data, 'Y'));
  vMes := trunc(GetData(data, 'M'));
  Result := GetData(vAno, vMes, 1);
end;

function UltDiaMes(data : TDateTime) : TDateTime;
var
  vAno, vMes, vDia : Integer;
begin
  vAno := trunc(GetData(data, 'Y'));
  vMes := trunc(GetData(data, 'M'));

  if vMes = 2 then begin
    vDia := IfThen((trunc(vMes) mod 4 = 0), 29, 28);
  end else begin
    vDia := IfThen((trunc(vMes) in [1,3,5,7,8,10,12]), 31, 30);
  end;

  Result := GetData(vAno, vMes, vDia);
end;

function PriDiaAno(data : TDateTime) : TDateTime;
var
  vAno : Integer;
begin
  vAno := trunc(GetData(data, 'Y'));
  Result := GetData(vAno, 1, 1);
end;

function UltDiaAno(data : TDateTime) : TDateTime;
var
  vAno : Integer;
begin
  vAno := trunc(GetData(data, 'Y'));
  Result := GetData(vAno, 12, 31);
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
  v_Arq : String;
  F : TextFile;
begin
  v_Arq := TcPATH.Log() + TcPROJETO.Codigo() + '.' + FormatDateTime('yyyy.mm.dd',Now) + '.txt';
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
var
  I, vPos, vTam : Integer;
  vLinha, vAux : String;
begin
  for I:=0 to v_Linhas.Count-1 do begin
    vPos := Pos(S1, v_Linhas[I]);
    if (vPos > 0) then begin
      vLinha := v_Linhas[I];
      vAux := Copy(vLinha, 1, vPos-1);
      Delete(vLinha, 1, vPos);
      Delete(vLinha, 1, Pos(',',vLinha));
      vTam := StrToIntDef(Copy(vLinha, 1, Pos('>',vAux)-1), 0);
      Delete(vLinha, 1, Pos('>',vLinha));
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

procedure putitemD(var pVar: String; pVal: Variant; pDem: String);
var
  vVal : String;
begin
  vVal := pVal;
  pVar := pVar + IfThen(pVar<>'',pDem) + vVal;
end;

//--

function posItem(pVal, pVar : String) : Integer;
begin
  if pVal <> '' then
    Result := Pos('|' + pVal + '|', '|' + pVar + '|')
  else
    Result := 0;
end;

//--

function itemcount(pStr : String) : Integer;
var
  vStr : String;
begin
  Result := 0;
  while pStr <> '' do begin
    vStr := getitem(pStr);
    if vStr = '' then Break;
    delitem(pStr);
    Inc(Result);
  end;
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
