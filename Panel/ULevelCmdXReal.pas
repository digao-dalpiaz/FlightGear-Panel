unit ULevelCmdXReal;

interface

uses Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, System.Classes;

type
  TLevelCmdXReal = class(TWinControl)
  private
    ShCmd, ShReal: TShape;
    PnLevels, PnLabels: TPanel;
    LbCmd, LbReal: TLabel;
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateValue(Cmd, Real: Extended);
  end;

procedure CreateLevel(var Level: TLevelCmdXReal; Panel: TPanel);

implementation

uses System.SysUtils, Vcl.Graphics, System.UITypes;

procedure CreateLevel(var Level: TLevelCmdXReal; Panel: TPanel);
begin
  Level := TLevelCmdXReal.Create(Panel.Owner);
  Level.Parent := Panel;
  Level.Align := alClient;
end;

constructor TLevelCmdXReal.Create(AOwner: TComponent);
begin
  inherited;
  PnLevels := TPanel.Create(Self);
  PnLevels.Parent := Self;
  PnLevels.BevelOuter := bvNone;
  PnLevels.ParentBackground := False;
  PnLevels.Color := $00525252;
  PnLevels.Align := alClient;

  PnLabels := TPanel.Create(Self);
  PnLabels.Parent := Self;
  PnLabels.BevelOuter := bvNone;
  PnLabels.ParentBackground := False;
  PnLabels.Color := $00191919;
  PnLabels.Align := alRight;
  PnLabels.Width := 40;

  LbCmd := TLabel.Create(Self);
  LbCmd.Parent := PnLabels;
  LbCmd.AutoSize := False;
  LbCmd.Width := PnLabels.Width;
  LbCmd.Height := 15;
  LbCmd.Alignment := taCenter;

  LbReal := TLabel.Create(Self);
  LbReal.Parent := PnLabels;
  LbReal.AutoSize := False;
  LbReal.Width := PnLabels.Width;
  LbReal.Height := 15;
  LbReal.Alignment := taCenter;

  ShCmd := TShape.Create(Self);
  ShCmd.Parent := PnLevels;
  ShCmd.Brush.Color := $000080FF;
  ShCmd.Pen.Color := ShCmd.Brush.Color;

  ShReal := TShape.Create(Self);
  ShReal.Parent := PnLevels;
  ShReal.Brush.Color := $00804000;
  ShReal.Pen.Color := ShReal.Brush.Color;
end;

procedure TLevelCmdXReal.Resize;
var
  Middle: Integer;
begin
  inherited;

  Middle := Round(Height * 0.4);

  ShCmd.Left := 0;
  ShCmd.Top := 0;
  ShCmd.Height := Middle;

  ShReal.Left := 0;
  ShReal.Top := Middle;
  ShReal.Height := Height - ShReal.Top;

  LbCmd.Top := ShCmd.Top + ((ShCmd.Height-LbCmd.Height) div 2);
  LbReal.Top := ShReal.Top + ((ShReal.Height-LbReal.Height) div 2);
end;

procedure TLevelCmdXReal.UpdateValue(Cmd, Real: Extended);
begin
  ShCmd.Width := Round(PnLevels.Width * Cmd);
  ShReal.Width := Round(PnLevels.Width * Real);

  LbCmd.Caption := FormatFloat('0.00', Cmd);
  LbReal.Caption := FormatFloat('0.00', Real);
end;

end.
