object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FlightGear PropertyList XML Generator'
  ClientHeight = 190
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 149
    Height = 13
    Caption = 'FlightGear installation directory'
  end
  object BtnSelDir: TSpeedButton
    Left = 472
    Top = 31
    Width = 25
    Height = 23
    Caption = '...'
    OnClick = BtnSelDirClick
  end
  object Bevel1: TBevel
    Left = 16
    Top = 128
    Width = 481
    Height = 9
    Shape = bsTopLine
  end
  object BtnExecute: TButton
    Left = 184
    Top = 136
    Width = 145
    Height = 41
    Caption = 'Generate XML File'
    TabOrder = 1
    OnClick = BtnExecuteClick
  end
  object EdDir: TEdit
    Left = 16
    Top = 32
    Width = 449
    Height = 21
    TabOrder = 0
  end
end
