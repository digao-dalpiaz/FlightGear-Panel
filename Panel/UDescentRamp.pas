unit UDescentRamp;

interface

uses FMX.Controls, System.Types, UPropertyList;

type
  TDescentRamp = class(TControl)
  private
    RunwayAltFt, RunwayDistNm, AirplaneAltFt: Extended;

    function GetPos(AltFt, DistNm: Extended): TPointF;
  protected
    procedure Paint; override;
  public
    procedure UpdateData(L: TPropertyList);
  end;

implementation

uses System.UITypes, FMX.Graphics;

const
  WIDTH_NM = 15;
  HEIGHT_FT = 6000;

  IDEAL_START_ALT_FT = 4000;
  IDEAL_START_DIST_NM = 12;


function TDescentRamp.GetPos(AltFt, DistNm: Extended): TPointF;
begin
  Result := TPointF.Create(
    Width - Round(Width * DistNm / WIDTH_NM),
    Height - Round(Height * AltFt / HEIGHT_FT)
  );
end;

procedure TDescentRamp.Paint;
var
  StartPos, PlanePos: TPointF;
begin
  inherited;
  if (RunwayDistNm = 0) or (RunwayDistNm > WIDTH_NM) then Exit;

  StartPos := GetPos(IDEAL_START_ALT_FT, IDEAL_START_DIST_NM);
  PlanePos := GetPos(AirplaneAltFt - RunwayAltFt, RunwayDistNm);

  Canvas.Stroke.Kind := TBrushKind.Solid;

  Canvas.Stroke.Color := TAlphaColors.Green;
  Canvas.DrawLine(StartPos, LocalRect.BottomRight, 1);

  Canvas.Stroke.Color := TAlphaColors.Red;
  Canvas.DrawLine(PlanePos, LocalRect.BottomRight, 1);
end;

procedure TDescentRamp.UpdateData(L: TPropertyList);
begin
  RunwayAltFt := L.RouteManager.Destination_Field_Elevation_Ft;
  RunwayDistNm := L.RouteManager.Distance_Remaining_Nm;
  AirplaneAltFt := L.Altitude_Ft;

  InvalidateRect(LocalRect);
end;

end.
