unit UDescentRamp;

interface

uses FMX.Controls, System.Types, UPropertyList;

type
  TDescentRamp = class(TControl)
  private
    RunwayAltFt, RunwayDistNm, AirplaneAltFt: Extended;

    function GetPos(AltFt, DistNm: Extended): TPointF;
    procedure PaintGrid;
  protected
    procedure Paint; override;
  public
    procedure UpdateData(L: TPropertyList);
    procedure Invalidate;
  end;

implementation

uses System.UITypes, FMX.Graphics, UConfig;

function TDescentRamp.GetPos(AltFt, DistNm: Extended): TPointF;
begin
  Result := TPointF.Create(
    Width - Round(Width * DistNm / Config.DescentRamp_AreaDist),
    Height - Round(Height * AltFt / Config.DescentRamp_AreaAlt)
  );
end;

procedure TDescentRamp.Paint;
var
  StartPos, PlanePos: TPointF;
begin
  inherited;
  Canvas.Stroke.Kind := TBrushKind.Solid;

  PaintGrid;
  if (RunwayDistNm = 0) or (RunwayDistNm > Config.DescentRamp_AreaDist) then Exit;

  StartPos := GetPos(Config.DescentRamp_RefAlt, Config.DescentRamp_RefDist);
  PlanePos := GetPos(AirplaneAltFt - RunwayAltFt, RunwayDistNm);

  Canvas.Stroke.Thickness := 1;

  Canvas.Stroke.Color := TAlphaColors.Green;
  Canvas.DrawLine(StartPos, LocalRect.BottomRight, 1);

  Canvas.Stroke.Color := TAlphaColors.Red;
  Canvas.DrawLine(PlanePos, LocalRect.BottomRight, 1);
end;

procedure TDescentRamp.PaintGrid;
var
  AltFt, DistNm: Integer;
begin
  Canvas.Stroke.Color := TAlphaColors.Gray;
  Canvas.Stroke.Thickness := 0.2;

  AltFt := 0;
  while AltFt<Config.DescentRamp_AreaAlt do
  begin
    Inc(AltFt, 1000);
    Canvas.DrawLine(GetPos(AltFt, Config.DescentRamp_AreaDist), GetPos(AltFt, 0), 1);
  end;

  DistNm := 0;
  while DistNm<Config.DescentRamp_AreaDist do
  begin
    Inc(DistNm, 1);
    Canvas.DrawLine(GetPos(Config.DescentRamp_AreaAlt, DistNm), GetPos(0, DistNm), 1);
  end;
end;

procedure TDescentRamp.UpdateData(L: TPropertyList);
begin
  RunwayAltFt := L.RouteManager.Destination_Field_Elevation_Ft;
  RunwayDistNm := L.RouteManager.Distance_Remaining_Nm;
  AirplaneAltFt := L.Altitude_Ft;

  Invalidate;
end;

procedure TDescentRamp.Invalidate;
begin
  InvalidateRect(LocalRect);
end;

end.
