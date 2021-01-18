unit UFrameEngine;

interface

uses Vcl.Forms, Vcl.ExtCtrls, Vcl.Controls, Vcl.StdCtrls, System.Classes,
  //
  UPropertyList, ULevelCmdXReal;

type
  TFrameEngine = class(TFrame)
    Panel1: TPanel;
    LbTitle: TLabel;
    Label5: TLabel;
    BoxRev: TPanel;
    LbCranking: TLabel;
    LbIgnition: TLabel;
    LbRunning: TLabel;
    LbStarter: TLabel;
    LbCutOff: TLabel;
    Label1: TLabel;
    BoxThrottle: TPanel;
    Bevel1: TBevel;
  private
    EngineIndex: Integer;

    LevelThrottle, LevelReverser: TLevelCmdXReal;
  public
    constructor Create(AOwner: TComponent; EngineIndex: Integer); reintroduce;
    procedure UpdateByEngineIndex(L: TPropertyList);
  end;

implementation

{$R *.dfm}

uses System.SysUtils, System.Math;

constructor TFrameEngine.Create(AOwner: TComponent; EngineIndex: Integer);
begin
  inherited Create(AOwner);
  Self.EngineIndex := EngineIndex-1;

  LbTitle.Caption := 'ENGINE '+EngineIndex.ToString;

  CreateLevel(LevelThrottle, BoxThrottle);
  CreateLevel(LevelReverser, BoxRev);
end;

procedure TFrameEngine.UpdateByEngineIndex(L: TPropertyList);
var
  Eng: TPL_Engine;
  Ctrl: TPL_EngineControls;
begin
  Eng := L.Engines[EngineIndex];
  Ctrl := L.Controls.Engines[EngineIndex];

  LevelThrottle.UpdateValue(Ctrl.Throttle, Eng.Itt_Norm);
  LevelReverser.UpdateValue(IfThen(Ctrl.Reverser, 1, 0), Eng.Reverser_Pos_Norm);

  LbCutOff.Visible := Ctrl.CutOff;
  LbCranking.Visible := Eng.Cranking;
  LbIgnition.Visible := Eng.Ignition;
  LbRunning.Visible := Eng.Running;
  LbStarter.Visible := Eng.Starter;
end;

end.
