unit UFrmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmConfig = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EdRampWidth: TEdit;
    Label2: TLabel;
    EdRampStartAlt: TEdit;
    Label3: TLabel;
    EdRampStartDist: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.dfm}

end.
