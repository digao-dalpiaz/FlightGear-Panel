unit UFrmConfig;

interface

uses FMX.Forms, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.StdCtrls,
  System.Classes, FMX.Types, FMX.Controls, FMX.Controls.Presentation;

type
  TFrmConfig = class(TForm)
    BtnOK: TButton;
    BtnCancel: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdDR_RefDist: TNumberBox;
    EdDR_RefAlt: TNumberBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EdDR_AreaDist: TNumberBox;
    Label4: TLabel;
    EdDR_AreaAlt: TNumberBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  end;

var
  FrmConfig: TFrmConfig;

procedure DoConfig;

implementation

{$R *.fmx}

uses UConfig, System.UITypes;

procedure DoConfig;
begin
  FrmConfig := TFrmConfig.Create(Application);
  FrmConfig.ShowModal;
  FrmConfig.Free;
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
  EdDR_RefDist.Value := Config.DescentRamp_RefDist;
  EdDR_RefAlt.Value := Config.DescentRamp_RefAlt;
  EdDR_AreaDist.Value := Config.DescentRamp_AreaDist;
  EdDR_AreaAlt.Value := Config.DescentRamp_AreaAlt;
end;

procedure TFrmConfig.BtnOKClick(Sender: TObject);
begin
  Config.DescentRamp_RefDist := EdDR_RefDist.Value;
  Config.DescentRamp_RefAlt := EdDR_RefAlt.Value;
  Config.DescentRamp_AreaDist := EdDR_AreaDist.Value;
  Config.DescentRamp_AreaAlt := EdDR_AreaAlt.Value;

  Config.Save;

  ModalResult := mrOk;
end;

end.
