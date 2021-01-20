unit ULevel;

interface

uses FMX.Controls, System.Classes, System.UITypes;

type
  TLevel = class(TControl)
  private
    FColor: TAlphaColor;
    FVertical: Boolean;

    FValue: Extended;
    FInfo: string;
  protected
    procedure Paint; override;
  public
    procedure SetValue(Value: Extended; const Info: string = '');
    constructor Create(AOwner: TComponent; Color: TAlphaColor; Vertical: Boolean = False); reintroduce;
  end;

implementation

uses System.Types, FMX.Graphics, FMX.Types, System.SysUtils,
  System.Math;

constructor TLevel.Create(AOwner: TComponent; Color: TAlphaColor; Vertical: Boolean);
begin
  inherited Create(AOwner);

  FColor := Color;
  FVertical := Vertical;
end;

procedure TLevel.Paint;
var
  R: TRectF;
  Text: string;
  Factor: Extended;
  P: TPointF;
  VA, HA: TTextAlign;
begin
  inherited;

  if FValue>0 then
  begin
    Factor := Min(FValue, 1);

    if FVertical then
      P := TPointF.Create(Width, Height * Factor)
    else
      P := TPointF.Create(Width * Factor, Height);

    Canvas.Fill.Color := FColor;
    Canvas.FillRect(TRectF.Create(TPointF.Zero, P),
      3, 3, [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft, TCorner.BottomRight], 1);
  end;

  R := LocalRect;
  if FVertical then
  begin
    R.Top := R.Top+8;
    VA := TTextAlign.Leading;
    HA := TTextAlign.Center;
  end else
  begin
    R.Left := R.Left+8;
    VA := TTextAlign.Center;
    HA := TTextAlign.Leading;
  end;

  if not FInfo.IsEmpty then
    Text := FInfo
  else
    Text := FormatFloat('0.00', FValue);

  Canvas.Fill.Color := TAlphaColors.White;
  Canvas.FillText(R, Text, False, 1, [], HA, VA);
end;

procedure TLevel.SetValue(Value: Extended; const Info: string);
begin
  if (FValue<>Value) or (FInfo<>Info) then
  begin
    FValue := Value;
    FInfo := Info;

    InvalidateRect(LocalRect);
  end;
end;

end.
