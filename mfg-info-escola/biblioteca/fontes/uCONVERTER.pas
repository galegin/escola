unit uCONVERTER;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DBXpress, DB, SqlExpr, Provider, DBTables,
  DBClient, ComCtrls, Grids, DBGrids, MidasLib, StdCtrls, StrUtils,
  ExtCtrls;

type
  TfCONVERTER = class(TForm)
    ClientDataSet1: TClientDataSet;
    SQLQuery1: TSQLQuery;
    DataSetProvider1: TDataSetProvider;
    SQLConnection1: TSQLConnection;
    Button1: TButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    TGeneros: TTable;
    TGenerosSCBCODGEN: TFloatField;
    TGenerosSCBNOME: TStringField;
    TLivros: TTable;
    TLocadores: TTable;
    TLocadoresSCBCODLOC: TFloatField;
    TLocadoresSCBNOME: TStringField;
    TLocadoresSCBENDERECO: TStringField;
    TLocadoresSCBCIDADE: TStringField;
    TLocadoresSCBUF: TStringField;
    TLocadoresSCBFONE: TStringField;
    TLocadoresSCBCOMP1: TStringField;
    TLocadoresSCBCOMP2: TStringField;
    TLocadoresSCBDEVEDOR: TCurrencyField;
    TLocacoes: TTable;
    TLocacoesSCBCODLOC: TFloatField;
    TLocacoesSCBCODLIV: TFloatField;
    TLocacoesSCBDTLOCACAO: TDateField;
    TLocacoesSCBDTDEVOLUCAO: TDateField;
    TLocacoesSCBDTDEVOLVIDO: TDateField;
    TLocacoesSCBSITUACAO: TFloatField;
    TLocacoesSCBBAIXA: TStringField;
    TEditoras: TTable;
    TEditorasSCBCODEDI: TFloatField;
    TEditorasSCBDESCRICAO: TStringField;
    TLivrosSCBCODLIV: TFloatField;
    TLivrosSCBTITULO: TStringField;
    TLivrosSCBAUTOR: TStringField;
    TLivrosSCBCODGEN: TFloatField;
    TLivrosSCBEDITORA: TStringField;
    TLivrosSCBCODEDI: TFloatField;
    TLivrosSCBVOLUME: TFloatField;
    TLivrosSCBDE: TFloatField;
    TLivrosSCBCOMP: TStringField;
    TLivrosSCBESTANTE: TFloatField;
    TLivrosSCBPARTELEIRA: TFloatField;
    TLivrosSCBEXEMPLARES: TFloatField;
    TLivrosSCBINDICES: TStringField;
    TLivrosSCBFORMA: TStringField;
    TLivrosSCBORIGEM: TStringField;
    TLivrosSCBDTCADASTRO: TDateField;
    TLivrosSCBCIDADE: TStringField;
    TLivrosSCBANO: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    SQLQuery2: TSQLQuery;
    Button2: TButton;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCONVERTER: TfCONVERTER;
  vParar : Boolean;

implementation

{$R *.dfm}

  function SoDigitos(S : String) : String;
  var R : String;
      I : Integer;
  begin
    R := '';
    for I:=1 to Length(S) do
      if S[I] in ['0'..'9'] then
        R := R + Copy(S,I,1);
    Result := R;
  end;

  function SoLetras(S : String) : String;
  var R : String;
      I : Integer;
  begin
    R := '';
    for I:=1 to Length(S) do
      if S[I] in ['A'..'Z','a'..'z',' '] then
        R := R + Copy(S,I,1);
    Result := R;
  end;

  function SoLetrasDigitos(S : String) : String;
  var R : String;
      I : Integer;
  begin
    R := '';
    for I:=1 to Length(S) do
      if S[I] in ['0'..'9','A'..'Z','a'..'z',' '] then
        R := R + Copy(S,I,1);
    Result := R;
  end;

  function Alltrim(Text : string) : string;
  begin
    while Pos(' ',Text) > 0 do
      Delete(Text,Pos(' ',Text),1);
    Result := Text;
  end;

  function TiraAcentos(texto : string): string;
  var i : integer;
  begin
    texto := uppercase(texto);
    for i := 1 to length(texto) do
      case texto[i] of
        'á','Á','à','À','ã','Ã','â','Â': texto[i] := 'A';
        'é','É','ê','Ê': texto[i] := 'E';
        'í','Í': texto[i] := 'I';
        'ó','Ó','õ','Õ','ô','Ô': texto[i] := 'O';
        'ú','Ú': texto[i] := 'U';
        'ç','Ç': texto[i] := 'C';

        '''': texto[i] := ' ';
        '¨': texto[i] := ' ';
//'L&¨PM'
      end;
    result := UpperCase( texto );
  end;

  function AlltrimLateral(Text : string) : string;
  begin
    while (Copy(Text,1,1) =' ') do
      Delete(Text,1,1);
    while (Copy(Text,Length(Text),1) = ' ') do
      Delete(Text,Length(Text),1);
    Result := Text;
  end;

procedure TfCONVERTER.SQLConnection1BeforeConnect(Sender: TObject);
var
  v_Param : TStringList;
begin
  v_Param:=TStringList.Create;
  v_Param.LoadFromFile(ExtractFilePath(Application.ExeName)+'Dados.cfg');
  SQLConnection1.Params.Values['Database']:=v_Param.Strings[0];
  v_Param.Free;
end;

procedure TfCONVERTER.Button1Click(Sender: TObject);
var

  Table : TTable;

  vVlMulta : Real;

//  vContador,
  vCodigo,
  vNrDias : Integer;
//  I

  vDescricao : String;

  vGravar : Boolean;

  S,
  vCD_LIVRO        ,
  vTP_SITUACAO     ,
  vCD_CURSO        ,
  vCD_EDITORA      ,
  vCD_GENERO       ,
  vDS_TITULO       ,
  vDS_AUTOR        ,
  vNR_VOLUME       ,
  vNR_VOLUMEDE     ,
  vNR_CORREDOR     ,
  vNR_PRATELEIRA   ,
  vNR_ANDAR        ,
  vQT_EXEMPLAR     ,
  vDT_AQUISICAO    ,
  vDS_ORIGEM       ,
  vDS_COMPLEMENTO  ,
  vDS_FORMA        ,
  vDS_CIDADE       ,
  vNR_ANO          ,
  vDS_BARRA        : String;

  vTP_ENSINO     ,

  vCD_LOCADOR    ,
  vDT_LOCACAO    ,
  vTP_LOCACAO    ,
  vDT_DEVOLUCAO  ,
  vDT_DEVOLVIDO  ,
  vVL_MULTA      ,
  vDT_PAGOMULTA  : String;

begin
//
  vParar := False;

  SQLConnection1.Connected := True;

  vTP_ENSINO    := '1';

  //Excluir registro anteriores
  if (CheckBox1.Checked = False) then
  begin
    SQLConnection1.ExecuteDirect('delete from LOG_ENTIDADE');
    SQLConnection1.ExecuteDirect('delete from OBS_ENTIDADE');
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 6) then
    begin
      SQLConnection1.ExecuteDirect('delete from GER_LOCACAO');
      SQLConnection1.ExecuteDirect('SET GENERATOR GEN_GER_LOCACAO_ID TO 1');
    end;
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 5) then
    SQLConnection1.ExecuteDirect('delete from GER_LOCADOR');
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 4) then
    SQLConnection1.ExecuteDirect('delete from GER_LIVRO');
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 3) then
    SQLConnection1.ExecuteDirect('delete from GER_GENERO');
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 2) then
    SQLConnection1.ExecuteDirect('delete from GER_EDITORA');
    if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 1) then
    SQLConnection1.ExecuteDirect('delete from GER_CURSO');
  end;

  Memo1.Lines.Clear;

  // ---------------------------------------------------------------------------

  // CURSO

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 1) then
  begin
    ClientDataSet1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('select * from GER_CURSO');
    ClientDataSet1.Open;
    if not (ClientDataSet1.Locate('CD_CURSO', '1', [])) then
    begin
      ClientDataSet1.Append;
      ClientDataSet1.FieldByName('CD_CURSO').asString := '1';
      ClientDataSet1.FieldByName('DS_CURSO').asString := 'GERAL';
      ClientDataSet1.Post;
      ClientDataSet1.ApplyUpdates(0);
    end;
    ClientDataSet1.Close;
  end;

  // ---------------------------------------------------------------------------

  // GENERO

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 2) then
  begin

    Table := TGeneros;
    Label1.Caption := 'Convertendo -> ' + Table.Name;
    Application.ProcessMessages;

    DataSource1.DataSet := Table;

    Table.Close;
    Table.Open;

    ProgressBar1.Position := 1;
    ProgressBar1.Max := Table.RecordCount;
    Application.ProcessMessages;

    ClientDataSet1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('select * from GER_GENERO');
    ClientDataSet1.Open;

    if not (ClientDataSet1.Locate('CD_GENERO', '0', [])) then
    begin
      ClientDataSet1.Append;
      ClientDataSet1.FieldByName('CD_GENERO').asString := '0';
      ClientDataSet1.FieldByName('DS_GENERO').asString := 'SEM GENERO';
      ClientDataSet1.Post;
      ClientDataSet1.ApplyUpdates(0);
    end;

    Table.First;
    while not Table.EOF do
    begin
      Label1.Caption := 'Convertendo -> ' + Table.Name + ' ' + IntToStr( Table.RecNo ) + ' de ' + IntToStr( Table.RecordCount );
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;

      if (ClientDataSet1.Locate('CD_GENERO', TGenerosSCBCODGEN.asString, [])) then
        ClientDataSet1.Edit
      else
      begin
        ClientDataSet1.Append;
        ClientDataSet1.FieldByName('CD_GENERO').asString := TGenerosSCBCODGEN.asString;
        if (CheckBox1.Checked) then Memo1.Lines.Add('Genero / Genero incluido! Genero:' + TGenerosSCBCODGEN.asString);
      end;

      if (Alltrim(TGenerosSCBNOME.asString)='') then
        ClientDataSet1.FieldByName('DS_GENERO').asString := 'SEM GENERO'
      else
        ClientDataSet1.FieldByName('DS_GENERO').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TGenerosSCBNOME.asString ) ) );

      ClientDataSet1.Post;

      Table.Next;
    end;

    ClientDataSet1.ApplyUpdates(0);

    ClientDataSet1.Close;
    Table.Close;

  end;

  // ---------------------------------------------------------------------------

  // EDITORA

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 3) then
  begin

    Table := TEditoras;
    Label1.Caption := 'Convertendo -> ' + Table.Name;
    Application.ProcessMessages;

    DataSource1.DataSet := Table;

    Table.Close;
    Table.Open;

    ProgressBar1.Position := 1;
    ProgressBar1.Max := Table.RecordCount;
    Application.ProcessMessages;

    ClientDataSet1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('select * from GER_EDITORA');
    ClientDataSet1.Open;

    Table.First;
    while not Table.EOF do
    begin
      Label1.Caption := 'Convertendo -> ' + Table.Name + ' ' + IntToStr( Table.RecNo ) + ' de ' + IntToStr( Table.RecordCount );
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;

      if (ClientDataSet1.Locate('CD_EDITORA', TEditorasSCBCODEDI.asString, [])) then
        ClientDataSet1.Edit
      else
      begin
        ClientDataSet1.Append;
        ClientDataSet1.FieldByName('CD_EDITORA').asString := TEditorasSCBCODEDI.asString;
        if (CheckBox1.Checked) then Memo1.Lines.Add('Editora / Editora incluido!  Editora:' + TEditorasSCBCODEDI.asString);
      end;

      if (Alltrim(TGenerosSCBNOME.asString)='') then
        ClientDataSet1.FieldByName('DS_EDITORA').asString := 'SEM EDITORA'
      else
        ClientDataSet1.FieldByName('DS_EDITORA').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TEditorasSCBDESCRICAO.asString ) ) );

      ClientDataSet1.Post;
      Table.Next;
    end;

    ClientDataSet1.ApplyUpdates(0);

    ClientDataSet1.Close;
    Table.Close;

  end;

  // ---------------------------------------------------------------------------

  // LIVRO

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 4) then
  begin

    Table := TLivros;
    Label1.Caption := 'Convertendo -> ' + Table.Name;
    Application.ProcessMessages;

    DataSource1.DataSet := Table;

    Table.Close;
    Table.Open;

    ProgressBar1.Position := 1;
    ProgressBar1.Max := Table.RecordCount;
    Application.ProcessMessages;

    Table.First;

    while not (Table.EOF) and (vParar = False) do
    begin
      Label1.Caption := 'Convertendo -> ' + Table.Name + ' ' + IntToStr( Table.RecNo ) + ' de ' + IntToStr( Table.RecordCount );
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;

      vGravar := True;

      vCD_LIVRO := Trim(TLivrosSCBCODLIV.asString);

      if (vCD_LIVRO = '') then
      begin
        vGravar := False;
      end;

      if (vGravar = True) then
      begin
        with SQLQuery2 do
        begin
          SQLQuery2.Close;
          SQLQuery2.SQL.Clear;
          SQLQuery2.SQL.Add('select CD_LIVRO from GER_LIVRO where CD_LIVRO = '+ vCD_LIVRO +' ');
          SQLQuery2.Open;
          //vGravar := not (SQLQuery2.IsEmpty);
          if (SQLQuery2.FieldByName('CD_LIVRO').asString <> '') then
            vGravar := False;
        end;
      end;

      if (vGravar = True) then
      begin
        if (CheckBox1.Checked) then Memo1.Lines.Add('Livro / Livro incluido! Livro:' + vCD_LIVRO);

        vDescricao := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBEDITORA.asString ) ) );
        if (vDescricao = '') then vDescricao := 'SEM EDITORA';

        with SQLQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * from GER_EDITORA where DS_EDITORA = '''+ vDescricao +''' ');
          Open;
          if not (IsEmpty) then
          begin
            vCodigo := FieldByName('CD_EDITORA').asInteger;
          end
          else
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max(CD_EDITORA) as CODIGO from GER_EDITORA');
            Open;
            if (FieldByName('CODIGO').asString = '') then
              vCodigo := 1
            else
              vCodigo := FieldByName('CODIGO').asInteger + 1;
            SQLConnection.ExecuteDirect('insert into GER_EDITORA values ('+IntToStr(vCodigo)+',1,'''+vDescricao+''')');
          end;
        end;

        vCD_EDITORA := IntToStr( vCodigo );
        vCD_GENERO := TLivrosSCBCODGEN.asString;
        vDS_TITULO := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBTITULO.asString ) ) );
        vDS_AUTOR := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBAUTOR.asString ) ) );
        vNR_VOLUME := TLivrosSCBVOLUME.asString;
        vNR_VOLUMEDE := TLivrosSCBDE.asString;
        vNR_CORREDOR := '';
        vNR_PRATELEIRA := TLivrosSCBPARTELEIRA.asString;
        vNR_ANDAR := TLivrosSCBESTANTE.asString;
        vQT_EXEMPLAR := TLivrosSCBEXEMPLARES.asString;
        if (TLivrosSCBDTCADASTRO.asString <> '') then vDT_AQUISICAO := '''' + FormatDateTime('yyyy/mm/dd',TLivrosSCBDTCADASTRO.Value) + '''';
        vDS_ORIGEM := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBORIGEM.asString ) ) );
        vDS_COMPLEMENTO := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBCOMP.asString ) ) );
        vDS_FORMA := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBFORMA.asString ) ) );
        vDS_CIDADE := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLivrosSCBCIDADE.asString ) ) );
        vNR_ANO := SoDigitos( TLivrosSCBANO.asString );
        vDS_BARRA := '';

        if (vCD_LIVRO     = '') then vCD_LIVRO     := 'null';
        if (vDS_TITULO    = '') then vDS_TITULO    := 'SEM TITULO';
        if (vDS_AUTOR     = '') then vDS_AUTOR     := 'SEM AUTOR';
        if (vTP_SITUACAO  = '') then vTP_SITUACAO  := '1';
        if (vCD_CURSO     = '') then vCD_CURSO     := '1';
        if (vCD_EDITORA   = '') then vCD_EDITORA   := 'null';
        if (vCD_GENERO    = '') then vCD_GENERO    := '0';
        if (vNR_VOLUME    = '') then vNR_VOLUME    := '1';
        if (vNR_VOLUMEDE  = '') then vNR_VOLUMEDE  := '1';
        if (vQT_EXEMPLAR  = '') then vQT_EXEMPLAR  := '1';
        if (vDT_AQUISICAO = '') then vDT_AQUISICAO := 'null';
        if (vNR_ANO       = '') then vNR_ANO       := '2008';
        if (vTP_ENSINO    = '') then vTP_ENSINO    := '1';
        if (vDS_CIDADE    = '') then vDS_CIDADE    := 'CIANORTE';

        S := 'insert into GER_LIVRO (' +
             'CD_LIVRO,' +
             'TP_SITUACAO,' +
             'CD_CURSO,' +
             'CD_EDITORA,' +
             'CD_GENERO,' +
             'DS_TITULO,' +
             'DS_AUTOR,' +
             'NR_VOLUME,' +
             'NR_VOLUMEDE,' +
             'NR_CORREDOR,' +
             'NR_PRATELEIRA,' +
             'NR_ANDAR,' +
             'QT_EXEMPLAR,' +
             'DT_AQUISICAO,' +
             'DS_ORIGEM,' +
             'DS_COMPLEMENTO,' +
             'DS_FORMA,' +
             'DS_CIDADE,' +
             'NR_ANO,' +
             'DS_BARRA,' +
             'TP_ENSINO) values ('+
             vCD_LIVRO        + ',' +
             vTP_SITUACAO     + ',' +
             vCD_CURSO        + ',' +
             vCD_EDITORA      + ',' +
             vCD_GENERO       + ',' +
      '''' + vDS_TITULO       + ''',' +
      '''' + vDS_AUTOR        + ''',' +
             vNR_VOLUME       + ',' +
             vNR_VOLUMEDE     + ',' +
      '''' + vNR_CORREDOR     + ''',' +
      '''' + vNR_PRATELEIRA   + ''',' +
      '''' + vNR_ANDAR        + ''',' +
             vQT_EXEMPLAR     + ',' +
             vDT_AQUISICAO    + ',' +
      '''' + vDS_ORIGEM       + ''',' +
      '''' + vDS_COMPLEMENTO  + ''',' +
      '''' + vDS_FORMA        + ''',' +
      '''' + vDS_CIDADE       + ''',' +
             vNR_ANO          + ',' +
      '''' + vDS_BARRA        + ''',' +
             vTP_ENSINO + ')';

        try
          SQLConnection1.ExecuteDirect( S );
        except
          Memo1.Lines.Add('Livro -> ' + vCD_LIVRO + ' / SQL -> ' + S);
        end;
      end;
      Table.Next;
    end;

    Table.Close;

  end;

  // ---------------------------------------------------------------------------

  // LOCADOR

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 5) then
  begin

    Table := TLocadores;
    Label1.Caption := 'Convertendo -> ' + Table.Name;
    Application.ProcessMessages;

    DataSource1.DataSet := Table;

    Table.Close;
    Table.Open;

    ProgressBar1.Position := 1;
    ProgressBar1.Max := Table.RecordCount;
    Application.ProcessMessages;

    ClientDataSet1.Close;
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add('select * from GER_LOCADOR');
    ClientDataSet1.Open;

    Table.First;
    while not (Table.EOF) and (vParar = False) do
    begin
      Label1.Caption := 'Convertendo -> ' + Table.Name + ' ' + IntToStr( Table.RecNo ) + ' de ' + IntToStr( Table.RecordCount );
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;

      if (ClientDataSet1.Locate('CD_LOCADOR', TLocadoresSCBCODLOC.asString, [])) then
        ClientDataSet1.Edit
      else
      begin
        ClientDataSet1.Append;
        ClientDataSet1.FieldByName('CD_LOCADOR').asString := TLocadoresSCBCODLOC.asString;
        if (CheckBox1.Checked) then Memo1.Lines.Add('Locador / Locador incluido! Locador:' + TLocadoresSCBCODLOC.asString);
      end;

      ClientDataSet1.FieldByName('CD_CURSO').asString := '1';
      ClientDataSet1.FieldByName('NM_LOCADOR').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLocadoresSCBNOME.asString ) ) );
      ClientDataSet1.FieldByName('TP_LOCADOR').asString := '1';
      ClientDataSet1.FieldByName('CD_SERE').asString := '';
      ClientDataSet1.FieldByName('NR_ANO').asString := TLocadoresSCBCOMP1.asString;
      ClientDataSet1.FieldByName('DS_COMPLEMENTO').asString := TLocadoresSCBCOMP2.asString;;
      ClientDataSet1.FieldByName('DT_NASC').asString := '';
      ClientDataSet1.FieldByName('DS_ENDERECO').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLocadoresSCBENDERECO.asString ) ) );
      ClientDataSet1.FieldByName('DS_BAIRRO').asString := '';
      ClientDataSet1.FieldByName('DS_CIDADE').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLocadoresSCBCIDADE.asString ) ) );
      ClientDataSet1.FieldByName('DS_FONE').asString := TLocadoresSCBFONE.asString;
      ClientDataSet1.FieldByName('DS_UF').asString := SoLetrasDigitos( TiraAcentos( AlltrimLateral( TLocadoresSCBUF.asString ) ) );
      ClientDataSet1.FieldByName('TP_ENSINO').asString := vTP_ENSINO;

      if (ClientDataSet1.FieldByName('DS_CIDADE').asString='') then ClientDataSet1.FieldByName('DS_CIDADE').asString := 'CIANORTE';
      if (ClientDataSet1.FieldByName('DS_UF'    ).asString='') then ClientDataSet1.FieldByName('DS_UF'    ).asString := 'PR';

      ClientDataSet1.Post;
      Table.Next;
    end;

    ClientDataSet1.ApplyUpdates(0);

    ClientDataSet1.Close;
    Table.Close;

  end;

  // ---------------------------------------------------------------------------

  // LOCACAO

  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 6) then
  begin

    Table := TLocacoes;
    Label1.Caption := 'Convertendo -> ' + Table.Name;
    Application.ProcessMessages;

    DataSource1.DataSet := Table;

    Table.Close;
    Table.Open;

    ProgressBar1.Position := 1;
    ProgressBar1.Max := Table.RecordCount;
    Application.ProcessMessages;

    Table.First;
    while not (Table.EOF) and (vParar = False) do
    begin
      Label1.Caption := 'Convertendo -> ' + Table.Name + ' ' + IntToStr( Table.RecNo ) + ' de ' + IntToStr( Table.RecordCount );
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;

      vTP_SITUACAO  := '1';
      vCD_LOCADOR   := TLocacoesSCBCODLOC.asString;
      vCD_LIVRO     := TLocacoesSCBCODLIV.asString;
      vTP_LOCACAO   := '1';
      vDT_LOCACAO   := 'null';
      vDT_DEVOLUCAO := 'null';
      vDT_DEVOLVIDO := 'null';
      vVL_MULTA     := '0';
      vDT_PAGOMULTA := 'null';

      vGravar := True;

      // Verificar se o livro existe
      with SQLQuery2 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select * from GER_LIVRO where CD_LIVRO = '''+ vCD_LIVRO +''' ');
        Open;
        vGravar := not (IsEmpty);
        if (vGravar = False) then Memo1.Lines.Add('Locacao / Livro nao existe! Livro:' + vCD_LIVRO);
      end;

      // Verificar se o locador existe
      if (vGravar) then
      begin
        with SQLQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * from GER_LOCADOR where CD_LOCADOR = '''+ vCD_LOCADOR +''' ');
          Open;
          vGravar := not (IsEmpty);
          if (vGravar = False) then Memo1.Lines.Add('Locacao / Locador nao existe! Locador:' + vCD_LOCADOR);
        end;
      end;

      // Verificar a data de devolucao
      if (vGravar) then
      begin
        if (TLocacoesSCBDTLOCACAO.asString <> '') then vDT_LOCACAO := FormatDateTime('yyyy/mm/dd', TLocacoesSCBDTLOCACAO  .Value );
        vGravar := not (vDT_LOCACAO = 'null');
      end;

      // Verificar se a locacao existe
      if (vGravar) then
      begin
        with SQLQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * ');
          SQL.Add('from GER_LOCACAO ');
          SQL.Add('where CD_LOCADOR = '''+ vCD_LOCADOR +''' ');
          SQL.Add('  and CD_LIVRO   = '''+ vCD_LIVRO   +''' ');
          SQL.Add('  and DT_LOCACAO = '''+ vDT_LOCACAO +''' ');
          Open;
          vGravar := not (IsEmpty);
        end;
      end;

      // Inclusao da locacao
      if (vGravar) then
      begin
        if (CheckBox1.Checked) then Memo1.Lines.Add('Locacao / Locacao incluida!  Locador:' + vCD_LOCADOR + ' / Livro:' + vCD_LIVRO + ' / Data locacao: ' + vDT_LOCACAO);

        if (TLocacoesSCBDTLOCACAO  .asString <> '') then vDT_LOCACAO    := '''' + FormatDateTime('yyyy/mm/dd', TLocacoesSCBDTLOCACAO  .Value ) + '''';
        if (TLocacoesSCBDTDEVOLUCAO.asString <> '') then vDT_DEVOLUCAO  := '''' + FormatDateTime('yyyy/mm/dd', TLocacoesSCBDTDEVOLUCAO.Value ) + '''';
        if (TLocacoesSCBDTDEVOLVIDO.asString <> '') then vDT_DEVOLVIDO  := '''' + FormatDateTime('yyyy/mm/dd', TLocacoesSCBDTDEVOLVIDO.Value ) + '''';

        vTP_LOCACAO := TLocacoesSCBSITUACAO.asString;

        if  (TLocacoesSCBDTDEVOLVIDO.asString <> '')
        and (TLocacoesSCBDTDEVOLVIDO.Value > TLocacoesSCBDTDEVOLUCAO.Value) then
        begin
          vNrDias       := StrToInt( FormatFloat('0', TLocacoesSCBDTDEVOLVIDO.Value - TLocacoesSCBDTDEVOLUCAO.Value) );
          vVlMulta      := vNrDias * 0.50;
          vVL_MULTA     := AnsiReplaceStr( FormatFloat('0.00', vVlMulta ), ',', '.');
          if (vTP_LOCACAO = '2') then
          begin
            vDT_PAGOMULTA := '''' + FormatDateTime('yyyy/mm/dd', TLocacoesSCBDTDEVOLVIDO.Value ) + '''';
          end;
        end;

        S := 'insert into GER_LOCACAO ( '+
              'TP_SITUACAO,' +
              'CD_LIVRO,' +
              'CD_LOCADOR,' +
              'DT_LOCACAO,' +
              'TP_LOCACAO,' +
              'DT_DEVOLUCAO,' +
              'DT_DEVOLVIDO,' +
              'VL_MULTA,' +
              'DT_PAGOMULTA) values ('+
              vTP_SITUACAO  + ',' +
              vCD_LIVRO     + ',' +
              vCD_LOCADOR   + ',' +
              vDT_LOCACAO   + ',' +
              vTP_LOCACAO   + ',' +
              vDT_DEVOLUCAO + ',' +
              vDT_DEVOLVIDO + ',' +
              vVL_MULTA     + ',' +
              vDT_PAGOMULTA + ')';

        try
          SQLConnection1.ExecuteDirect( S );
        except
          Memo1.Lines.Add('Locacao / SQL -> ' + S);
        end;
      end;

      Table.Next;
    end;

    Table.Close;

  end;

  SQLConnection1.Connected := False;

  ShowMessage('Convertido com sucesso!');
end;

procedure TfCONVERTER.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('TP_SITUACAO').asString := '1';
end;

procedure TfCONVERTER.Button2Click(Sender: TObject);
begin
  vParar := True;
end;

end.
