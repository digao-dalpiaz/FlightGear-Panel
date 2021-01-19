unit ULevel;

interface

uses Vcl.Controls, Vcl.Graphics, System.Classes;

type
  TLevel = class(TGraphicControl)
  private
    FDescription: string;
    FValue: Extended;

    BarColor: TColor;
    Vertical: Boolean;

    procedure SetValue(const Value: Extended);
    procedure SetDescription(const Value: string);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent; BarColor: TColor; Vertical: Boolean); reintroduce;

    property Description: string read FDescription write SetDescription;
    property Value: Extended read FValue write SetValue;
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

  Text := FormatFloat('0.00', FValue);
  if not FDescription.IsEmpty then Text := FDescription+': '+Text;

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

procedure TLevel.SetDescription(const Value: string);
begin
  if FDescription<>Value then
  begin
    FDescription := Value;
    Invalidate;
  end;
end;

procedure TLevel.SetValue(const Value: Extended);
begin
  if FValue<>Value then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

end.
