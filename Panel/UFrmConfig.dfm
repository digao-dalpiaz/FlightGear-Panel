object FrmConfig: TFrmConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 211
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 121
    Caption = 'Descent Ramp'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 27
      Width = 178
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Graph total distance:'
    end
    object Label2: TLabel
      Left = 16
      Top = 59
      Width = 178
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ideal start HAGL:'
    end
    object Label3: TLabel
      Left = 16
      Top = 91
      Width = 178
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ideal start distance from runway:'
    end
    object Label4: TLabel
      Left = 256
      Top = 27
      Width = 14
      Height = 13
      Caption = 'nm'
    end
    object Label5: TLabel
      Left = 256
      Top = 59
      Width = 8
      Height = 13
      Caption = 'ft'
    end
    object Label6: TLabel
      Left = 256
      Top = 91
      Width = 14
      Height = 13
      Caption = 'nm'
    end
    object EdRampWidth: TEdit
      Left = 200
      Top = 24
      Width = 49
      Height = 21
      NumbersOnly = True
      TabOrder = 0
    end
    object EdRampStartAlt: TEdit
      Left = 200
      Top = 56
      Width = 49
      Height = 21
      NumbersOnly = True
      TabOrder = 1
    end
    object EdRampStartDist: TEdit
      Left = 200
      Top = 88
      Width = 49
      Height = 21
      NumbersOnly = True
      TabOrder = 2
    end
  end
  object BtnOK: TButton
    Left = 144
    Top = 168
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 232
    Top = 168
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
