unit ucARQUIVO;

interface

uses
  Classes, SysUtils, Windows, Dialogs, ShellApi, Forms;

type
  TpDataDeCriacao = (tpcAcesso, tpcCriacao, tpcModificacao);

  TcARQUIVO = class
  public
    class function carregar(pArquivo : String) : String;
    class function descarregar(pArquivo, pConteudo : String) : String;
    class function adicionar(pArquivo, pConteudo : String) : String;
    class function copiar(pOrigem, pDestino : String) : String;
    class function excluir(pArquivo : String) : String;
    class function mover(pOrigem, pDestino : String) : String;
    class function listar(pParams : String) : String;

    class function dialog(pParams : String = ''): String;
    class function dialogDir(pParams : String = ''): String;
    class function dialogMultiple(pParams : String): String;
    class function dialogSave(pParams : String): String;

    class function ext(pParams : String = ''): String;

    class function arqTemp(pParams : String = ''): String;

    class function DataDeCriacao(pArquivo : String; pTpDataDeCriacao : TpDataDeCriacao = tpcModificacao): TDateTime;

    class function CopyFileEx(const ASource, ADest: string; ARenameCheck: boolean = false): boolean;
  end;

implementation

uses
  ucDIRETORIO, ucFUNCAO, ucITEM, ucXML, ucPATH;

class function TcARQUIVO.carregar(pArquivo : String) : String;
var
  readcnt : Integer;
  vFile : File;
  vByte : Byte;
begin
  Result := '';

  if not FileExists(pArquivo) then
    Exit;

  AssignFile(vFile, pArquivo);

  FileMode := 0; // modo somente leitura
  Reset(vFile, 1);

  repeat
    BlockRead(vFile, vByte, 1, readcnt);
    if (readcnt <> 0) then Result := Result + Chr(vByte);
  until (readcnt = 0);

  CloseFile(vFile);
end;

class function TcARQUIVO.descarregar(pArquivo, pConteudo : String) : String;
var
  vDir : String;
  vBuffer : Byte;
  vFile : File;
  I : Integer;
begin
  Result := '';

  if FileExists(pArquivo) then
    DeleteFile(PChar(pArquivo));

  vDir := ExtractFileDir(pArquivo);
  ForceDirectories(vDir);

  AssignFile(vFile, pArquivo);
  ReWrite(vFile, 1);

  for I:=1 to Length(pConteudo) do begin
    vBuffer := Ord(pConteudo[I]);
    BlockWrite(vFile, vBuffer, 1);
  end;

  CloseFile(vFile);

  Result := 'OK';
end;

class function TcARQUIVO.adicionar(pArquivo, pConteudo : String) : String;
var
  vFile : TextFile;
begin
  AssignFile(vFile, pArquivo);

  try
    if FileExists(pArquivo) then
      Append(vFile)
    else
      Rewrite(vFile);

    WriteLn(vFile, pConteudo);
  finally
    CloseFile(vFile)
  end;
end;

class function TcARQUIVO.copiar(pOrigem, pDestino : String) : String;
begin
  Result := '';

  if (pOrigem <> '') and (pDestino <> '') then
    if FileExists(pOrigem) then
      CopyFile(PChar(pOrigem), PChar(pDestino), True);
end;

class function TcARQUIVO.excluir(pArquivo : String): String;
var
  vArq : String;
begin
  Result := '';

  while pArquivo <> '' do begin
    vArq := getitem(pArquivo);
    if vArq = '' then Break;
    delitem(pArquivo);

    if FileExists(vArq) then
      DeleteFile(PChar(vArq));
  end;
end;

class function TcARQUIVO.mover(pOrigem, pDestino : String): String;
begin
  Result := '';

  if (pOrigem <> '') and (pDestino <> '') then
    if FileExists(pOrigem) then
      MoveFile(PChar(pOrigem), PChar(pDestino));
end;

class function TcARQUIVO.listar(pParams : String) : String;
const
  cMETHOD = 'TcARQUIVO.listar()';
var
  vFiltro, vResult,
  vLstArquivoDir, vLstArquivo,
  vNaoListar, vExtArquivo, vDirOrigem, vExt : String;
  vInSubPasta, vInSoArquivo, vInSoDiretorio : Boolean;
  SR : TSearchRec;
  R : Integer;
begin
  Result := '';

  vDirOrigem := itemX('DIR_ORIGEM', pParams);
  vExtArquivo := itemX('EXT_ARQUIVO', pParams);
  vNaoListar := itemX('NAO_LISTAR', pParams);
  vInSubPasta := itemXB('IN_SUBPASTA', pParams);
  vInSoArquivo := IfNullB(itemX('IN_SOARQUIVO', pParams), True);
  vInSoDiretorio := itemXB('IN_SODIRETORIO', pParams);
  vFiltro := IfNullS(itemX('DS_FILTRO', pParams), '*.*');

  if vDirOrigem = '' then
    raise Exception.Create('Diretório deve ser informado! / ' + cMETHOD);

  vLstArquivoDir := '';
  vLstArquivo := '';

  R := FindFirst(vDirOrigem + vFiltro, faAnyFile, SR);

  while R = 0 do begin

    // arquivo
    if ((SR.Attr and faDirectory) <> faDirectory) and not (vInSoArquivo) then begin
      vExt := UpperCase(ExtractFileExt(SR.Name));

      if (vExtArquivo = '') or (PosItem(vExt, vExtArquivo) > 0) then begin
        if PosItem(SR.Name, vNaoListar) = 0 then begin
          putitem(vLstArquivoDir, vDirOrigem + SR.Name);
          putitem(vLstArquivo, SR.Name);
        end;
      end;

    // diretorio
    end else begin
      if vInSoDiretorio then begin
        putitem(vLstArquivoDir, vDirOrigem + SR.Name + '\');
        putitem(vLstArquivo, SR.Name);
      end;

      if vInSubPasta then begin
        if Pos(SR.Name, '.|..') = 0 then begin
          putitemX(pParams, 'DIR_ORIGEM', vDirOrigem + SR.Name + '\');
          vResult := listar(pParams);
          if (itemX('LST_ARQUIVODIR', vResult) <> '') then begin
            putitem(vLstArquivoDir, itemX('LST_ARQUIVODIR', vResult));
            putitem(vLstArquivo, itemX('LST_ARQUIVO', vResult));
          end;
        end;
      end;

    end;

    R := FindNext(SR);
  end;

  putitemX(Result, 'LST_ARQUIVODIR', vLstArquivoDir);
  putitemX(Result, 'LST_ARQUIVO', vLstArquivo);
end;

//--

class function TcARQUIVO.dialog(pParams : String): String;
var
  vDialog : TOpenDialog;
  I : Integer;
begin
  Result := '';

  if itemB('IN_SALVAR', pParams) then begin
    vDialog := TSaveDialog.Create(nil);
  end else begin
    vDialog := TOpenDialog.Create(nil);
  end;

  with vDialog do begin
    Filter := item('DS_FIL', pParams);
    DefaultExt := item('DS_EXT', pParams);
    InitialDir := item('DS_DIR', pParams);
    FileName := item('DS_ARQ', pParams);

    if itemB('IN_MULTIPLE', pParams) then
      Options := Options + [ofAllowMultiSelect];

    if Execute then
      if itemB('IN_MULTIPLE', pParams) then begin
        for I:=0 to Files.Count-1 do begin
          putitem(Result, Files[I]);
        end;
      end else
        Result := FileName;

    Free;
  end;
end;

class function TcARQUIVO.dialogDir(pParams : String = ''): String;
begin
  Result := TcDIRETORIO.dialog(pParams);
end;

class function TcARQUIVO.dialogMultiple(pParams : String): String;
begin
  putitem(pParams, 'IN_MULTIPLE', True);
  Result := dialog(pParams);
end;

class function TcARQUIVO.dialogSave(pParams : String): String;
begin
  putitem(pParams, 'IN_SALVAR', True);
  Result := dialog(pParams);
end;

//--

class function TcARQUIVO.ext(pParams : String): String;
begin
  Result := ExtractFileName(Result);
  Result := LowerCase(Result);
end;

//--

class function TcARQUIVO.arqTemp(pParams : String): String;
begin
  Result := TcPATH.Temp() + 'temp.' + FormatDateTime('yyyymmdd.hh_nn_ss', Now) + pParams;
end;

//--

class function TcARQUIVO.DataDeCriacao(pArquivo : String; pTpDataDeCriacao : TpDataDeCriacao): TDateTime;
var
  ffd: TWin32FindData;
  dft: DWORD;
  lft: TFileTime;
  h: THandle;
begin
  Result := 0;
  h := Windows.FindFirstFile(PChar(pArquivo), ffd);
  try
    if (INVALID_HANDLE_VALUE <> h) then begin
      if (pTpDataDeCriacao = tpcAcesso) then FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft) // Acesso
      else if (pTpDataDeCriacao = tpcCriacao) then FileTimeToLocalFileTime(ffd.ftCreationTime, lft) // Criacao
      else FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft); // Modificacao
      FileTimeToDosDateTime(lft, LongRec(dft).Hi, LongRec(dft).Lo);
      Result := FileDateToDateTime(dft);
    end;
  finally
    Windows.FindClose(h);
  end;
end;

//--

class function TcARQUIVO.CopyFileEx(const ASource, ADest: string; ARenameCheck: boolean = false): boolean;
//example
//  CopyFileEx('C:\Windows\System32\drivers\aksclass.sys', 'C:\aksclass.sys');
//uses
//  ShellApi;
var
  sh: TSHFileOpStruct;
begin
  sh.Wnd := Application.Handle;
  sh.wFunc := FO_COPY;

  // Terminated string must be to put the list end with # 0 # 0
  sh.pFrom := PChar(ASource + #0);
  sh.pTo := PChar(ADest + #0);
  sh.fFlags := fof_Silent or fof_MultiDestFiles;
  if ARenameCheck then sh.fFlags := sh.fFlags or fof_RenameOnCollision;
  Result := ShFileOperation(sh) = 0;
end;

//--

end.
