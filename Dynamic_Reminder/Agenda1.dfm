object Form1: TForm1
  Left = 241
  Top = 127
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Reminder'
  ClientHeight = 394
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 120
  TextHeight = 16
  object lQUITTER: TLabel
    Left = 34
    Top = 1
    Width = 40
    Height = 21
    Caption = '2010'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -18
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Pmemo: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 394
    Color = 16764671
    TabOrder = 0
    Visible = False
    object Ljour: TLabel
      Left = 7
      Top = 8
      Width = 51
      Height = 26
      Caption = 'Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bRETOUR: TButton
      Left = 428
      Top = 5
      Width = 93
      Height = 26
      Caption = 'Save'
      TabOrder = 0
      OnClick = bRETOURClick
    end
    object M1: TMemo
      Left = 6
      Top = 37
      Width = 515
      Height = 284
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object L1: TListBox
    Left = 18
    Top = 204
    Width = 439
    Height = 99
    ItemHeight = 16
    TabOrder = 1
    Visible = False
  end
end
