unit UDescentRamp;

interface

uses Vcl.Controls, System.Types, UPropertyList;

type
  TDescentRamp = class(TGraphicControl)
  private
    RunwayAltFt, RunwayDistNm, AirplaneAltFt: Extended;

    function GetPos(AltFt, DistNm: Extended): TPoint;
  protected
    procedure Paint; override;
  public
    procedure UpdateData(L: TPropertyList);
  end;

implementation

uses Vcl.Graphics;

const
  WIDTH_NM = 15;
  HEIGHT_FT = 6000;

  IDEAL_START_ALT_FT = 4000;
  IDEAL_START_DIST_NM = 12;


function TDescentRamp.GetPos(AltFt, DistNm: Extended): TPoint;
begin
  Result := TPoint.Create(
    Width - Round(Width * DistNm / WIDTH_NM),
    Height - Round(Height * AltFt / HEIGHT_FT)
  );
end;

procedure TDescentRamp.Paint;
var
  StartPos, PlanePos: TPoint;
begin
  inherited;
  if (RunwayDistNm = 0) or (RunwayDistNm > WIDTH_NM) then Exit;

  StartPos := GetPos(IDEAL_START_ALT_FT, IDEAL_START_DIST_NM);
  PlanePos := GetPos(AirplaneAltFt - RunwayAltFt, RunwayDistNm);

  Canvas.Pen.Color := clGreen;
  Canvas.MoveTo(StartPos.X, StartPos.Y);
  Canvas.LineTo(Width, Height);

  Canvas.Pen.Color := clRed;
  Canvas.MoveTo(PlanePos.X, PlanePos.Y);
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
