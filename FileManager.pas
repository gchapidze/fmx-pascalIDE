unit FileManager;

interface

uses System.IOUtils;

type
  TFiles = class
    class procedure Copy(AFrom, ATo: String);
    class procedure Save(AText, AFilePath: String);
  end;

implementation

{ TFiles }

class procedure TFiles.Copy(AFrom, ATo: String);
begin
  TFile.Copy(AFrom, ATo);
end;

class procedure TFiles.Save(AText, AFilePath: String);
begin
  TFile.WriteAllText(AFilePath, AText);
end;

end.
