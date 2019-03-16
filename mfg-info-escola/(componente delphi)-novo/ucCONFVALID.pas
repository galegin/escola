unit ucCONFVALID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, CheckLst,
  ucCONFMANUT, ucCONFCAMPO;

type
  TcCONFVALID = class(TcCONFMANUT)
    procedure FormCreate(Sender: TObject);
  private
  protected
    function GetFlag(pConfCampo : TcCONFCAMPO) : Boolean; override;
    procedure SetFlag(pConfCampo : TcCONFCAMPO; Value : Boolean); override;
  public
  end;

implementation

{$R *.dfm}

procedure TcCONFVALID.FormCreate(Sender: TObject);
begin
  _Titulo := 'Configura Validação';
  inherited;
end;

function TcCONFVALID.GetFlag(pConfCampo: TcCONFCAMPO): Boolean;
begin
  Result := pConfCampo.InValid;
end;

procedure TcCONFVALID.SetFlag(pConfCampo: TcCONFCAMPO; Value: Boolean);
begin
  pConfCampo.InValid := Value;
end;

end.
