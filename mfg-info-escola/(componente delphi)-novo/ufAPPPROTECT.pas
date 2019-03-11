unit ufAppProtect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry;

type
  TfAppProtect = class(TForm)
  public
    LabText: TLabel;
    LabSN: TLabel;
    LabCR: TLabel;
    EdtSN: TEdit;
    EdtCR: TEdit;
    BevUp: TBevel;
    BevDown: TBevel;
    BtnOk: TButton;
    BtnCancel: TButton;
    Rate: Double;
    procedure CreateButtons;
    procedure CreateEdits;
    procedure CreateBevels;
    procedure CreateLabels;
  public
    procedure CreateDialog(AOwner: TComponent);
  end;

implementation

resourcestring
  SInputCaption = 'Código de liberação';
  SInputText    = 'Esta aplicação não está liberada para uso neste computador. ' +
                  'Obtenha com o fabricante o código de liberação da aplicação.';
  SInputSN      = '&Número de série:';
  SInputCR      = 'Código de &liberação:';

const
  FORM_INDENT   = 14;

// CreateDialog
procedure TfAppProtect.CreateDialog(AOwner: TComponent);
begin
  // cria formulário
  BorderStyle := bsDialog;
  Caption := SInputCaption;
  Font.Assign(TForm(AOwner).Font);
  Rate := Canvas.TextWidth('W') / 11;
  Position := poScreenCenter;
  // cria outros componentes
  CreateLabels;
  CreateEdits;
  CreateBevels;
  CreateButtons;
  // ajusta tamanho do formulário
  ClientHeight := BtnOk.Top + BtnOk.Height + Round(Rate * FORM_INDENT);
  ClientWidth := LabText.Left + LabText.Width + Round(Rate * FORM_INDENT);
end;

// CreateLabels
procedure TfAppProtect.CreateLabels;
begin
  // texto
  LabText := TLabel.Create(Self);
  with LabText do begin
    Parent := Self;
    Caption := SInputText;
    Left := Round(Rate * FORM_INDENT);
    Top := Round(Rate * FORM_INDENT);
    Width := Round(Rate * 320);
    WordWrap := True;
  end;
  // número de série
  LabSN := TLabel.Create(Self);
  with LabSN do begin
    Parent := Self;
    Caption := SInputSN;
    Left := LabText.Left;
    Top := LabText.Top + LabText.Height + Round(Rate * FORM_INDENT * 2);
  end;
  // código de reset
  LabCR := TLabel.Create(Self);
  with LabCR do begin
    Parent := Self;
    Caption := SInputCR;
    Left := LabSN.Left;
    Top := LabSN.Top + LabSN.Height + Round(Rate * FORM_INDENT) + 2;
  end;
end;

// CreateEdits
procedure TfAppProtect.CreateEdits;
begin
  // número de série
  EdtSN := TEdit.Create(Self);
  with EdtSN do begin
    Parent := Self;
    Color := clBtnFace;
    ReadOnly := True;
    Top := LabSN.Top - 4;
    Width := Round(Rate * 140);
    Left := LabText.Left + LabText.Width - Width;
    LabSN.FocusControl := EdtSN;
  end;
  // código de reset
  EdtCR := TEdit.Create(Self);
  with EdtCR do begin
    Parent := Self;
    CharCase := ecUpperCase;
    Left := EdtSN.Left;
    Top := LabCR.Top - 4;
    Width := EdtSN.Width;
    TabOrder := 0;
    LabCR.FocusControl := EdtCR;
  end;
end;

// CreateBevels
procedure TfAppProtect.CreateBevels;
begin
  // up
  BevUp := TBevel.Create(Self);
  with BevUp do begin
    Parent := Self;
    Height := 2;
    Left := LabText.Left;
    Top := LabText.Top + LabText.Height + Round(Rate * FORM_INDENT) - 4;
    Width := LabText.Width;
  end;
  // down
  BevDown := TBevel.Create(Self);
  with BevDown do begin
    Parent := Self;
    Height := 2;
    Left := LabText.Left;
    Top := EdtCR.Top + EdtCR.Height + Round(Rate * FORM_INDENT) - 2;
    Width := BevUp.Width;
  end;
end;

// CreateButtons
procedure TfAppProtect.CreateButtons;
begin
  // botão Ok
  BtnOk := TButton.Create(Self);
  with BtnOk do begin
    Parent := Self;
    Caption := '&Ok';
    Default := True;
    ModalResult := mrOk;
    Height := Round(Rate * 25);
    Width := Round(Rate * 80);
    Left := BevDown.Left + (BevDown.Width - ((Width * 2) + Round(Rate * FORM_INDENT * 2))) div 2;
    Top := BevDown.Top + Round(Rate * FORM_INDENT) + 2;
    TabOrder := 1;
  end;
  // botão Cancel
  BtnCancel := TButton.Create(Self);
  with BtnCancel do begin
    Parent := Self;
    Cancel := True;
    Caption := '&Cancel';
    Left := BtnOk.Left + BtnOk.Width + Round(Rate * FORM_INDENT * 2);
    Top := BtnOk.Top;
    Height := BtnOk.Height;
    Width := BtnOk.Width;
    ModalResult := mrCancel;
    TabOrder := 2;
  end;
end;

end.
