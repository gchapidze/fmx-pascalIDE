{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.ListBox, FontManager, System.IOUtils, FileManager,
  DosCommand;

type
  TForm1 = class(TForm)
    IDEThemes: TStyleBook;
    OpenBtn: TButton;
    ActionList: TActionList;
    actOpen: TAction;
    MemoSourceCodeEditor: TMemo;
    FontOptions: TComboBox;
    FontSizeOptions: TComboBox;
    CompileBtn: TButton;
    actCompile: TAction;
    MemoCompilerEditor: TMemo;
    SaveCheckBox: TCheckBox;
    actSave: TAction;
    SaveBtn: TButton;
    DosCommand: TDosCommand;
    RunBtn: TButton;
    DosCommand1: TDosCommand;
    procedure SetUpFonts;
    procedure actOpenExecute(Sender: TObject);
    procedure FontOptionsChange(Sender: TObject);
    procedure FontSizeOptionsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCompileExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveCheckBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SaveCheckBoxClick(Sender: TObject);
    procedure RunBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure Exec(APasFile: String);
    procedure ExecAndRun(APasFile: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FFontManager: IDEFont<String>;
  SourceCodeFile: String;

implementation

{$R *.fmx}

procedure TForm1.actCompileExecute(Sender: TObject);
begin
  Exec(SourceCodeFile);
end;

procedure TForm1.actOpenExecute(Sender: TObject);
begin
  var
  FileDialog := TOpenDialog.Create(nil);
  if FileDialog.Execute then
  begin
    SourceCodeFile := FileDialog.FileName;

    var
    Pipe := TStringList.Create;
    Pipe.LoadFromFile(SourceCodeFile);
    MemoSourceCodeEditor.Text := Pipe.Text;

    Pipe.Free;
    FileDialog.Free;
  end;
end;

procedure TForm1.actSaveExecute(Sender: TObject);
begin
  if not SourceCodeFile.IsEmpty then
    TFiles.Save(MemoSourceCodeEditor.Text, SourceCodeFile);
end;

procedure TForm1.SaveCheckBoxClick(Sender: TObject);
begin
  if SaveCheckBox.IsChecked then
    SaveCheckBox.IsChecked := False
  else
    SaveCheckBox.IsChecked := True;
end;

procedure TForm1.SaveCheckBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  SaveCheckBoxClick(Self);
end;

procedure TForm1.Exec(APasFile: String);
begin
  actSaveExecute(Self);
  if not SourceCodeFile.IsEmpty then
  begin
    MemoCompilerEditor.Lines.Clear;
    DosCommand.CommandLine := 'cmd.exe /c fpc ' + SourceCodeFile;
    DosCommand.OutputLines := MemoCompilerEditor.Lines;
    DosCommand.Execute;
    MemoCompilerEditor.Lines := DosCommand.Lines;
  end;
end;

procedure TForm1.ExecAndRun(APasFile: String);
begin
  MemoCompilerEditor.Lines.Clear;
  actSaveExecute(Self);
  if not SourceCodeFile.IsEmpty then
  begin
    Exec(APasFile);
    // TODO Execure Generated .exe file and append on MemoCompilerEditor
    DosCommand1.CommandLine := 'cmd.exe /c ' + SourceCodeFile.Substring(0,
      SourceCodeFile.IndexOf('.')) + '.exe';
    DosCommand1.OutputLines := MemoCompilerEditor.Lines;
    DosCommand1.Execute;
    MemoCompilerEditor.Lines := DosCommand1.Lines;
  end;
end;

procedure TForm1.FontOptionsChange(Sender: TObject);
begin
  MemoSourceCodeEditor.Font.Family := FontOptions.Selected.Text;
end;

procedure TForm1.FontSizeOptionsChange(Sender: TObject);
begin
  MemoSourceCodeEditor.Font.Size := FontSizeOptions.Selected.Text.ToSingle;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if SaveCheckBox.IsChecked then
    actSaveExecute(Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetUpFonts;
  MemoCompilerEditor.ReadOnly := True;

  var
  CompilerFont := TFont.Create;
  CompilerFont.SetSettings('Segoe UI', 12, TFontStyleExt.Default);
  MemoCompilerEditor.TextSettings.Font := CompilerFont;
  MemoCompilerEditor.TextSettings.FontColor := TAlphaColorRec.Chartreuse;
end;

procedure TForm1.RunBtnClick(Sender: TObject);
begin
  ExecAndRun(SourceCodeFile);
end;

procedure TForm1.SetUpFonts;
begin
  FFontManager.Add(['Consolas', 'Lucida Console', 'Courier New', 'Georgia',
    'Ink Free', 'Gadugi', 'Impact', 'Javanese Text']);

  FFontManager.forEach(
    procedure(V: String)
    begin
      FontOptions.Items.Add(V)
    end);

  FFontManager.Range(10, 20,
    procedure(V: Integer)
    begin
      FontSizeOptions.Items.Add(V.ToString);
    end);
end;

end.
