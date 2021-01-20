program FGPanel;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UPropertyList in '..\UPropertyList.pas',
  ULevel in 'ULevel.pas',
  ULevelCmdXReal in 'ULevelCmdXReal.pas',
  UDataProcess in 'UDataProcess.pas',
  UDescentRamp in 'UDescentRamp.pas',
  UFrameEngine in 'UFrameEngine.pas' {FrameEngine: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
