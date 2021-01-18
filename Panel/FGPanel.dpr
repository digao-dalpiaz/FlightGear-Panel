program FGPanel;

uses
  Vcl.Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UPropertyList in '..\UPropertyList.pas',
  UDataProcess in 'UDataProcess.pas',
  UFrameEngine in 'UFrameEngine.pas' {FrameEngine: TFrame},
  ULevelCmdXReal in 'ULevelCmdXReal.pas',
  UDescentRamp in 'UDescentRamp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
