unit ULevelCmdXReal;

interface

uses FMX.Controls, System.Classes, ULevel, FMX.Objects;

type
  TLevelCmdXReal = class(TControl)
  private
    ShCmd, ShReal: TLevel;
  protected
    procedure Resize; override;
  public
    class function CreateByBox(Panel: TRectangle): TLevelCmdXReal;
    constructor Create(AOwner: TComponent); override;

    procedure SetValues(Cmd, Real: Extended);
  end;

implementation

uses System.UITypes, FMX.Types;

class function TLevelCmdXReal.CreateByBox(Panel: TRectangle): TLevelCmdXReal;
begin
  Result := TLevelCmdXReal.Create(Panel.Owner);
  Result.Parent := Panel;
  Result.Align := TAlignLayout.Client;
end;

constructor TLevelCmdXReal.Create(AOwner: TComponent);
begin
  inherited;

  ShCmd := TLevel.Create(Self, TAlphaColors.Orangered);
  ShCmd.Parent := Self;
  ShCmd.Align := TAlignLayout.Top;

  ShReal := TLevel.Create(Self, TAlphaColors.Darkblue);
  ShReal.Parent := Self;
  ShReal.Align := TAlignLayout.Client;
end;

procedure TLevelCmdXReal.Resize;
begin
  inherited;

  ShCmd.Height := Height * 0.4;
end;

procedure TLevelCmdXReal.SetValues(Cmd, Real: Extended);
begin
  ShCmd.SetValue(Cmd);
  ShReal.SetValue(Real);
end;

end.
