unit UFrmMain;

interface

uses Vcl.Forms, IdUDPServer, IdGlobal, IdSocketHandle, System.Classes,
  IdBaseComponent, IdComponent, IdUDPBase,
  //
  UPropertyList, UFrameEngine, ULevelCmdXReal, UDescentRamp,
  System.Generics.Collections, Vcl.ExtCtrls, Vcl.Controls, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    Server: TIdUDPServer;
    Label1: TLabel;
    LbAirSpeed: TLabel;
    Label2: TLabel;
    LbGroundSpeed: TLabel;
    LTanks: TListBox;
    Label3: TLabel;
    LbTotalFuel: TLabel;
    Label7: TLabel;
    LbSpeedBrake_Arm: TLabel;
    Label9: TLabel;
    LbSpeedBrake_Lever: TLabel;
    Label8: TLabel;
    LbAutoBrakes: TLabel;
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
    ShBrakeL: TShape;
    ShBrakeR: TShape;
    BoxSpoilersSide: TPanel;
    ShSpoilerL: TShape;
    ShSpoilerR: TShape;
    Label12: TLabel;
    Label6: TLabel;
    BoxDescentRamp: TPanel;
    Label10: TLabel;
    LbDestination: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    LbDestinationElev: TLabel;
    LbDestinationDist: TLabel;
    Label15: TLabel;
    LbAutobrake2: TLabel;
    Label19: TLabel;
    LbAutobrake3: TLabel;
    Label16: TLabel;
    LbClosestAirport: TLabel;
    LbGroundSpoilersArmed: TLabel;
    procedure ServerUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes;
      ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FramesEngines: TList<TFrameEngine>;

    LevelFlaps, LevelSpoilers, LevelSpeedBrake, LevelGear: TLevelCmdXReal;
    DescentRamp: TDescentRamp;

    procedure CreateEngines;
    procedure UpdatePanel(L: TPropertyList);
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses UDataProcess, System.SysUtils, Vcl.Graphics, System.Math;

procedure SetLabelFloat(Lb: TLabel; Value: Extended;
  IntegerOnly: Boolean; OKContidion: Boolean; const Sufix: string = '');
var
  A: string;
begin
  if IntegerOnly then
  begin
    Value := Round(Value);
    A := Value.ToString;
  end else
  begin
    Value := RoundTo(Value, -2);
    A := FormatFloat('0.00', Value);
  end;

  Lb.Caption := A+Sufix;

  if Value=0 then
    Lb.Font.Color := clGray else
  if OKContidion then
    Lb.Font.Color := clLime else
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

  FramesEngines := TList<TFrameEngine>.Create;
  CreateEngines;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FramesEngines.Free;
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
  Tank: TPL_Tank;
  FrameEngine: TFrameEngine;
begin
  LTanks.Items.BeginUpdate;
  try
    LTanks.Items.Clear;
    for Tank in L.Tanks do
    begin
      if Tank.Hidden then Continue;
      LTanks.Items.Add(Format('%s: %g', [Tank.Name, Tank.Level_Norm]));
    end;
  finally
    LTanks.Items.EndUpdate;
  end;

  SetLabelFloat(LbTotalFuel, L.Total_Fuel_Kg, True, L.Total_Fuel_Kg>1000, ' kg');

  //L.Controls.Flaps_Serviceable

  if L.Controls.Ground_Spoilers_Armed then
    LbGroundSpoilersArmed.Font.Color := clLime
  else
    LbGroundSpoilersArmed.Font.Color := clGray;

  SetLabelFloat(LbSpeedBrake_Arm, L.Controls.SpeedBrake_Arm, True, True);
  SetLabelFloat(LbSpeedBrake_Lever, L.Controls.SpeedBrake_Lever, True, True);
  //SetLabelFloat(LbSpeedBrake_Norm, L.Controls.SpeedBrake_Norm);
  //SetLabelFloat(LbSpeedBrake_Output, L.Controls.SpeedBrake_Output);

  SetLabelFloat(LbAutoBrakes, L.Controls.AutoBrakes, True, True);

  if L.Controls.Brake_Parking=1 then
    LbParking.Font.Color := clLime
  else
    LbParking.Font.Color := clGray;

  //L.Controls.Gear_Down - below

  //SetLabelFloat(LbSteering, L.Controls.Steering);
  //LbTailHook.Caption := L.Controls.TailHook.ToString;
  //LbTailWheelLock.Caption := L.Controls.TailWheel_Lock.ToString;
  //SetLabelFloat(LbTillerCmdNorm, L.Controls.Tiller_Cmd_Norm);
  //LbTillerEnabled.Caption := L.Controls.Tiller_Enabled.ToString;

  //L.Gear_Serviceable

  SetLabelFloat(LbAltitude, L.Altitude_Ft, True, True, ' ft');
  SetLabelFloat(LbAltitudeAGL, L.Altitude_Agl_Ft, True, True, ' ft');

  LbClosestAirport.Caption := L.Closest_Airport_Id;

  {if L.Crashed then
    LbCrashed.Font.Color := clLime
  else
    LbCrashed.Font.Color := clGray;}

  LbView.Caption := L.CurrentView_Number.ToString+'-'+L.CurrentView_Name;

  //LbSimDesc.Caption := L.Sim_Description;
  SetLabelFloat(LbSpeedUp, L.Speed_Up, True, L.Speed_Up=1, 'x');

  //L.Views
  //L.ViewsAlt

  {if L.No_Smoking_Sign then
    LbNoSmoking.Font.Color := clLime
  else
    LbNoSmoking.Font.Color := clGray;

  if L.Seatbelt_Sign then
    LbSeatbelt.Font.Color := clLime
  else
    LbSeatbelt.Font.Color := clGray;}

  SetLabelFloat(LbAirSpeed, L.AirSpeed_Kt, False, True);
  SetLabelFloat(LbGroundSpeed, L.GroundSpeed_Kt, False, True);
  SetLabelFloat(LbMach, L.Mach, False, True);
  SetLabelFloat(LbVertSpeed, L.VerticalSpeed * 60, False, True);

  LevelFlaps.UpdateValue(L.Controls.Flaps, L.Flap_Pos_Norm);
  LevelSpoilers.UpdateValue(L.Controls.Spoilers, L.Spoilers_Pos_Norm);
  LevelSpeedBrake.UpdateValue(L.Controls.SpeedBrake, L.SpeedBrake_Pos_Norm);
  LevelGear.UpdateValue(IfThen(L.Controls.Gear_Down, 1, 0), L.Gears.First.Position_Norm);

  ShSpoilerL.Height := Round(BoxSpoilersSide.Height * L.Controls.Spoiler_L_Sum);
  ShSpoilerR.Height := Round(BoxSpoilersSide.Height * L.Controls.Spoiler_R_Sum);

  ShBrakeL.Height := Round(BoxBrakes.Height * L.Controls.Brake_Left);
  ShBrakeR.Height := Round(BoxBrakes.Height * L.Controls.Brake_Right);

  LbDestination.Caption := L.RouteManager.Destination_Airport+'-'+
    L.RouteManager.Destination_Name + ' ['+L.RouteManager.Destination_Runway+']';

  SetLabelFloat(LbDestinationElev, L.RouteManager.Destination_Field_Elevation_Ft, True, True, ' ft');
  SetLabelFloat(LbDestinationDist, L.RouteManager.Distance_Remaining_Nm, False, True, ' nm');

  DescentRamp.UpdateData(L);

  LbAutobrake2.Caption := L.Autopilot_Autobrake_Step.ToString;
  LbAutobrake3.Caption := L.Autopilot_Settings_Autobrake.ToString;

  for FrameEngine in FramesEngines do
    FrameEngine.UpdateByEngineIndex(L);
end;

end.
