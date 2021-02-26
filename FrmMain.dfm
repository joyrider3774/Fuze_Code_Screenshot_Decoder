object MainForm: TMainForm
  Left = 0
  Top = 0
  Anchors = [akTop, akRight]
  Caption = 
    'Fuze Code Image Decoder - Created by joyrider3774 aka Willems Da' +
    'vy'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    624
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object lblcrc: TLabel
    Left = 251
    Top = 38
    Width = 25
    Height = 13
    Caption = 'CRC:'
  end
  object edtfilename: TEdit
    Left = 8
    Top = 6
    Width = 510
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
    ExplicitWidth = 709
  end
  object btnprocess: TButton
    Left = 8
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Process'
    TabOrder = 1
    OnClick = btnprocessClick
  end
  object mmo1: TMemo
    Left = 0
    Top = 64
    Width = 624
    Height = 377
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitWidth = 823
    ExplicitHeight = 670
  end
  object btnselect: TButton
    Left = 524
    Top = 4
    Width = 92
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Select'
    TabOrder = 3
    OnClick = btnselectClick
    ExplicitLeft = 723
  end
  object btnClear: TButton
    Left = 89
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = btnClearClick
  end
  object btnSave: TButton
    Left = 170
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object OpenFileDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Jpeg Files'
        FileMask = '*.JPG'
      end
      item
        DisplayName = 'Bitmap Files'
        FileMask = '*.BMP'
      end>
    Options = []
    Left = 768
    Top = 72
  end
  object SaveFileDialog: TFileSaveDialog
    DefaultExtension = '.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Text File'
        FileMask = '*.TXT'
      end>
    Options = [fdoOverWritePrompt]
    Left = 688
    Top = 72
  end
end
