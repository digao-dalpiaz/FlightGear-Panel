object FrameEngine: TFrameEngine
  Left = 0
  Top = 0
  Width = 138
  Height = 183
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 138
    Height = 183
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object LbTitle: TLabel
      Left = 0
      Top = 0
      Width = 138
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'ENGINE #'
      Color = clGreen
      ParentColor = False
      Transparent = False
      ExplicitWidth = 48
    end
    object Label5: TLabel
      Left = 8
      Top = 80
      Width = 51
      Height = 13
      Caption = 'REVERSER'
    end
    object LbCranking: TLabel
      Left = 8
      Top = 160
      Width = 42
      Height = 13
      Caption = 'Cranking'
    end
    object LbIgnition: TLabel
      Left = 56
      Top = 160
      Width = 36
      Height = 13
      Caption = 'Ignition'
    end
    object LbRunning: TLabel
      Left = 8
      Top = 144
      Width = 39
      Height = 13
      Caption = 'Running'
    end
    object LbStarter: TLabel
      Left = 96
      Top = 160
      Width = 34
      Height = 13
      Caption = 'Starter'
    end
    object LbCutOff: TLabel
      Left = 96
      Top = 144
      Width = 33
      Height = 13
      Caption = 'CutOff'
    end
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 51
      Height = 13
      Caption = 'THROTTLE'
    end
    object Bevel1: TBevel
      Left = 128
      Top = 13
      Width = 10
      Height = 170
      Align = alRight
      Shape = bsRightLine
      ExplicitLeft = 136
    end
    object BoxRev: TPanel
      Left = 8
      Top = 96
      Width = 121
      Height = 41
      BevelOuter = bvNone
      Color = 2368548
      ParentBackground = False
      TabOrder = 0
    end
    object BoxThrottle: TPanel
      Left = 8
      Top = 32
      Width = 121
      Height = 41
      BevelOuter = bvNone
      Color = 2368548
      ParentBackground = False
      TabOrder = 1
    end
  end
end
