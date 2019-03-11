unit ucRELATORIO;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, DBClient, Printers,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, QRPrntr, IBTable, DB, DBTables,
  Dialogs, MidasLib, StrUtils;

type
  TcRELATORIO = class(TQuickRep)
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData3: TQRSysData;
    QRLabel2: TQRLabel;
    GroupBand1: TQRGroup;
    TotalGroupBand1: TQRBand;
    QRApplication: TQRLabel;
    QRCidade: TQRLabel;
    QRSubTotal: TQRLabel;
    QRTotal: TQRLabel;
    QRNome: TQRLabel;
    QRExprMemo1: TQRExprMemo;
    QRMemo1: TQRMemo;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1CD_TESTE: TIntegerField;
    ClientDataSet1DS_TESTE: TStringField;
    QRLabelTitulo: TQRLabel;
    QRLabelDetalhe: TQRLabel;
    QRSysData2: TQRSysData;
    procedure QuickRepPreview(Sender: TObject);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ColumnHeaderBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure GroupBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure TotalGroupBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure PageFooterBand1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    cSql, cCaptionRel, cFiltro, cOrientacao, cPapelSize, cTitulo,
    cTamRep, cDesRep, cColRep, cAgrRep, cTotRep : String;

    bRodape : Boolean;

    FSoma, FSubSoma,
    FMedia, FSubMedia,
    FQtde, FSubQtde : Real;
    FCont, FSubCont : Integer;

    FSomaTotal, FSomaMedia, FSomaQtde : String;

    bAutomatico,
    bExpressao : Boolean;
    cTabela : TDataSet;
  public
    class procedure Executar(pDataSet : TDataSet; pCaption, pFiltro, pSql : String;
      pStringList : TStringList; pPreparar : Boolean = False);
  end;

const
  esp = '                                                                     ';

implementation

{$R *.DFM}

uses
  ucCONFPAGINA, ucPREVIEW, ucFUNCAO, ucDADOS, ucCONST, ucCOMP, ucITEM, ucXML;

//--------------------------------------- PRINCIPAL

class procedure TcRELATORIO.Executar(pDataSet : TDataSet; pCaption, pFiltro, pSql : String;
  pStringList : TStringList; pPreparar : Boolean);
var
  vExpressao, vIndex, vLstExpr, vLstAux, vAux, vVal : String;
  I, X, vCont, vLarg : Integer;
  vLista : TStringList;
begin
  with TcRELATORIO.Create(Application) do
  try
    cTabela := pDataSet;
    cCaptionRel := pCaption;
    cSql := pSql;
    cFiltro := AnsiReplaceStr(pFiltro, '/*WHERE*/', '');

    cOrientacao := IfNullS(LerIni(cCaptionRel, ORI_REP), 'R');
    cPapelSize := IfNullS(LerIni(cCaptionRel, PAP_REP), 'A4');
    cTitulo := IfNullS(LerIni(cCaptionRel, TIT_REP), cCaptionRel,);

    bAutomatico := IfNullB(LerIni(cCaptionRel,AUT_REP), True);

    if IfNullB(LerIni(cCaptionRel, CFG_REP), False) then
      if not TcCONFPAGINA.Executar(cPapelSize, cOrientacao) then
        Exit;

    cColRep := LerIni(cCaptionRel, COL_REP);
    cTamRep := LerIni(cCaptionRel, TAM_REP);
    cDesRep := LerIni(cCaptionRel, DES_REP);
    cAgrRep := LerIni(cCaptionRel, AGR_REP);
    cTotRep := LerIni(cCaptionRel, TOT_REP);

    PageHeaderBand1.Enabled := IfNullB(LerIni(cCaptionRel, CAB_BND), True);
    TitleBand1.Enabled := IfNullB(LerIni(cCaptionRel, TIT_BND), True);
    ColumnHeaderBand1.Enabled := IfNullB(LerIni(cCaptionRel, COL_BND), True);
    DetailBand1.Enabled := IfNullB(LerIni(cCaptionRel, DET_BND), True);
    SummaryBand1.Enabled := IfNullB(LerIni(cCaptionRel, SUM_BND), False);
    PageFooterBand1.Enabled := IfNullB(LerIni(cCaptionRel, ROD_BND), True);
    GroupBand1.Enabled := IfNullB(LerIni(cCaptionRel, AGR_BND), False);
    TotalGroupBand1.Enabled := IfNullB(LerIni(cCaptionRel, TOT_BND), False);

    bRodape := True;

    if (pDataSet <> nil) then
      vIndex := TClientDataSet(pDataSet).IndexFieldNames;

    ReportTitle := 'Relatório de ' + cTitulo;
    DataSet := pDataSet;

    PageFooterBand1.Enabled := bRodape;

    if (cOrientacao='R') then
      Page.Orientation := poPortrait
    else
      Page.Orientation := poLandscape;

    if (cPapelSize = 'A4') then
      Page.PaperSize := A4
    else if (cPapelSize = 'Carta') then
      Page.PaperSize := Letter
    else if (cPapelSize = 'Legal') then
      Page.PaperSize := Legal;

    QRLabelTitulo.Enabled := False;
    QRLabelDetalhe.Enabled := False;

    if (pDataSet <> nil) then begin
      vLista := TStringList.Create;
      if (cColRep <> '') then begin
        TcStringList(vLista).p_AddLista(cColRep);
      end else begin
        with pDataSet do
          for I := 0 to FieldCount-1 do
            with Fields[I] do
              if Visible then
                vLista.Add(FieldName);
      end;

      if (cAgrRep <> '') then begin
        GroupBand1.Enabled := True;
        GroupBand1.Expression := getitem(cAgrRep);
        if pDataSet is TClientDataSet then
          TClientDataSet(pDataSet).IndexFieldNames := getitem(cAgrRep);

        vLstExpr := '';
        vLstAux := cAgrRep;
        while vLstAux <> '' do begin
          vAux := getitem(vLstAux);
          if vAux = '' then Break;
          delitem(vLstAux);
          putitemD(vLstExpr, '{' + vAux + '}', ' - ');
        end;
        QRExprMemo1.Lines.Text := vLstExpr;
        QRExprMemo1.Width := GroupBand1.Width;
      end;

      FSomaTotal := getitem(cTotRep,1);
      if (FSomaQtde <> '') or (FSomaMedia <> '') or (FSomaTotal <> '') then begin
        TotalGroupBand1.Enabled := ((FSomaQtde <> '') or (FSomaMedia <> '') or (FSomaTotal <> '')) and (cAgrRep <> '');
      end;
      QRSubTotal.Enabled := (FSomaQtde <> '') or (FSomaMedia <> '') or (FSomaTotal <> '');
      SummaryBand1.Enabled := True;
      QRTotal.Enabled := True;

      bExpressao := False;
      vExpressao := '';

      vCont := 10;

      QRLabelTitulo.Enabled := bAutomatico;
      QRLabelDetalhe.Enabled := bAutomatico;

      if (bAutomatico) then begin

        ColumnHeaderBand1.Color := QRLabelTitulo.Color;

        with pDataSet do
          for I := 0 to FieldCount-1 do
            with Fields[I] do begin
              if (Visible) then begin
                if DataType in [ftCurrency, ftFloat, ftBCD, ftFmtBCD] then begin
                  vVal := DisplayLabel;
                  vVal := Copy(Esp, 1, DisplayWidth - Length(vVal)) + vVal;
                  vAux := vAux + vVal + ' ';
                end else begin
                  vAux := vAux + Copy(DisplayLabel + Esp, 1, DisplayWidth) + ' ';
                end;
              end;
            end;

        QRLabelTitulo.Caption := vAux;

      end else begin

        with pDataSet do
          for I := 0 to FieldCount-1 do begin
            with Fields[I] do begin
              X := vLista.IndexOf(FieldName);

              if Pos(FieldName,cAgrRep) > 0 then
                X := -1;

              if (X <> -1) then begin
                vLarg := DisplayWidth * 8;

                if (cTamRep <> '') then
                  if (item(FieldName, cTamRep) <> '') then
                    DisplayWidth := itemI(FieldName, cTamRep);

                if (bExpressao) then begin
                  putitemD(vExpressao, '{' + FieldName + '}', ' ');
                end else begin
                  with TQRLabel.Create(Application) do begin
                    Alignment := Alignment;
                    AutoSize := False;
                    Name := 'QRLabel' + FieldName;
                    if (cDesRep <> '') and (item(FieldName, cDesRep) <> '') then
                      Caption := item(FieldName, cDesRep)
                    else
                      Caption := PriMaiuscula(DisplayLabel);
                    Parent := ColumnHeaderBand1;
                    Font.Style := [fsBold];
                    Font.Size := 8;
                    Top := 3;
                    Left := vCont;
                    Width := vLarg;
                    Transparent := True;
                  end;

                  with TQRDBText.Create(Application) do begin
                    AutoSize := False;
                    DataSet := pDataSet;
                    DataField := FieldName;
                    Alignment := Alignment;
                    Name := 'QRDBText' + FieldName;
                    Parent := DetailBand1;
                    Left := vCont;
                    Width := vLarg;
                    Top := 3;
                  end;
                end;

                Inc(vCont, vLarg + 4);
              end;
            end;
          end;

      end;
    end;

    if (pStringList <> nil) then begin
      if (pStringList.Count > 0) then begin
        QRMemo1.Lines.Text := pStringList.Text;
        SummaryBand1.Enabled := True;
      end;
    end;

    if (pDataSet <> nil) then
      pDataSet.DisableControls;

    if (pPreparar) then begin
      Prepare;
      //FPagCount := QRPrinter.PageCount;
    end;

    if IfNullB(LerIni(cCaptionRel, VIS_REP), True) then
      Preview
    else
      Print;

    if (pDataSet <> nil) then begin
      TClientDataSet(pDataSet).IndexFieldNames := vIndex;
      pDataSet.EnableControls;
    end;  
  finally
    Free;
  end;
end;

procedure TcRELATORIO.QuickRepPreview(Sender: TObject);
begin
  with TcPREVIEW.Create(Application) do begin
    _Preview.QRPrinter := TQRPrinter(Sender);
    _ClientDataSet := TClientDataSet(cTabela);
    _CaptionRel := Self.cCaptionRel;
    _Sql := Self.cSql;
    Show;
  end;

  FCont := 0;
  if (FSomaQtde <> '') then FQtde := 0;
  if (FSomaMedia <> '') then FMedia := 0;
  if (FSomaTotal <> '') then FSoma := 0;
end;

procedure TcRELATORIO.PageFooterBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRApplication.Caption := Application.Title;
  //Inc(FPag);
  //QRLabel1.Caption := 'Página ' + IntToStr(FPag) + ' de ' + IntToStr(FPagCount);
end;

procedure TcRELATORIO.TitleBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRTitulo.Caption := ReportTitle;
  if (cFiltro <> '') then
    QRTitulo.Caption := QRTitulo.Caption + #13 + 'Filtro: ' + cFiltro;
  //FPag := 0;
end;

procedure TcRELATORIO.PageHeaderBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  vNmNome, vNmCidade, vNmEstado : String;
begin
  QRNome.Left := 0;
  QRNome.Width := PageHeaderBand1.Width;
  QRCidade.Left := 0;
  QRCidade.Width := PageHeaderBand1.Width;
  QRTitulo.Left := 0;
  QRTitulo.Width := PageHeaderBand1.Width;
  QRSubTotal.Left := 0;
  QRSubTotal.Width := PageHeaderBand1.Width;
  QRTotal.Left := 0;
  QRTotal.Width := PageHeaderBand1.Width;
  QRMemo1.Left := 0;
  QRMemo1.Width := PageHeaderBand1.Width;

  QRSysData1.Left := PageHeaderBand1.Width - QRSysData1.Width;
  QRSysData2.Left := (PageHeaderBand1.Width div 2) - (QRSysData2.Left div 2);
  QRLabel2.Left := PageHeaderBand1.Width - QRLabel2.Width;

  QRNome.Caption := Application.Title;
  QRCidade.Caption := 'Cianorte (Pr)';

  vNmNome := dDADOS.f_LerParametro('NM_ESCOLA');
  if (vNmNome = '') then vNmNome := dDADOS.f_LerParametro('NM_EMPRESA');
  if (vNmNome <> '') then QRNome.Caption := vNmNome;

  vNmCidade := dDADOS.f_LerParametro('NM_CIDADE');
  vNmEstado := dDADOS.f_LerParametro('NM_ESTADO');

  if (vNmCidade <> '') and (vNmEstado <> '') then
    QRCidade.Caption := vNmCidade + ' (' + vNmEstado + ')';
end;

procedure TcRELATORIO.QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  FCont := 0;
  if (FSomaQtde <> '') then FQtde := 0;
  if (FSomaMedia <> '') then FMedia := 0;
  if (FSomaTotal <> '') then FSoma := 0;
end;

procedure TcRELATORIO.GroupBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  FSubCont := 0;
  if (FSomaQtde <> '') then FSubQtde := 0;
  if (FSomaMedia <> '') then FSubMedia := 0;
  if (FSomaTotal <> '') then FSubSoma := 0;
end;

procedure TcRELATORIO.ColumnHeaderBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRLabelTitulo.Width := ColumnHeaderBand1.Width;
  QRLabelDetalhe.Width := ColumnHeaderBand1.Width;
end;

procedure TcRELATORIO.DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  vAux, vVal, vLst : String;
  pDataSet : TDataSet;
  I : Integer;
begin
  if (DataSet = nil) then Exit;

  pDataSet := DataSet;

  if (bAutomatico) then begin

    with pDataSet do begin
      for I := 0 to FieldCount-1 do begin
        with Fields[I] do begin
          if (Visible) then begin

            vLst := itemX(FieldName, cLST_TIPAGEM);
            if (vLst <> '') then begin
              vVal := item(Text, vLst);
              vAux := vAux + Copy(vVal + Esp, 1, DisplayWidth) + ' ';
            end else if DataType in [ftCurrency, ftFloat, ftBCD, ftFmtBCD] then begin
              vVal := FormatFloat('0.00',AsFloat);
              vVal := Copy(Esp,1,DisplayWidth - Length(vVal)) + vVal;
              vAux := vAux + vVal + ' ';
            end else begin
              vAux := vAux + Copy(Text + Esp, 1, DisplayWidth) + ' ';
            end;

          end;
        end;
      end;
    end;

    QRLabelDetalhe.Caption := vAux;
  end;

  QRExprMemo1.Left := 2;
  QRExprMemo1.Width := DetailBand1.Width - 4;

  Inc(FSubCont);
  Inc(FCont);
  if (FSomaTotal <> '') then begin
    FSubSoma := FSubSoma + itemF(FSomaTotal, pDataSet);
    FSoma := FSoma + itemF(FSomaTotal, pDataSet);
  end;
  if (FSomaMedia <> '') then begin
    FSubMedia := FSubMedia + itemF(FSomaMedia, pDataSet);
    FMedia := FMedia + itemF(FSomaMedia, pDataSet);
  end;
  if (FSomaQtde <> '') then begin
    FSubQtde := FSubQtde + itemF(FSomaQtde, pDataSet);
    FQtde := FQtde + itemF(FSomaQtde, pDataSet);
  end;
end;

procedure TcRELATORIO.TotalGroupBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with QRSubTotal do begin
    Caption := '';
    if (FSomaQtde <> '') then
      Caption := Caption + Format('%30s', ['Sub Total Qtde: ' + FormatFloat('#,##0.00', FSubQtde)]);
    if (FSomaMedia <> '') then
      Caption := Caption + Format('%30s', ['Sub Total Média: ' + FormatFloat('#,##0.00', FSubMedia / FSubCont)]);
    if (FSomaTotal <> '') then
      Caption := Caption + Format('%30s', ['Sub Total Geral: ' + FormatFloat('#,##0.00', FSubSoma)]);
  end;
end;

procedure TcRELATORIO.SummaryBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with QRTotal do begin
    if (FSomaQtde <> '') or (FSomaMedia <> '') or (FSomaTotal <> '') then begin
      Caption := '';
      if (FSomaQtde <> '') then
        Caption := Caption + Format('%30s', ['Total Qtde: ' + FormatFloat('#,##0.00', FQtde)]);
      if (FSomaMedia <> '') then
        Caption := Caption + Format('%30s', ['Total Média: ' + FormatFloat('#,##0.00', FMedia / FCont)]);
      if (FSomaTotal <> '') then
        Caption := Caption + Format('%30s', ['Total Geral: ' + FormatFloat('#,##0.00', FSoma)]);
    end else
      Caption := Format('%30s',['Total Registros: ' + IntToStr(FCont)]);
  end;
end;

procedure TcRELATORIO.PageFooterBand1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  //Inc(FPag);
end;

end.