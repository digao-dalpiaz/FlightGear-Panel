object FrameEngine: TFrameEngine
  Left = 0
  Top = 0
  Width = 138
  Height = 194
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 138
    Height = 194
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 183
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
      Top = 168
      Width = 41
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Crank.'
      Color = 4227327
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object LbIgnition: TLabel
      Left = 48
      Top = 168
      Width = 41
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Ignition'
      Color = 4227327
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object LbRunning: TLabel
      Left = 8
      Top = 144
      Width = 49
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Running'
      Color = 959818
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object LbStarter: TLabel
      Left = 88
      Top = 168
      Width = 41
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Starter'
      Color = 4227327
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object LbCutOff: TLabel
      Left = 80
      Top = 144
      Width = 49
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'CutOff'
      Color = 136
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 51
      Height = 13
      Caption = 'THROTTLE'
    end
    object Shape1: TShape
      Left = 137
      Top = 13
      Width = 1
      Height = 181
      Align = alRight
      Pen.Color = clGray
      ExplicitLeft = 129
      ExplicitHeight = 170
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
