unit UConfig;

interface

type
  TConfig = class
  private
    Path: string;
  public
    DescentRamp_RefDist,
    DescentRamp_RefAlt: Double;

    DescentRamp_AreaDist,
    DescentRamp_AreaAlt: Double;

    constructor Create;

    procedure Load;
    procedure Save;
  end;

var Config: TConfig;

implementation

uses System.IniFiles, System.SysUtils, System.IOUtils;

constructor TConfig.Create;
begin
  Path := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Config.ini');
end;

procedure TConfig.Load;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(Path);
  try
    DescentRamp_RefDist := Ini.ReadFloat('DescentRamp_Ref', 'Dist', 12);
    DescentRamp_RefAlt := Ini.ReadFloat('DescentRamp_Ref', 'Alt', 4000);

    DescentRamp_AreaDist := Ini.ReadFloat('DescentRamp_Area', 'Dist', 15);
    DescentRamp_AreaAlt := Ini.ReadFloat('DescentRamp_Area', 'Alt', 6000);

  finally
    Ini.Free;
  end;
end;

procedure TConfig.Save;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(Path);
  try
    Ini.WriteFloat('DescentRamp_Ref', 'Dist', DescentRamp_RefDist);
    Ini.WriteFloat('DescentRamp_Ref', 'Alt', DescentRamp_RefAlt);

    Ini.WriteFloat('DescentRamp_Area', 'Dist', DescentRamp_AreaDist);
    Ini.WriteFloat('DescentRamp_Area', 'Alt', DescentRamp_AreaAlt);

  finally
    Ini.Free;
  end;
end;

end.
