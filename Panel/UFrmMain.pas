unit UFrmMain;

interface

uses FMX.Forms, IdUDPServer, IdGlobal, IdSocketHandle, System.Classes,
  IdBaseComponent, IdComponent, IdUDPBase,
  //
  UPropertyList, ULevel, ULevelCmdXReal, UDescentRamp, UFrameEngine,
  System.Generics.Collections, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmMain = class(TForm)
    Server: TIdUDPServer;
    LbAirSpeed: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LbGroundSpeed: TLabel;
    Label4: TLabel;
    LbMach: TLabel;
    Label6: TLabel;
    LbVertSpeed: TLabel;
    Label8: TLabel;
    LbAltitude: TLabel;
    Label10: TLabel;
    LbHAGL: TLabel;
    Label3: TLabel;
    LbSpeed: TLabel;
    Label5: TLabel;
    LbView: TLabel;
    Label7: TLabel;
    LbDestElev: TLabel;
    Label11: TLabel;
    LbDestDist: TLabel;
    Label9: TLabel;
    LbDestination: TLabel;
    LbTotalFuel: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    LbGrossWeight: TLabel;
    Label16: TLabel;
    LbMaxTakeoff: TLabel;
    Label18: TLabel;
    LbMaxLanding: TLabel;
    LbParking: TLabel;
    LbAutoBrake1: TLabel;
    Label15: TLabel;
    LbAutoBrake2: TLabel;
    LbAutoBrake3: TLabel;
    LbSpeedBrake_Arm: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    LbSpeedBrake_Lever: TLabel;
    Label21: TLabel;
    LbSpeedBrake_Norm: TLabel;
    Label23: TLabel;
    LbSpeedBrake_Output: TLabel;
    Label25: TLabel;
    LbGroundSpoilersArmed: TLabel;
    Label12: TLabel;
    LbClosestAirport: TLabel;
    Label20: TLabel;
    LbAPU_Master: TLabel;
    LbAPU_Start: TLabel;
    Label22: TLabel;
    LbAPU_RPM: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    BoxDescentRamp: TRectangle;
    BoxFlaps: TRectangle;
    BoxSpoilers: TRectangle;
    BoxSpeedBrake: TRectangle;
    BoxGear: TRectangle;
    BoxTanks: TRectangle;
    BoxSpoilersSide: TRectangle;
    BoxBrakes: TRectangle;
    BoxEngines: TRectangle;
    procedure ServerUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FramesEngines: TList<TFrameEngine>;
    LevelsTanks: TList<TLevel>;

    LevelFlaps, LevelSpoilers, LevelSpeedBrake, LevelGear: TLevelCmdXReal;
    LevelSpoilerL, LevelSpoilerR, LevelBrakeL, LevelBrakeR: TLevel;
    DescentRamp: TDescentRamp;

    procedure CreateEngines;
    procedure UpdatePanel(L: TPropertyList);
    procedure CreateVerticalLevels;
    procedure CreateTanks;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

uses UDataProcess, System.SysUtils, System.Math, System.UITypes;

procedure SetLabelFloat(Lb: TLabel; Value: Extended;
  DecimalPoints: Byte; OKContidion: Boolean; const Sufix: string = '');
var
  A: string;
  Color: TAlphaColor;
begin
  Value := RoundTo(Value, -DecimalPoints);
  A := FormatFloat('0.'+StringOfChar('0', DecimalPoints), Value);

  Lb.Text := A+Sufix;

  if Value=0 then
    Color := TAlphaColors.Gray
  else
  if OKContidion then
    Color := TAlphaColors.Lime
  else
    Color := TAlphaColors.Red;

  Lb.TextSettings.FontColor := Color;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  Fill.Color := TAlphaColors.Black;

  DescentRamp := TDescentRamp.Create(Self);
  DescentRamp.Parent := BoxDescentRamp;
  DescentRamp.Align := TAlignLayout.Client;

  LevelFlaps := TLevelCmdXReal.CreateByBox(BoxFlaps);
  LevelSpoilers := TLevelCmdXReal.CreateByBox(BoxSpoilers);
  LevelSpeedBrake := TLevelCmdXReal.CreateByBox(BoxSpeedBrake);
  LevelGear := TLevelCmdXReal.CreateByBox(BoxGear);

  CreateVerticalLevels;

  FramesEngines := TList<TFrameEngine>.Create;
  CreateEngines;

  LevelsTanks := TList<TLevel>.Create;
  CreateTanks;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FramesEngines.Free;
  LevelsTanks.Free;
end;

procedure TFrmMain.CreateVerticalLevels;
begin
  LevelSpoilerL := TLevel.Create(Self, TAlphaColors.Red, True);
  LevelSpoilerL.Parent := BoxSpoilersSide;
  LevelSpoilerL.Align := TAlignLayout.Left;
  LevelSpoilerL.Width := BoxSpoilersSide.Width / 2;

  LevelSpoilerR := TLevel.Create(Self, TAlphaColors.Red, True);
  LevelSpoilerR.Parent := BoxSpoilersSide;
  LevelSpoilerR.Align := TAlignLayout.Client;

  LevelBrakeL := TLevel.Create(Self, TAlphaColors.Red, True);
  LevelBrakeL.Parent := BoxBrakes;
  LevelBrakeL.Align := TAlignLayout.Left;
  LevelBrakeL.Width := BoxBrakes.Width / 2;

  LevelBrakeR := TLevel.Create(Self, TAlphaColors.Red, True);
  LevelBrakeR.Parent := BoxBrakes;
  LevelBrakeR.Align := TAlignLayout.Client;
end;

procedure TFrmMain.CreateEngines;
var
  I: Integer;
  F: TFrameEngine;
  X: Single;
begin
  X := 0;

  for I := 1 to 4 do
  begin
    F := TFrameEngine.Create(Self, I);
    F.Name := 'FrameEngine_'+I.ToString;
    F.Parent := BoxEngines;
    F.Position.Y := 0;
    F.Position.X := X;

    FramesEngines.Add(F);

    X := X + F.Width - 1;
  end;
end;

procedure TFrmMain.CreateTanks;
var
  I: Integer;
  Level: TLevel;
  Y: Single;
begin
  Y := 0;

  for I := 1 to 5 do
  begin
    Level := TLevel.Create(Self, TAlphaColors.Saddlebrown);
    Level.Parent := BoxTanks;
    Level.Height := 18;
    Level.Position.Y := Y;
    Level.Align := TAlignLayout.Top;

    LevelsTanks.Add(Level);

    Y := Level.Position.Y+Level.Height;
  end;
end;

procedure TFrmMain.ServerUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  L: TPropertyList;
  P: TDataProcess;
begin
  if Application.Terminated then Exit;

  L := TPropertyList.Create;
  try
    P := TDataProcess.Create;
    try
      P.ReceiveData(BytesToString(AData), L);
    finally
      P.Free;
    end;

    UpdatePanel(L);
  finally
    L.Free;
  end;
end;

procedure TFrmMain.UpdatePanel(L: TPropertyList);
var
  I: Integer;
  FrameEngine: TFrameEngine;
  Level: TLevel;
  Tank: TPL_Tank;
begin
  SetLabelFloat(LbAirSpeed, L.AirSpeed_Kt, 1, True, ' kts');
  SetLabelFloat(LbGroundSpeed, L.GroundSpeed_Kt, 1, True, ' kts');
  SetLabelFloat(LbMach, L.Mach, 2, True);
  SetLabelFloat(LbVertSpeed, L.VerticalSpeed * 60, 0, True, ' ft');

  SetLabelFloat(LbAltitude, L.Altitude_Ft, 0, True, ' ft');
  SetLabelFloat(LbHAGL, L.Altitude_Agl_Ft, 0, L.Altitude_Agl_Ft>=2000, ' ft');

  SetLabelFloat(LbSpeed, L.Speed_Up, 0, L.Speed_Up=1, 'x');
  LbView.Text := L.CurrentView_Number.ToString+'-'+L.CurrentView_Name;

  SetLabelFloat(LbDestElev, L.RouteManager.Destination_Field_Elevation_Ft, 0, True, ' ft');
  SetLabelFloat(LbDestDist, L.RouteManager.Distance_Remaining_Nm, 2, True, ' nm');

  if not L.RouteManager.Destination_Airport.IsEmpty then
    LbDestination.Text := L.RouteManager.Destination_Airport+'-'+
      L.RouteManager.Destination_Name + ' ['+L.RouteManager.Destination_Runway+']'
  else
    LbDestination.Text := string.Empty;

  DescentRamp.UpdateData(L);

  LevelFlaps.SetValues(L.Controls.Flaps, L.Flap_Pos_Norm);
  LevelSpoilers.SetValues(L.Controls.Spoilers, L.Spoilers_Pos_Norm);
  LevelSpeedBrake.SetValues(L.Controls.SpeedBrake, L.SpeedBrake_Pos_Norm);
  LevelGear.SetValues(IfThen(L.Controls.Gear_Down, 1, 0), L.Gears.First.Position_Norm);

  for I := 0 to LevelsTanks.Count-1 do
  begin
    Level := LevelsTanks[I];
    Tank := L.Tanks[I];

    Level.Visible := not Tank.Hidden;
    Level.SetValue(Tank.Level_Norm, Tank.Name+': '+FormatFloat('#,##0', Tank.Level_Lbs));
  end;

  SetLabelFloat(LbTotalFuel, L.Total_Fuel_Lbs, 0, True, ' lbs');
  SetLabelFloat(LbGrossWeight, L.Gross_Weight_Lbs, 0, True, ' lbs');
  SetLabelFloat(LbMaxTakeoff, Max(L.Maximum_Takeoff_Mass_Lbs, L.Max_Takeoff_Weight), 0, True, ' lbs');
  SetLabelFloat(LbMaxLanding, Max(L.Maximum_Landing_Mass_Lbs, L.Max_Landing_Weight), 0, True, ' lbs');

  LevelSpoilerL.SetValue(L.Controls.Spoiler_L_Sum);
  LevelSpoilerR.SetValue(L.Controls.Spoiler_R_Sum);

  LevelBrakeL.SetValue(L.Controls.Brake_Left);
  LevelBrakeR.SetValue(L.Controls.Brake_Right);

  if L.Controls.Brake_Parking=1 then
    LbParking.TextSettings.FontColor := TAlphaColors.Red
  else
    LbParking.TextSettings.FontColor := TAlphaColors.Gray;

  SetLabelFloat(LbAutoBrake1, L.Controls.AutoBrakes, 0, True);
  SetLabelFloat(LbAutobrake2, L.Autopilot_Autobrake_Step, 0, True);
  SetLabelFloat(LbAutobrake3, L.Autopilot_Settings_Autobrake, 0, True);

  SetLabelFloat(LbSpeedBrake_Arm, L.Controls.SpeedBrake_Arm, 0, True);
  SetLabelFloat(LbSpeedBrake_Lever, L.Controls.SpeedBrake_Lever, 0, True);
  SetLabelFloat(LbSpeedBrake_Norm, L.Controls.SpeedBrake_Norm, 2, True);
  SetLabelFloat(LbSpeedBrake_Output, L.Controls.SpeedBrake_Output, 2, True);

  if L.Controls.Ground_Spoilers_Armed then
    LbGroundSpoilersArmed.TextSettings.FontColor := TAlphaColors.Lime
  else
    LbGroundSpoilersArmed.TextSettings.FontColor := TAlphaColors.Gray;

  LbClosestAirport.Text := L.Closest_Airport_Id;

  for FrameEngine in FramesEngines do
    FrameEngine.UpdateByEngineIndex(L);

  SetLabelFloat(LbAPU_Master, L.Controls.APU_Master, 0, True);
  SetLabelFloat(LbAPU_Start, L.Controls.APU_Off_Start_Run, 0, True);
  SetLabelFloat(LbAPU_RPM, L.APU_RPM, 2, True);
end;

end.
