unit UFrameEngine;

interface

uses FMX.Forms, FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Classes, FMX.Types, FMX.Objects,
  //
  UPropertyList, ULevelCmdXReal;

type
  TFrameEngine = class(TFrame)
    BoxTitle: TRectangle;
    LbTitle: TLabel;
    BoxThrottle: TRectangle;
    BoxReverser: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    LbCutoff: TLabel;
    LbCranking: TLabel;
    LbIgnition: TLabel;
    LbRunning: TLabel;
    LbStarter: TLabel;
    BoxFrame: TRectangle;
  private
    EngineIndex: Integer;

    LevelThrottle, LevelReverser: TLevelCmdXReal;
  public
    constructor Create(AOwner: TComponent; EngineIndex: Integer); reintroduce;
    procedure UpdateByEngineIndex(L: TPropertyList);
  end;

implementation

{$R *.fmx}


uses System.SysUtils, System.Math;

constructor TFrameEngine.Create(AOwner: TComponent; EngineIndex: Integer);
begin
  inherited Create(AOwner);
  Self.EngineIndex := EngineIndex-1;

  LbTitle.Text := 'ENGINE '+EngineIndex.ToString;

  LevelThrottle := TLevelCmdXReal.CreateByBox(BoxThrottle);
  LevelReverser := TLevelCmdXReal.CreateByBox(BoxReverser);
end;

procedure TFrameEngine.UpdateByEngineIndex(L: TPropertyList);
var
  Eng: TPL_Engine;
  Ctrl: TPL_EngineControls;
begin
  Eng := L.Engines[EngineIndex];
  Ctrl := L.Controls.Engines[EngineIndex];

  LevelThrottle.SetValues(Ctrl.Throttle, Eng.N1 / 100);
  LevelReverser.SetValues(IfThen(Ctrl.Reverser, 1, 0), Eng.Reverser_Pos_Norm);

  LbCutoff.Visible := Eng.Cutoff or Ctrl.Cutoff;
  LbCranking.Visible := Eng.Cranking;
  LbIgnition.Visible := Eng.Ignition;
  LbRunning.Visible := Eng.Running;
  LbStarter.Visible := Eng.Starter;
end;

end.
