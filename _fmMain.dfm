object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 304
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  DesignSize = (
    635
    304)
  PixelsPerInch = 96
  TextHeight = 13
  object BtnTemplate: TButton
    Left = 471
    Top = 8
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Set Template'
    TabOrder = 0
    OnClick = BtnTemplateClick
  end
  object EdtTemplate: TEdit
    Left = 8
    Top = 8
    Width = 457
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
  end
  object EdtFilename: TEdit
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyPress = EdtFilenameKeyPress
  end
  object LbFiles: TListBox
    Left = 8
    Top = 62
    Width = 121
    Height = 234
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
    OnClick = LbFilesClick
    ExplicitHeight = 447
  end
  object BtnAppend: TButton
    Left = 135
    Top = 35
    Width = 75
    Height = 21
    Caption = 'Append'
    TabOrder = 4
    OnClick = BtnAppendClick
  end
  object MmOptions: TMemo
    Left = 135
    Top = 62
    Width = 492
    Height = 234
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 5
    OnChange = MmOptionsChange
    ExplicitHeight = 230
  end
  object BtnDelete: TButton
    Left = 216
    Top = 35
    Width = 75
    Height = 21
    Caption = 'Delete'
    TabOrder = 6
    OnClick = BtnDeleteClick
  end
  object BtnMake: TButton
    Left = 552
    Top = 35
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Make'
    TabOrder = 7
    OnClick = BtnMakeClick
  end
  object BtnShowTemplate: TButton
    Left = 552
    Top = 8
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Show'
    TabOrder = 8
    OnClick = BtnShowTemplateClick
  end
  object BtnLoad: TButton
    Left = 390
    Top = 35
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Load'
    TabOrder = 9
    OnClick = BtnLoadClick
  end
  object BtnSave: TButton
    Left = 471
    Top = 35
    Width = 75
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Save'
    TabOrder = 10
    OnClick = BtnSaveClick
  end
  object OpenDialog: TOpenDialog
    Left = 496
    Top = 64
  end
  object SaveDialog: TSaveDialog
    Filter = 'All files(*.*)|*.*'
    Left = 552
    Top = 64
  end
end
