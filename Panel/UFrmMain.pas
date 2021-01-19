unit UFrmMain;

interface

uses Vcl.Forms, IdUDPServer, IdGlobal, IdSocketHandle, IdBaseComponent,
  IdComponent, IdUDPBase, Vcl.Controls, Vcl.ExtCtrls, System.Classes,
  Vcl.StdCtrls,
  //
  UPropertyList, UFrameEngine, ULevel, ULevelCmdXReal, UDescentRamp,
  System.Generics.Collections;

type
  TFrmMain = class(TForm)
    Server: TIdUDPServer;
    Label1: TLabel;
    LbAirSpeed: TLabel;
    Label2: TLabel;
    LbGroundSpeed: TLabel;
    Label3: TLabel;
    LbTotalFuel: TLabel;
    Label7: TLabel;
    LbSpeedBrake_Arm: TLabel;
    Label9: TLabel;
    LbSpeedBrake_Lever: TLabel;
    Label8: TLabel;
    LbAutoBrake: TLabel;
    LbParking: TLabel;
    Label17: TLabel;
    LbAltitude: TLabel;
    Label22: TLabel;
    LbAltitudeAGL: TLabel;
    Label24: TLabel;
    LbView: TLabel;
    Label28: TLabel;
    LbSpeedUp: TLabel;
    Label32: TLabel;
    LbMach: TLabel;
    Label33: TLabel;
    LbVertSpeed: TLabel;
    BoxFlaps: TPanel;
    BoxSpoilers: TPanel;
    Label4: TLabel;
    Label14: TLabel;
    BoxSpeedBrake: TPanel;
    Label31: TLabel;
    Label5: TLabel;
    BoxGear: TPanel;
    BoxEngines: TPanel;
    BoxBrakes: TPanel;
    Label18: TLabel;
    BoxSpoilersSide: TPanel;
    Label12: TLabel;
    Label6: TLabel;
    BoxDescentRamp: TPanel;
    Label10: TLabel;
    LbDestination: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    LbDestinationElev: TLabel;
    LbDestinationDist: TLabel;
    LbAutobrake2: TLabel;
    LbAutobrake3: TLabel;
    Label16: TLabel;
    LbClosestAirport: TLabel;
    LbGroundSpoilersArmed: TLabel;
    BoxTanks: TPanel;
    Label15: TLabel;
    LbSpeedBrake_Norm: TLabel;
    Label20: TLabel;
    LbSpeedBrake_Output: TLabel;
    Label23: TLabel;
    Label19: TLabel;
    LbMaxLanding: TLabel;
    Label21: TLabel;
    LbMaxTakeoff: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    LbAPU_RPM: TLabel;
    LbAPU_Master: TLabel;
    LbAPU_Start: TLabel;
    Label27: TLabel;
    LbGrossWeight: TLabel;
    procedure ServerUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes;
      ABinding: TIdSocketHandle);
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

{$R *.dfm}

uses UDataProcess, System.SysUtils, Vcl.Graphics, System.Math;

procedure SetLabelFloat(Lb: TLabel; Value: Extended;
  DecimalPoints: Byte; OKContidion: Boolean; const Sufix: string = '');
var
  A: string;
begin
  Value := RoundTo(Value, -DecimalPoints);
  A := FormatFloat('0.'+StringOfChar('0', DecimalPoints), Value);

  Lb.Caption := A+Sufix;

  if Value=0 then
    Lb.Font.Color := clGray
  else
  if OKContidion then
    Lb.Font.Color := clLime
  else
    Lb.Font.Color := clRed;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  DescentRamp := TDescentRamp.Create(Self);
  DescentRamp.Parent := BoxDescentRamp;
  DescentRamp.Align := alClient;

  CreateLevel(LevelFlaps, BoxFlaps);
  CreateLevel(LevelSpoilers, BoxSpoilers);
  CreateLevel(LevelSpeedBrake, BoxSpeedBrake);
  CreateLevel(LevelGear, BoxGear);

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
  LevelSpoilerL := TLevel.Create(Self, clRed, True);
  LevelSpoilerL.Parent := BoxSpoilersSide;
  LevelSpoilerL.Align := alLeft;
  LevelSpoilerL.Width := BoxSpoilersSide.Width div 2;

  LevelSpoilerR := TLevel.Create(Self, clRed, True);
  LevelSpoilerR.Parent := BoxSpoilersSide;
  LevelSpoilerR.Align := alClient;

  LevelBrakeL := TLevel.Create(Self, clRed, True);
  LevelBrakeL.Parent := BoxBrakes;
  LevelBrakeL.Align := alLeft;
  LevelBrakeL.Width := BoxBrakes.Width div 2;

  LevelBrakeR := TLevel.Create(Self, clRed, True);
  LevelBrakeR.Parent := BoxBrakes;
  LevelBrakeR.Align := alClient;
end;

procedure TFrmMain.CreateEngines;
var
  I: Integer;
  F: TFrameEngine;
  X: Integer;
begin
  X := 0;

  for I := 1 to 4 do
  begin
    F := TFrameEngine.Create(Self, I);
    F.Name := 'FrameEngine_'+I.ToString;
    F.Parent := BoxEngines;
    F.Top := 0;
    F.Left := X; X := X + F.Width;
    FramesEngines.Add(F);
  end;
end;

procedure TFrmMain.CreateTanks;
var
  I, Y: Integer;
  Level: TLevel;
begin
  Y := 0;

  for I := 1 to 5 do
  begin
    Level := TLevel.Create(Self, $00B94462, False);
    Level.Parent := BoxTanks;
    Level.Height := 18;
    Level.Top := Y;
    Level.Align := alTop;

    LevelsTanks.Add(Level);

    Y := Level.Top+Level.Height;
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
  SetLabelFloat(LbAltitudeAGL, L.Altitude_Agl_Ft, 0, L.Altitude_Agl_Ft>=2000, ' ft');

  SetLabelFloat(LbSpeedUp, L.Speed_Up, 0, L.Speed_Up=1, 'x');
  LbView.Caption := L.CurrentView_Number.ToString+'-'+L.CurrentView_Name;

  SetLabelFloat(LbDestinationElev, L.RouteManager.Destination_Field_Elevation_Ft, 0, True, ' ft');
  SetLabelFloat(LbDestinationDist, L.RouteManager.Distance_Remaining_Nm, 2, True, ' nm');

  if not L.RouteManager.Destination_Airport.IsEmpty then
    LbDestination.Caption := L.RouteManager.Destination_Airport+'-'+
      L.RouteManager.Destination_Name + ' ['+L.RouteManager.Destination_Runway+']'
  else
    LbDestination.Caption := string.Empty;

  DescentRamp.UpdateData(L);

  LevelFlaps.UpdateValue(L.Controls.Flaps, L.Flap_Pos_Norm);
  LevelSpoilers.UpdateValue(L.Controls.Spoilers, L.Spoilers_Pos_Norm);
  LevelSpeedBrake.UpdateValue(L.Controls.SpeedBrake, L.SpeedBrake_Pos_Norm);
  LevelGear.UpdateValue(IfThen(L.Controls.Gear_Down, 1, 0), L.Gears.First.Position_Norm);

  for I := 0 to LevelsTanks.Count-1 do
  begin
    Level := LevelsTanks[I];
    Tank := L.Tanks[I];

    Level.Visible := not Tank.Hidden;
    Level.SetValue(Tank.Level_Norm, Tank.Name+': '+FormatFloat('#,##0', Tank.Level_Lbs));
  end;

  SetLabelFloat(LbTotalFuel, L.Total_Fuel_Lbs, 0, True, ' lbs');
  SetLabelFloat(LbGrossWeight, L.Gross_Weight_Lbs, 0, True, ' lbs');
  SetLabelFloat(LbMaxTakeoff, L.Maximum_Takeoff_Mass_Lbs, 0, True, ' lbs');
  SetLabelFloat(LbMaxLanding, L.Maximum_Landing_Mass_Lbs, 0, True, ' lbs');

  LevelSpoilerL.SetValue(L.Controls.Spoiler_L_Sum);
  LevelSpoilerR.SetValue(L.Controls.Spoiler_R_Sum);

  LevelBrakeL.SetValue(L.Controls.Brake_Left);
  LevelBrakeR.SetValue(L.Controls.Brake_Right);

  if L.Controls.Brake_Parking=1 then
    LbParking.Font.Color := clLime
  else
    LbParking.Font.Color := clGray;

  SetLabelFloat(LbAutoBrake, L.Controls.AutoBrakes, 0, True);
  SetLabelFloat(LbAutobrake2, L.Autopilot_Autobrake_Step, 0, True);
  SetLabelFloat(LbAutobrake3, L.Autopilot_Settings_Autobrake, 0, True);

  SetLabelFloat(LbSpeedBrake_Arm, L.Controls.SpeedBrake_Arm, 0, True);
  SetLabelFloat(LbSpeedBrake_Lever, L.Controls.SpeedBrake_Lever, 0, True);
  SetLabelFloat(LbSpeedBrake_Norm, L.Controls.SpeedBrake_Norm, 2, True);
  SetLabelFloat(LbSpeedBrake_Output, L.Controls.SpeedBrake_Output, 2, True);

  if L.Controls.Ground_Spoilers_Armed then
    LbGroundSpoilersArmed.Font.Color := clLime
  else
    LbGroundSpoilersArmed.Font.Color := clGray;

  LbClosestAirport.Caption := L.Closest_Airport_Id;

  for FrameEngine in FramesEngines do
    FrameEngine.UpdateByEngineIndex(L);

  SetLabelFloat(LbAPU_Master, L.Controls.APU_Master, 0, True);
  SetLabelFloat(LbAPU_Start, L.Controls.APU_Off_Start_Run, 0, True);
  SetLabelFloat(LbAPU_RPM, L.APU_RPM, 2, True);
end;

end.
