program CONVERTER;

uses
  Forms,
  uCONVERTER in 'uCONVERTER.pas' {fCONVERTER};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfCONVERTER, fCONVERTER);
  Application.Run;
end.
