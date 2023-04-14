unit FontManager;

interface

uses System.Generics.Collections, SysUtils;

type
  Consumer<T> = reference to procedure(AFont: T);

type
  IDEFont<T> = record
  strict private
    FFontArr: array [0 .. 8] of T;
    Index: Integer;
  public
    procedure forEach(AProc: Consumer<T>);
    procedure Range(const AFrom, ATo: Integer; AProc: Consumer<Integer>);
    procedure Add(AFont: T); overload;
    procedure Add(const AFonts: array of T); overload;
  end;

implementation

{ IDEFont<T> }

procedure IDEFont<T>.Add(AFont: T);
begin
  FFontArr[Index] := AFont;
  Inc(Index);
end;

procedure IDEFont<T>.Add(const AFonts: array of T);
begin
  for var I := Low(AFonts) to High(AFonts) do
  begin
    FFontArr[I] := AFonts[I];
    Inc(Index);
  end;
end;

procedure IDEFont<T>.forEach(AProc: Consumer<T>);
var
  I: UInt8;
begin
  I := Low(FFontArr);
  while I < High(FFontArr) do
  begin
    AProc(FFontArr[I]);
    Inc(I);
  end;
end;

procedure IDEFont<T>.Range(const AFrom, ATo: Integer; AProc: Consumer<Integer>);
begin
  for var I := AFrom to ATo do
    AProc(I);
end;

end.
