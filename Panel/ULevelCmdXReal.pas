unit ULevelCmdXReal;

interface

uses Vcl.Controls, Vcl.ExtCtrls, System.Classes,
  ULevel;

type
  TLevelCmdXReal = class(TWinControl)
  private
    ShCmd, ShReal: TLevel;
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateValue(Cmd, Real: Extended);
  end;

procedure CreateLevel(var Level: TLevelCmdXReal; Panel: TPanel);

implementation

procedure CreateLevel(var Level: TLevelCmdXReal; Panel: TPanel);
begin
  Level := TLevelCmdXReal.Create(Panel.Owner);
  Level.Parent := Panel;
  Level.Align := alClient;
end;

constructor TLevelCmdXReal.Create(AOwner: TComponent);
begin
  inherited;
  ShCmd := TLevel.Create(Self, $000080FF, False);
  ShCmd.Parent := Self;
  ShCmd.Align := alTop;

  ShReal := TLevel.Create(Self, $00804000, False);
  ShReal.Parent := Self;
  ShReal.Align := alClient;
end;

procedure TLevelCmdXReal.Resize;
begin
  inherited;
  ShCmd.Height := Round(Height * 0.4);
end;

procedure TLevelCmdXReal.UpdateValue(Cmd, Real: Extended);
begin
  ShCmd.Value := Cmd;
  ShReal.Value := Real;
end;

end.
