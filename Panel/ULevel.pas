unit ULevel;

interface

uses Vcl.Controls, Vcl.Graphics, System.Classes;

type
  TLevel = class(TGraphicControl)
  private
    FValue: Extended;
    FInfo: string;

    BarColor: TColor;
    Vertical: Boolean;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent; BarColor: TColor; Vertical: Boolean); reintroduce;

    procedure SetValue(Value: Extended; const Info: string = '');
  published
    property ParentFont;
    property ParentColor;
    property Color;
  end;

implementation

uses System.SysUtils, System.Types;

constructor TLevel.Create(AOwner: TComponent; BarColor: TColor;
  Vertical: Boolean);
begin
  inherited Create(AOwner);
  Self.BarColor := BarColor;
  Self.Vertical := Vertical;
end;

procedure TLevel.Paint;
var
  Text: string;
  Size: TSize;
begin
  inherited;

  if FInfo.IsEmpty then
    Text := FormatFloat('0.00', FValue)
  else
    Text := FInfo;

  Size := Canvas.TextExtent(Text);

  Canvas.Pen.Style := psClear;
  Canvas.Brush.Color := BarColor;
  if Vertical then
    Canvas.Rectangle(1, 1, Width, Round(Height*FValue))
  else
    Canvas.Rectangle(1, 1, Round(Width*FValue), Height);

  Canvas.Brush.Style := bsClear;
  Canvas.Font.Color := clWhite; //**
  if Vertical then
    Canvas.TextOut((Width-Size.Width) div 2, 8, Text)
  else
    Canvas.TextOut(8, (Height-Size.Height) div 2, Text);
end;

procedure TLevel.SetValue(Value: Extended; const Info: string);
begin
  if (FValue<>Value) or (FInfo<>Info) then
  begin
    FValue := Value;
    FInfo := Info;

    Invalidate;
  end;
end;

end.
