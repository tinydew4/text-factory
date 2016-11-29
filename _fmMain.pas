unit _fmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils,
  Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    BtnTemplate: TButton;
    EdtTemplate: TEdit;
    OpenDialog: TOpenDialog;
    EdtFilename: TEdit;
    LbFiles: TListBox;
    BtnAppend: TButton;
    MmOptions: TMemo;
    BtnDelete: TButton;
    BtnMake: TButton;
    BtnShowTemplate: TButton;
    BtnLoad: TButton;
    BtnSave: TButton;
    SaveDialog: TSaveDialog;
    procedure BtnTemplateClick(Sender: TObject);
    procedure BtnAppendClick(Sender: TObject);
    procedure LbFilesClick(Sender: TObject);
    procedure MmOptionsChange(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnMakeClick(Sender: TObject);
    procedure BtnShowTemplateClick(Sender: TObject);
    procedure EdtFilenameKeyPress(Sender: TObject; var Key: Char);
    procedure BtnLoadClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    FTemplate: TStrings;
    FData: TStrings;
    procedure Clear;
    procedure DoMake;
    procedure DoLoad(const AFileName: String);
    procedure DoSave(const AFileName: String);
  public
    { Public declarations }
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

var
  Form1: TForm1;

implementation

uses
  IniFiles;

{$R *.dfm}

{ TForm1 }

procedure TForm1.AfterConstruction;
begin
  inherited;

  Application.Title := 'Text factory';
  Caption := Application.Title;

  FTemplate := TStringList.Create;
  FData := TStringList.Create(True);

  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));

  ActiveControl := EdtFilename;
end;

destructor TForm1.Destroy;
begin
  inherited Destroy;

  FreeAndNil(FTemplate);
  FreeAndNil(FData);
end;

procedure TForm1.DoMake;
var
  pFactory: TStrings;
  pOptions: TStrings;
  I: Integer;
  J: Integer;
  sPath: String;
  sFilename: String;
  sTemplate: String;
  sOption: String;
begin
  sPath := ExtractFilePath(ParamStr(0));
  pFactory := TStringList.Create;
  try
    for I := 0 to Pred(FData.Count) do begin
      sFilename := sPath + FData.Strings[I];
      pOptions := TStrings(FData.Objects[I]);
      sTemplate := FTemplate.Text;
      for J := 0 to Pred(pOptions.Count) do begin
        sOption := pOptions.Names[J];
        sTemplate := StringReplace(sTemplate, sOption, pOptions.Values[sOption], [rfReplaceAll]);
      end;
      pFactory.Text := sTemplate;
      pFactory.SaveToFile(sFilename);
    end;
  finally
    FreeAndNil(pFactory);
  end;
end;

procedure TForm1.DoLoad(const AFileName: String);
var
  pIni: TMemIniFile;
  pEnumerator: TStringsEnumerator;
begin
  Clear;

  pIni := TMemIniFile.Create(AFileName);
  try
    pIni.ReadSections(LbFiles.Items);
    pEnumerator := LbFiles.Items.GetEnumerator;
    try
      while pEnumerator.MoveNext do begin
        FData.AddObject(pEnumerator.Current, TStringList.Create);
        pIni.ReadSectionValues(pEnumerator.Current, TStringList(FData.Objects[Pred(FData.Count)]));
      end;
    finally
      FreeAndNil(pEnumerator);
    end;
  finally
    FreeAndNil(pIni);
  end;
end;

procedure TForm1.DoSave(const AFileName: String);
var
  pIni: TMemIniFile;
  I: Integer;
  J: Integer;
  pOptions: TStrings;
  sName: String;

  procedure Backup(const AFileName, ABakExt: String);
  var
    sBakName: String;
  begin
    if not TFile.Exists(AFileName) then
      Exit;

    sBakName := ChangeFileExt(AFileName, ABakExt);
    if TFile.Exists(sBakName) then begin
      TFile.SetAttributes(sBakName, []);
      TFile.Delete(sBakName);
    end;

    if AFileName <> sBakName then
      TFile.Move(AFileName, sBakName);
  end;

begin
  Backup(AFileName, '.bak');

  pIni := TMemIniFile.Create(AFileName);
  try
    for I := 0 to Pred(FData.Count) do begin
      pOptions := TStrings(FData.Objects[I]);
      for J := 0 to Pred(pOptions.Count) do begin
        sName := pOptions.Names[J];
        if not sName.IsEmpty then
          pIni.WriteString(FData.Strings[I], sName, pOptions.Values[sName]);
      end;
    end;
    pIni.UpdateFile;
  finally
    FreeAndNil(pIni);
  end;
end;

procedure TForm1.EdtFilenameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_RETURN) then begin
    Key := Chr(0);

    BtnAppend.Click;
  end;
end;

procedure TForm1.LbFilesClick(Sender: TObject);
begin
  if LbFiles.ItemIndex >= 0 then begin
    MmOptions.Text := TStrings(FData.Objects[LbFiles.ItemIndex]).Text;
  end;
end;

procedure TForm1.MmOptionsChange(Sender: TObject);
begin
  if LbFiles.ItemIndex >= 0 then
    TStrings(FData.Objects[LbFiles.ItemIndex]).Text := MmOptions.Text;
end;

procedure TForm1.BtnAppendClick(Sender: TObject);
var
  sFilename: String;
begin
  sFilename := Trim(EdtFilename.Text);
  if sFilename.IsEmpty then begin
    ActiveControl := EdtFilename;
    Exit;
  end;
  FData.AddObject(sFilename, TStringList.Create);
  LbFiles.Items.Assign(FData);
  EdtFilename.Clear;
end;

procedure TForm1.BtnDeleteClick(Sender: TObject);
var
  iIndex: Integer;
begin
  iIndex := LbFiles.ItemIndex;
  if iIndex >= 0 then begin
    FData.Delete(iIndex);
    LbFiles.Items.Delete(iIndex);
  end;
end;

procedure TForm1.BtnMakeClick(Sender: TObject);
begin
  DoMake;
end;

procedure TForm1.BtnLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    DoLoad(OpenDialog.FileName);
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    DoSave(SaveDialog.FileName);
end;

procedure TForm1.BtnShowTemplateClick(Sender: TObject);
begin
  ShowMessage(FTemplate.Text);
end;

procedure TForm1.BtnTemplateClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    EdtTemplate.Text := OpenDialog.FileName;
    FTemplate.LoadFromFile(OpenDialog.FileName);
    ActiveControl := EdtFilename;
  end;
end;

procedure TForm1.Clear;
begin
  LbFiles.Clear;
  FData.Clear;
end;

end.
