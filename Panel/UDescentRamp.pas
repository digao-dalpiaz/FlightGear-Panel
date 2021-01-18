unit UDescentRamp;

interface

uses Vcl.Controls, UPropertyList;

type
  TDescentRamp = class(TGraphicControl)
  private
    RunwayAltFt, RunwayDistNm, AirplaneAltFt: Extended;
  protected
    procedure Paint; override;
  public
    procedure UpdateData(L: TPropertyList);
  end;

implementation

uses Vcl.Graphics;

procedure TDescentRamp.Paint;
const
  WIDTH_NM = 15;
  IDEAL_START_ALT_FT = 4000;
  IDEAL_START_DIST_NM = 12;
var
  BoxHeightFt, AltFt: Extended;
  PosAirplaneX, PosAirplaneY: Integer;
begin
  inherited;
  if (RunwayDistNm = 0) or (RunwayDistNm > WIDTH_NM) then Exit;

  BoxHeightFt := 2 * (IDEAL_START_ALT_FT * WIDTH_NM / IDEAL_START_DIST_NM);
  AltFt := AirplaneAltFt - RunwayAltFt;

  PosAirplaneX := Round(Width * RunwayDistNm / WIDTH_NM);
  PosAirplaneX := Width - PosAirplaneX;

  PosAirplaneY := Round(Height * AltFt / BoxHeightFt);
  PosAirplaneY := Height - PosAirplaneY;

  Canvas.Pen.Color := clGreen;
  Canvas.MoveTo(0, Height div 2);
  Canvas.LineTo(Width, Height);

  Canvas.Pen.Color := clBlue;
  Canvas.MoveTo(PosAirplaneX, PosAirplaneY);
  Canvas.LineTo(Width, Height);
end;

procedure TDescentRamp.UpdateData(L: TPropertyList);
begin
  RunwayAltFt := L.RouteManager.Destination_Field_Elevation_Ft;
  RunwayDistNm := L.RouteManager.Distance_Remaining_Nm;
  AirplaneAltFt := L.Altitude_Ft;

  Invalidate;
end;

end.
