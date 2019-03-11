unit ucPARAMETRO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ucCADASTRO, FMTBcd, SqlExpr, Provider, DB, DBClient, Grids, DBGrids,
  Buttons, ExtCtrls, StdCtrls, ComCtrls, ToolWin, Menus, ucFORM;

type
  TcPARAMETRO = class(TcCADASTRO)
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonGravarClick(Sender: TObject);
    procedure _DataSetAfterOpen(DataSet: TDataSet);
    procedure ToolButtonNovoClick(Sender: TObject);
    procedure ToolButtonExcluirClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses 
  ucFUNCAO, ucMENU, ucDADOS, ucITEM, ucXML;

procedure TcPARAMETRO.FormCreate(Sender: TObject);
begin
  inherited;
  cTabMan := 'ADM_PARAM';
  cKeyMan := 'CD_PARAMETRO';
end;

procedure TcPARAMETRO.ToolButtonGravarClick(Sender: TObject);
begin
  EditCancel.SetFocus;
  p_DesCarregarCampos;
  if (item('VL_PARAMETRO', _DataSet) <> '') then begin
    if (itemF('TP_PARAMETRO', _DataSet) = 1) then begin
      if (StrToDateDef(item('VL_PARAMETRO', _DataSet), -1) = -1) then begin
        raise Exception.Create('Parâmetro do tipo DATA é inválido!');
      end;
    end else if (itemF('TP_PARAMETRO', _DataSet) = 2) then begin
      if (StrToFloatDef(item('VL_PARAMETRO', _DataSet), -1) = -1) then begin
        raise Exception.Create('Parâmetro do tipo NUMÉRICO é inválido!');
      end;
    end;
  end;
  inherited;
end;

procedure TcPARAMETRO._DataSetAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if (dDADOS.gTpPrivilegio <> '1') then begin
    _DataSet.FieldByName('NM_PARAMETRO').Tag := TAG_READONLY;
    _DataSet.FieldByName('TP_PARAMETRO').Tag := TAG_READONLY;
  end;
end;

procedure TcPARAMETRO.ToolButtonNovoClick(Sender: TObject);
begin
  if (dDADOS.gTpPrivilegio <> '1') then
    raise Exception.Create('Permitido inclusão apenas para o usuário SUPORTE!');

  inherited;
end;

procedure TcPARAMETRO.ToolButtonExcluirClick(Sender: TObject);
begin
  if (dDADOS.gTpPrivilegio <> '1') then
    raise Exception.Create('Permitido exclusão apenas para o usuário SUPORTE!');

  inherited;
end;

end.
