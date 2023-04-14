unit FileManager;

interface

uses System.IOUtils;

type
  TFiles = class
    class procedure Copy(AFrom, ATo: String);
  end;

implementation

{ TFiles }

class procedure TFiles.Copy(AFrom, ATo: String);
begin
  TFile.Copy(AFrom, ATo);
end;

end.
