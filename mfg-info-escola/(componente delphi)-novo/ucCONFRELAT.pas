unit ucCONFRELAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFMANUT, ucCONFCAMPO;

type
  TcCONFRELAT = class(TcCONFMANUT)
    procedure FormCreate(Sender: TObject);
  private
  protected
    function GetFlag(pConfCampo : TcCONFCAMPO) : Boolean; override;
    procedure SetFlag(pConfCampo : TcCONFCAMPO; Value : Boolean); override;
  public
  end;

implementation

{$R *.dfm}

procedure TcCONFRELAT.FormCreate(Sender: TObject);
begin
  _Titulo := 'Configura Relatório';
  inherited;
end;

function TcCONFRELAT.GetFlag(pConfCampo: TcCONFCAMPO): Boolean;
begin
  Result := pConfCampo.InRelat;
end;

procedure TcCONFRELAT.SetFlag(pConfCampo: TcCONFCAMPO; Value: Boolean);
begin
  pConfCampo.InRelat := Value;
end;

end.
