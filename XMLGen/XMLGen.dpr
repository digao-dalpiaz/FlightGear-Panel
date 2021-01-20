program XMLGen;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UPropertyList in '..\UPropertyList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
