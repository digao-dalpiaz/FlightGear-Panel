unit UFrmMain;

interface

uses Vcl.Forms, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls,
  //
  UPropertyList;

type
  TFrmMain = class(TForm)
    BtnExecute: TButton;
    Label1: TLabel;
    EdDir: TEdit;
    BtnSelDir: TSpeedButton;
    Bevel1: TBevel;
    Label2: TLabel;
    LbPropCount: TLabel;
    procedure BtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSelDirClick(Sender: TObject);
  private
    PropCount: Integer;

    procedure GetFlightGearInstalltionDir;
    procedure GenerateFile(const aFile: string);
    procedure GenerateGroup(C: TPropertyListGroupClass; const GroupPath: string; S: TStringList);
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses System.RTTI,
  System.SysUtils, Vcl.Dialogs,
  System.UITypes, System.IOUtils, Vcl.FileCtrl,
  System.Win.Registry, Winapi.Windows;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  GetFlightGearInstalltionDir;
end;

procedure TFrmMain.GetFlightGearInstalltionDir;
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    if TOSVersion.Architecture = arIntelX64 then R.Access := KEY_WOW64_64KEY;
    R.RootKey := HKEY_LOCAL_MACHINE;
    if R.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FlightGear_is1') then
      EdDir.Text := R.ReadString('InstallLocation');
  finally
    R.Free;
  end;
end;

procedure TFrmMain.BtnSelDirClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := EdDir.Text;
  if SelectDirectory('FlightGear installation directory:', string.Empty, Dir) then
    EdDir.Text := Dir;
end;

procedure TFrmMain.BtnExecuteClick(Sender: TObject);
var
  DestDir: string;
begin
  if EdDir.Text = string.Empty then
  begin
    MessageDlg('Please, specify the installation directory.', mtError, [mbOK], 0);
    EdDir.SetFocus;
    Exit;
  end;

  if not TDirectory.Exists(EdDir.Text) then
  begin
    MessageDlg('Invalid installation directory.', mtError, [mbOK], 0);
    EdDir.SetFocus;
    Exit;
  end;

  DestDir := TPath.Combine(EdDir.Text, 'data\Protocol');
  if not TDirectory.Exists(DestDir) then
  begin
    MessageDlg('The specified installation directory does not contains required structure.', mtError, [mbOK], 0);
    EdDir.SetFocus;
    Exit;
  end;

  //

  PropCount := 0;
  GenerateFile(TPath.Combine(DestDir, 'digao_panel.xml'));
  LbPropCount.Caption := PropCount.ToString;

  MessageDlg('FlightGear PropertyList XML successfully generated!', mtInformation, [mbOK], 0);
end;

procedure TFrmMain.GenerateFile(const aFile: string);
var
  S: TStringList;
begin
  S := TStringList.Create;
  try
    S.Add('<?xml version="1.0"?>');
    S.Add('<PropertyList>');
    S.Add('<generic>');
    S.Add('<output>');
    S.Add('  <line_separator>newline</line_separator>');
    S.Add('  <var_separator>tab</var_separator>');

    GenerateGroup(TPropertyList, string.Empty, S);

    S.Add('</output>');
    S.Add('</generic>');
    S.Add('</PropertyList>');

    S.SaveToFile(aFile);
  finally
    S.Free;
  end;
end;

procedure TFrmMain.GenerateGroup(C: TPropertyListGroupClass; const GroupPath: string; S: TStringList);
var
 _Context: TRttiContext;
 F: TRttiField; FT: TRttiType;
 aPath, aType, aFormat: string;
 Attr: ChunkAttribute;
 I, Count: Integer;
 aNumber: string;
begin
  for F in _Context.GetType(C).GetFields do
  begin
    try
      Attr := GetChunkAttribute(F);
      aPath := GroupPath+'/'+Attr.NodePath;

      if F.FieldType.TypeKind=tkClass then
      begin
        if Attr.IsList then
        begin
          Count := Attr.ListItems;
          FT := GetObjectListItemsClass(F);
        end else
        begin
          Count := 1;
          FT := F.FieldType;
        end;

        for I := Attr.StartIndex to Attr.StartIndex+Count-1 do
        begin
          if I>0 then aNumber := Format('[%d]', [I]) else aNumber := string.Empty;
          GenerateGroup(RttiTypeToGroupClass(FT), aPath+aNumber, S);
        end;
      end else
      begin
        case F.FieldType.TypeKind of
          tkUString, tkEnumeration:
            begin
              aType := 'string';
              aFormat := '%s';
            end;
          tkFloat:
            begin
              aType := 'float';
              aFormat := '%f';
            end;

          else raise Exception.CreateFmt('Invalid FieldType "%s"', [F.FieldType.ToString]);
        end;

        S.Add('  <chunk>');
        S.Add('    <name>'+aPath+'</name>');
        S.Add('    <node>'+aPath+'</node>');
        S.Add('    <type>'+aType+'</type>');
        S.Add('    <format>'+aFormat+'</format>');
        S.Add('  </chunk>');
        Inc(PropCount);
      end;
    except
      on E: Exception do
        raise Exception.CreateFmt('Error on field "%s": %s', [F.Name, E.Message]);
    end;
  end;
end;

end.
