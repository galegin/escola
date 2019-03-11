unit uINFLIV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfINFLIV = class(TForm)
    Panel4: TPanel;
    LabelLocador: TLabel;
    fCD_LOCADOR: TEdit;
    dfCD_LOCADOR: TEdit;
    LabelLivro: TLabel;
    fCD_LIVRO: TEdit;
    dfCD_LIVRO: TEdit;
    LabelDevolucao: TLabel;
    fDT_DEVOLUCAO: TEdit;
    LabelExemplar: TLabel;
    fNR_EXEMPLAR: TEdit;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    Label1: TLabel;
    QT_EXEMPLAR: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditExit(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure EditDblClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure fNR_EXEMPLAREnter(Sender: TObject);
  private
    cCaption : String;
  public
  published
    class function execute(pParams : String = '') : String;
  end;

const
  TAG_FK = 2;

implementation

{$R *.dfm}

uses
  ucCADASTROFUNC, ucCADASTRO, ucCONST, ucFUNCAO, ucMENU,
  ucDADOS, ucFORM, ucITEM, ucXML;

class function TfINFLIV.execute(pParams : String) : String;
begin
  Result := '';

  with TfINFLIV.Create(Application) do begin
    try
      try
        fCD_LIVRO.Text := itemX('CD_LIVRO', pParams);
        fCD_LOCADOR.Text := itemX('CD_LOCADOR', pParams);
        fDT_DEVOLUCAO.Text := itemX('DT_DEVOLUCAO', pParams);
        fNR_EXEMPLAR.Text := IfNullS(itemX('NR_EXEMPLAR', pParams), '1');
        if ShowModal = mrOk then begin
          putitemX(Result, 'status', 1);
          putitemX(Result, 'CD_LIVRO', fCD_LIVRO.Text);
          putitemX(Result, 'CD_LOCADOR', fCD_LOCADOR.Text);
          putitemX(Result, 'DT_DEVOLUCAO', fDT_DEVOLUCAO.Text);
          putitemX(Result, 'NR_EXEMPLAR', fNR_EXEMPLAR.Text);
        end;
      except
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfINFLIV.FormCreate(Sender: TObject);
begin
  cCaption := ClassName;

  TcCADASTROFUNC.CorrigeCarregaImagem(Self);

  fCD_LOCADOR.Tag := TAG_FK;
  fCD_LOCADOR.Hint := 'CD_CAMPO=CD_LOCADOR;DS_TABELA=GER_LOCADOR;DS_CAMPO=NM_LOCADOR';
  fCD_LOCADOR.OnExit := EditExit;
  fCD_LOCADOR.OnChange := EditChange;
  fCD_LOCADOR.OnDblClick := EditDblClick;
  fCD_LOCADOR.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;

  fCD_LIVRO.Tag := TAG_FK;
  fCD_LIVRO.Hint := 'CD_CAMPO=CD_LIVRO;DS_TABELA=GER_LIVRO;DS_CAMPO=DS_TITULO';
  fCD_LIVRO.OnExit := EditExit;
  fCD_LIVRO.OnChange := EditChange;
  fCD_LIVRO.OnDblClick := EditDblClick;
  fCD_LIVRO.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;

  fDT_DEVOLUCAO.OnExit := TcCADASTROFUNC.EditValidaData;
  fDT_DEVOLUCAO.OnKeyPress := TcCADASTROFUNC.EditKeyPressData;

  fNR_EXEMPLAR.OnExit := TcCADASTROFUNC.EditValidaInteiro;
  fNR_EXEMPLAR.OnKeyPress := TcCADASTROFUNC.EditKeyPressInteiro;
  fNR_EXEMPLAR.Text := '1';

  TcCADASTROFUNC.CorrigeShapeTela(Self);

  if IfNullB(LerIni(cCaption, CAD_DES), True) then begin
    TcFORM(Self).p_SetarDescr(dfCD_LIVRO, mfConsulta);
    TcFORM(Self).p_SetarDescr(dfCD_LOCADOR, mfConsulta);
  end;
end;

procedure TfINFLIV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE, VK_F12: BtnCancel.Click;
    VK_RETURN: keybd_event(VK_TAB, 0, 0, 0);
  end;
end;

procedure TfINFLIV.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Key := TiraAcentosChar(UpCase(Key));
end;

procedure TfINFLIV.EditExit(Sender: TObject);
var
  vEditCod, vEditDes : TEdit;
  vParams : String;
begin
  vEditCod := TEdit(Sender);

  if (vEditCod.Hint <> '') and (vEditCod.Tag = TAG_FK) then begin
    vEditDes := TEdit(FindComponent('d' + vEditCod.Name));
    if vEditDes <> nil then begin
      vParams := vEditCod.Hint;
      putitem(vParams, 'CD_VALUE', vEditCod.Text);
      vEditDes.Text := dDADOS.f_BuscarDescricao(vParams);
    end;
  end;
end;

procedure TfINFLIV.EditChange(Sender: TObject);
begin
  if (TEdit(Sender).Tag <> TAG_FK) then
    Exit;
  EditExit(Sender);
end;

procedure TfINFLIV.EditDblClick(Sender: TObject);
var
  vResult : String;
begin
  vResult := cMENU.AbreTela(Copy(TEdit(Sender).Name,2,Length(TEdit(Sender).Name)-1));
  if (vResult <> '') then
    TEdit(Sender).Text := vResult;
  ModalResult := mrNone;
end;

procedure TfINFLIV.BtnOkClick(Sender: TObject);
begin
  //Efetua validacao do locador
  if (fCD_LOCADOR.Text = '') then begin
    fCD_LOCADOR.SetFocus;
    raise Exception.Create('Locador deve ser informado!');
  end;
  if (dfCD_LOCADOR.Text = '') then begin
    fCD_LOCADOR.SetFocus;
    raise Exception.Create('Locador informado não cadastrado!');
  end;

  //Efetua validacao do livro
  if (fCD_LIVRO.Text = '') then begin
    fCD_LIVRO.SetFocus;
    raise Exception.Create('Livro deve ser informado!');
  end;
  if (dfCD_LIVRO.Text = '') then begin
    fCD_LIVRO.SetFocus;
    raise Exception.Create('Livro informado não cadastrado!');
  end;

  //Efetua validacao data de devolucao
  if (fDT_DEVOLUCAO.Text = '') then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolucao deve ser informada!');
  end;
  if (StrToDateDef(fDT_DEVOLUCAO.Text,-1) = -1) then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolução informada é inválida!');
  end;
  if (StrToDateDef(fDT_DEVOLUCAO.Text,-1) <= Date) then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolução deve ser maior que a data do sistema!');
  end;

  //Efetua validacao data de devolucao
  if (fDT_DEVOLUCAO.Text = '') then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolucao deve ser informada!');
  end;
  if (StrToDateDef(fDT_DEVOLUCAO.Text,-1) = -1) then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolução informada é inválida!');
  end;
  if (StrToDateDef(fDT_DEVOLUCAO.Text,-1) <= Date) then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Data de devolução deve ser maior que a data do sistema!');
  end;

  //Efetua validacao data de devolucao
  if (fNR_EXEMPLAR.Text = '') then begin
    fNR_EXEMPLAR.SetFocus;
    raise Exception.Create('Exemplar deve ser informado!');
  end;
  if (StrToIntDef(fNR_EXEMPLAR.Text,-1) = -1) then begin
    fDT_DEVOLUCAO.SetFocus;
    raise Exception.Create('Exemplar informado é inválido!');
  end;

  ModalResult := mrOk;
end;

procedure TfINFLIV.fNR_EXEMPLAREnter(Sender: TObject);
begin
  if fCD_LIVRO.Text <> '' then
    QT_EXEMPLAR.Text := dDADOS.f_ConsultaStrSql('select QT_EXEMPLAR from GER_LIVRO where CD_LIVRO = ''' + fCD_LIVRO.Text + ''' ', 'QT_EXEMPLAR')
  else
    QT_EXEMPLAR.Text := '';
end;

end.
