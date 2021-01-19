object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FlightGear Panel'
  ClientHeight = 620
  ClientWidth = 552
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Air Speed:'
    Color = 5592405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbAirSpeed: TLabel
    Left = 144
    Top = 8
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '#####'
    Color = 5592405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Ground Speed:'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbGroundSpeed: TLabel
    Left = 144
    Top = 40
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '#####'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label3: TLabel
    Left = 8
    Top = 408
    Width = 51
    Height = 13
    Caption = 'Total Fuel:'
  end
  object LbTotalFuel: TLabel
    Left = 64
    Top = 408
    Width = 32
    Height = 13
    Caption = '####'
  end
  object Label7: TLabel
    Left = 448
    Top = 344
    Width = 60
    Height = 13
    Caption = 'Speed Brake'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LbSpeedBrake_Arm: TLabel
    Left = 496
    Top = 360
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label9: TLabel
    Left = 456
    Top = 376
    Width = 31
    Height = 13
    Caption = 'Lever:'
  end
  object LbSpeedBrake_Lever: TLabel
    Left = 496
    Top = 376
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label8: TLabel
    Left = 448
    Top = 312
    Width = 53
    Height = 13
    Caption = 'Auto Brake'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LbAutoBrake: TLabel
    Left = 456
    Top = 328
    Width = 8
    Height = 13
    Caption = '#'
  end
  object LbParking: TLabel
    Left = 448
    Top = 280
    Width = 100
    Height = 25
    Caption = '[ Parking ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 8
    Top = 144
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Altitude:'
    Color = 5592405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbAltitude: TLabel
    Left = 144
    Top = 144
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '####'
    Color = 5592405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label22: TLabel
    Left = 8
    Top = 176
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'HAGL:'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbAltitudeAGL: TLabel
    Left = 144
    Top = 176
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '####'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label24: TLabel
    Left = 240
    Top = 24
    Width = 26
    Height = 13
    Caption = 'View:'
  end
  object LbView: TLabel
    Left = 280
    Top = 24
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label28: TLabel
    Left = 240
    Top = 8
    Width = 34
    Height = 13
    Caption = 'Speed:'
  end
  object LbSpeedUp: TLabel
    Left = 280
    Top = 8
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label32: TLabel
    Left = 8
    Top = 72
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Mach:'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbMach: TLabel
    Left = 144
    Top = 72
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '#####'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label33: TLabel
    Left = 8
    Top = 104
    Width = 129
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Vert. Speed:'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9230834
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LbVertSpeed: TLabel
    Left = 144
    Top = 104
    Width = 89
    Height = 25
    AutoSize = False
    Caption = '#####'
    Color = 2368548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label4: TLabel
    Left = 8
    Top = 216
    Width = 30
    Height = 13
    Caption = 'FLAPS'
  end
  object Label14: TLabel
    Left = 208
    Top = 216
    Width = 48
    Height = 13
    Caption = 'SPOILERS'
  end
  object Label31: TLabel
    Left = 328
    Top = 216
    Width = 66
    Height = 13
    Caption = 'SPEED BRAKE'
  end
  object Label5: TLabel
    Left = 448
    Top = 216
    Width = 27
    Height = 13
    Caption = 'GEAR'
  end
  object Label18: TLabel
    Left = 328
    Top = 280
    Width = 38
    Height = 13
    Caption = 'BRAKES'
  end
  object Label12: TLabel
    Left = 208
    Top = 280
    Width = 80
    Height = 13
    Caption = 'SPOILERS SIDES'
  end
  object Label6: TLabel
    Left = 8
    Top = 280
    Width = 59
    Height = 13
    Caption = 'FUEL TANKS'
  end
  object Label10: TLabel
    Left = 240
    Top = 48
    Width = 58
    Height = 13
    Caption = 'Destination:'
  end
  object LbDestination: TLabel
    Left = 304
    Top = 48
    Width = 232
    Height = 13
    Caption = '#############################'
  end
  object Label11: TLabel
    Left = 408
    Top = 8
    Width = 64
    Height = 13
    Caption = 'Airport Elev.:'
  end
  object Label13: TLabel
    Left = 408
    Top = 24
    Width = 62
    Height = 13
    Caption = 'Airport Dist.:'
  end
  object LbDestinationElev: TLabel
    Left = 480
    Top = 8
    Width = 32
    Height = 13
    Caption = '####'
  end
  object LbDestinationDist: TLabel
    Left = 480
    Top = 24
    Width = 32
    Height = 13
    Caption = '####'
  end
  object LbAutobrake2: TLabel
    Left = 488
    Top = 328
    Width = 8
    Height = 13
    Caption = '#'
  end
  object LbAutobrake3: TLabel
    Left = 520
    Top = 328
    Width = 8
    Height = 13
    Caption = '#'
  end
  object Label16: TLabel
    Left = 144
    Top = 408
    Width = 75
    Height = 13
    Caption = 'Closest Airport:'
  end
  object LbClosestAirport: TLabel
    Left = 224
    Top = 408
    Width = 79
    Height = 13
    Caption = 'LbClosestAirport'
  end
  object LbGroundSpoilersArmed: TLabel
    Left = 328
    Top = 408
    Width = 109
    Height = 13
    Caption = 'Ground Spoilers Armed'
  end
  object Label15: TLabel
    Left = 456
    Top = 360
    Width = 23
    Height = 13
    Caption = 'Arm:'
  end
  object LbSpeedBrake_Norm: TLabel
    Left = 496
    Top = 392
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label20: TLabel
    Left = 456
    Top = 408
    Width = 38
    Height = 13
    Caption = 'Output:'
  end
  object LbSpeedBrake_Output: TLabel
    Left = 496
    Top = 408
    Width = 24
    Height = 13
    Caption = '###'
  end
  object Label23: TLabel
    Left = 456
    Top = 392
    Width = 29
    Height = 13
    Caption = 'Norm:'
  end
  object BoxFlaps: TPanel
    Left = 8
    Top = 232
    Width = 193
    Height = 41
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 0
  end
  object BoxSpoilers: TPanel
    Left = 208
    Top = 232
    Width = 113
    Height = 41
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 1
  end
  object BoxSpeedBrake: TPanel
    Left = 328
    Top = 232
    Width = 113
    Height = 41
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 2
  end
  object BoxGear: TPanel
    Left = 448
    Top = 232
    Width = 97
    Height = 41
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 3
  end
  object BoxEngines: TPanel
    Left = 0
    Top = 440
    Width = 552
    Height = 180
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 553
  end
  object BoxBrakes: TPanel
    Left = 328
    Top = 296
    Width = 113
    Height = 105
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 5
  end
  object BoxSpoilersSide: TPanel
    Left = 208
    Top = 296
    Width = 113
    Height = 105
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 6
  end
  object BoxDescentRamp: TPanel
    Left = 240
    Top = 64
    Width = 305
    Height = 137
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 7
  end
  object BoxTanks: TPanel
    Left = 8
    Top = 296
    Width = 193
    Height = 105
    BevelOuter = bvNone
    Color = 2368548
    ParentBackground = False
    TabOrder = 8
  end
  object Server: TIdUDPServer
    Active = True
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 6688
      end>
    DefaultPort = 0
    OnUDPRead = ServerUDPRead
    Left = 568
    Top = 64
  end
end
