unit UPropertyList;

interface

uses System.Rtti, System.Generics.Collections;

type
  ChunkAttribute = class(TCustomAttribute)
  private
    FNodePath: string;
    FIsList: Boolean;
    FListItems: Integer;
    FStartIndex: Integer;
  public
    constructor Create(const NodePath: string); overload;
    constructor Create(const NodePath: string; ListItems: Integer; StartIndex: Integer = 0); overload;

    property NodePath: string read FNodePath;
    property IsList: Boolean read FIsList;
    property ListItems: Integer read FListItems;
    property StartIndex: Integer read FStartIndex;
  end;

  TFloatValue = Extended;

  TPropertyListGroup = class(TObject);
  TPropertyListGroupClass = class of TPropertyListGroup;

  //Path: /autopilot/route-manager
  TPL_RouteManager = class(TPropertyListGroup)
  public
    [Chunk('destination/airport')]
    Destination_Airport: string;
    [Chunk('destination/field-elevation-ft')]
    Destination_Field_Elevation_Ft: TFloatValue;
    [Chunk('destination/name')]
    Destination_Name: string;
    [Chunk('destination/runway')]
    Destination_Runway: string;

    [Chunk('distance-remaining-nm')]
    Distance_Remaining_Nm: TFloatValue;
  end;

  //Path: /consumables/fuel/tank[n]
  TPL_Tank = class(TPropertyListGroup)
  public
    [Chunk('hidden')]
    Hidden: Boolean;
    [Chunk('level-kg')]
    Level_Kg: TFloatValue;
    [Chunk('level-lbs')]
    Level_Lbs: TFloatValue;
    [Chunk('level-norm')]
    Level_Norm: TFloatValue;
    [Chunk('name')]
    Name: string;
  end;

  //Path: /controls/engines/engine[n]
  TPL_EngineControls = class(TPropertyListGroup)
  public
    [Chunk('cutoff')]
    Cutoff: Boolean;
    [Chunk('reverser')]
    Reverser: Boolean;
    [Chunk('throttle')]
    Throttle: TFloatValue;
  end;

  //Path: /controls
  TPL_Controls = class(TPropertyListGroup)
  public
    [Chunk('engines/engine', 4)]
    Engines: TObjectList<TPL_EngineControls>;

    [Chunk('flight/flaps')]
    Flaps: TFloatValue;
    //[Chunk('flight/flaps-serviceable')]
    //Flaps_Serviceable: Boolean;
    [Chunk('flight/ground-spoilers-armed')]
    Ground_Spoilers_Armed: Boolean;

    [Chunk('flight/speedbrake')]
    SpeedBrake: TFloatValue;
    [Chunk('flight/speedbrake-arm')]
    SpeedBrake_Arm: TFloatValue;
    [Chunk('flight/speedbrake-lever')]
    SpeedBrake_Lever: TFloatValue;
    [Chunk('flight/speedbrake-norm')]
    SpeedBrake_Norm: TFloatValue;
    [Chunk('flight/speedbrake-output')]
    SpeedBrake_Output: TFloatValue;

    [Chunk('flight/spoiler-l-sum')]
    Spoiler_L_Sum: TFloatValue;
    [Chunk('flight/spoiler-r-sum')]
    Spoiler_R_Sum: TFloatValue;
    [Chunk('flight/spoilers')]
    Spoilers: TFloatValue;

    [Chunk('gear/autobrakes')]
    AutoBrakes: TFloatValue;
    [Chunk('gear/brake-left')]
    Brake_Left: TFloatValue;
    [Chunk('gear/brake-parking')]
    Brake_Parking: TFloatValue;
    [Chunk('gear/brake-right')]
    Brake_Right: TFloatValue;

    [Chunk('gear/gear-down')]
    Gear_Down: Boolean;
    //[Chunk('gear/steering')]
    //Steering: TFloatValue;
    //[Chunk('gear/tailhook')]
    //TailHook: Boolean;
    //[Chunk('gear/tailwheel-lock')]
    //TailWheel_Lock: Boolean;
    //[Chunk('gear/tiller-cmd-norm')]
    //Tiller_Cmd_Norm: TFloatValue;
    //[Chunk('gear/tiller-enabled')]
    //Tiller_Enabled: Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

  //Path: /engines/engine[n]
  TPL_Engine = class(TPropertyListGroup)
  public
    [Chunk('cranking')]
    Cranking: Boolean;
    [Chunk('cutoff')]
    Cutoff: Boolean;
    [Chunk('ignition')]
    Ignition: Boolean;
    [Chunk('n1')]
    N1: TFloatValue;
    [Chunk('reversed')]
    Reversed: Boolean;
    [Chunk('reverser-pos-norm')]
    Reverser_Pos_Norm: TFloatValue;
    [Chunk('running')]
    Running: Boolean;
    [Chunk('starter')]
    Starter: Boolean;
  end;

  //Path: /gear/gear[n]
  TPL_Gear = class(TPropertyListGroup)
  public
    [Chunk('position-norm')]
    Position_Norm: TFloatValue;
  end;

  //Path: /sim/view[n]
  TPL_View = class(TPropertyListGroup)
  public
    [Chunk('enabled')]
    Enabled: Boolean;
    [Chunk('name')]
    Name: string;
  end;

  TPropertyList = class(TPropertyListGroup)
  public
    //'autopilot/...'?

    [Chunk('autopilot/autobrake/step')]
    Autopilot_Autobrake_Step: TFloatValue;
    [Chunk('autopilot/settings/autobrake')]
    Autopilot_Settings_Autobrake: TFloatValue;
    [Chunk('autopilot/route-manager')]
    RouteManager: TPL_RouteManager;

    [Chunk('consumables/fuel/tank', 5)]
    Tanks: TObjectList<TPL_Tank>;
    [Chunk('consumables/fuel/total-fuel-kg')]
    Total_Fuel_Kg: TFloatValue;
    [Chunk('consumables/fuel/total-fuel-lbs')]
    Total_Fuel_Lbs: TFloatValue;
    [Chunk('consumables/fuel/total-fuel-norm')]
    Total_Fuel_Norm: TFloatValue;

    //'controls/APU/...'?
    //'controls/autoflight/...'?
    //'controls/engines/...'?

    [Chunk('controls')]
    Controls: TPL_Controls;

    //'controls/lighting

    [Chunk('engines/engine', 4)]
    Engines: TObjectList<TPL_Engine>;

    //'environment/...'?

    [Chunk('gear/gear', 1)]
    Gears: TObjectList<TPL_Gear>;
    //[Chunk('gear/serviceable')]
    //Gear_Serviceable: Boolean;

    //'instrumentation/...'?
    //'it-autoflight/...'?

    [Chunk('limits/mass-and-balance/maximum-landing-mass-lbs')]
    Maximum_Landing_Mass_Lbs: TFloatValue;
    [Chunk('limits/mass-and-balance/maximum-takeoff-mass-lbs')]
    Maximum_Takeoff_Mass_Lbs: TFloatValue;


    [Chunk('position/altitude-agl-ft')]
    Altitude_Agl_Ft: TFloatValue; //terrain alt
    [Chunk('position/altitude-ft')]
    Altitude_Ft: TFloatValue; //sea level alt

    [Chunk('sim/airport/closest-airport-id')]
    Closest_Airport_Id: string;
    //[Chunk('sim/crashed')]
    //Crashed: Boolean;

    [Chunk('sim/current-view/name')]
    CurrentView_Name: string;
    [Chunk('sim/current-view/view-number')]
    CurrentView_Number: TFloatValue;
    //[Chunk('sim/description')]
    //Sim_Description: string;
    [Chunk('sim/speed-up')]
    Speed_Up: TFloatValue;

    //[Chunk('sim/view', 10)]
    //Views: TObjectList<TPL_View>;
    //[Chunk('sim/view', 10, 100)]
    //ViewsAlt: TObjectList<TPL_View>;

    [Chunk('surface-positions/flap-pos-norm')]
    Flap_Pos_Norm: TFloatValue;
    [Chunk('surface-positions/speedbrake-pos-norm')]
    SpeedBrake_Pos_Norm: TFloatValue;
    [Chunk('surface-positions/spoilers-pos-norm')]
    Spoilers_Pos_Norm: TFloatValue;

    //[Chunk('switches/no-smoking-sign')]
    //No_Smoking_Sign: Boolean;
    //[Chunk('switches/seatbelt-sign')]
    //Seatbelt_Sign: Boolean;

    //'systems/...'?

    [Chunk('velocities/airspeed-kt')]
    AirSpeed_Kt: TFloatValue;
    [Chunk('velocities/groundspeed-kt')]
    GroundSpeed_Kt: TFloatValue;
    [Chunk('velocities/mach')]
    Mach: TFloatValue;
    [Chunk('velocities/vertical-speed-fps')]
    VerticalSpeed: TFloatValue;

    constructor Create;
    destructor Destroy; override;
  end;

function RttiTypeToGroupClass(RT: TRttiType): TPropertyListGroupClass;
function GetObjectListItemsClass(F: TRttiField): TRttiType;
function GetChunkAttribute(F: TRttiField): ChunkAttribute;

implementation

uses System.SysUtils, System.TypInfo;

function RttiTypeToGroupClass(RT: TRttiType): TPropertyListGroupClass;
begin
  Result := TPropertyListGroupClass(GetTypeData(RT.Handle)^.ClassType);
end;

function GetObjectListItemsClass(F: TRttiField): TRttiType;
const PREFIX = 'TObjectList<';
var
  FT: string;
  _Context: TRttiContext;
begin
  FT := F.FieldType.ToString;
  if not FT.StartsWith(PREFIX) then raise Exception.Create('Invalid prefix');

  Delete(FT, 1, PREFIX.Length);
  Delete(FT, FT.Length, 1);

  Result := _Context.FindType(FT);
end;

function GetChunkAttribute(F: TRttiField): ChunkAttribute;
var
  Attr: TCustomAttribute;
begin
  for Attr in F.GetAttributes do
    if Attr is ChunkAttribute then Exit(ChunkAttribute(Attr));

  raise Exception.Create('ChunkAttribute not found');
end;

constructor ChunkAttribute.Create(const NodePath: string);
begin
  FNodePath := NodePath;
end;

constructor ChunkAttribute.Create(const NodePath: string; ListItems, StartIndex: Integer);
begin
  FNodePath := NodePath;
  FIsList := True;
  FListItems := ListItems;
end;

constructor TPropertyList.Create;
begin
  RouteManager := TPL_RouteManager.Create;
  Tanks := TObjectList<TPL_Tank>.Create;
  Controls := TPL_Controls.Create;
  Engines := TObjectList<TPL_Engine>.Create;
  Gears := TObjectList<TPL_Gear>.Create;
  //Views := TObjectList<TPL_View>.Create;
  //ViewsAlt := TObjectList<TPL_View>.Create;
end;

destructor TPropertyList.Destroy;
begin
  RouteManager.Free;
  Tanks.Free;
  Controls.Free;
  Engines.Free;
  Gears.Free;
  //Views.Free;
  //ViewsAlt.Free;
end;

constructor TPL_Controls.Create;
begin
  Engines := TObjectList<TPL_EngineControls>.Create;
end;

destructor TPL_Controls.Destroy;
begin
  Engines.Free;
end;

end.
