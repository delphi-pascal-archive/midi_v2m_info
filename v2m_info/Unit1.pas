{v2m info by http://www.keygenmusic.net/}
{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit Unit1;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, {ShellAPI,} KOL {$IFNDEF KOL_MCK}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,
  mckCtrls {$ENDIF (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IFDEF KOL_MCK}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} TForm1 = class; PForm1 = TForm1; {$ELSE OBJECTS} PForm1 = ^TForm1; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TForm1.inc}{$ELSE} TForm1 = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TForm1 = class(TForm)
  {$ENDIF KOL_MCK}
    KOLProject1: TKOLProject;
    KOLForm1: TKOLForm;
    Button1: TKOLButton;
    Label1: TKOLLabel;
    EditBox1: TKOLEditBox;
    Label2: TKOLLabel;
    EditBox2: TKOLEditBox;
    EditBox3: TKOLEditBox;
    Label3: TKOLLabel;
    OpenSaveDialog1: TKOLOpenSaveDialog;
    Label5: TKOLLabel;
    EditBox4: TKOLEditBox;
    Label6: TKOLLabel;
    EditBox5: TKOLEditBox;
    Label7: TKOLLabel;
    EditBox6: TKOLEditBox;
    Label4: TKOLLabel;
    EditBox7: TKOLEditBox;
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure Button1Click(Sender: PObj);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 {$IFDEF KOL_MCK} : PForm1 {$ELSE} : TForm1 {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$ENDIF}
{function FastSwap(Value: LongWord): LongWord; register; overload;
function FastSwap16(Value: Word): Word; register; overload; }

implementation

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I Unit1_1.inc}
{$ENDIF}

procedure TForm1.KOLForm1FormCreate(Sender: PObj);
begin
  OpenSaveDialog1.InitialDir:=GetStartDir;
end;

{function FastSwap(Value: LongWord): LongWord; register; overload;
asm
  bswap eax
end;

function FastSwap16(Value: Word): Word; register; overload;
asm
  xchg ah,al
end; }


procedure TForm1.Button1Click(Sender: PObj);
var
  tdl, tdh, tdh2, tsign, tsigd, tpq:byte;
  fst:PStream;
  fract, maxt, gevsno, usecs, ttime:dword;
  //-----------------------------------------------------------------------
  //  function GetFVariNum : Integer;
  //
  //  Get a variable length integer from the SMF data.  The first byte is
  // the most significant.  Use onlu the lower 7 bits of each bytes - the
  // eigth is set if there are more bytes.

 {   function GetFVariNum : Integer;
    var
      l : Integer;
      b : byte;
    begin
      l := 0;
      repeat
        b := PByte (Integer (buffer.Memory) + pos)^;
        Inc (pos);
        l := (l shl 7) + (b and $7f);  // Add it to what we've already got
      until (b and $80) = 0;           // Finish when the 8th bit is clear.
      result := l
    end;

  //-----------------------------------------------------------------------
  //  function GetFChar : Integer;
  //
  // Get a byte from the SMF stream

    function GetFChar : byte;
    begin
      result := PByte (Integer (buffer.Memory) + pos)^;
      Inc (pos);
    end; }
begin
 if OpenSaveDialog1.Execute=true then begin
   fst:=NewReadFileStream(OpenSaveDialog1.Filename);
   fst.Read(fract,4);
   fst.Read(maxt, 4);
   fst.Read(gevsno,4);
   fst.Read(tdl, 1);
   fst.Read(tdh, 1);
   fst.Read(tdh2, 1);
   fst.Read(usecs, 4);
   fst.Read(tsign, 1);
   fst.Read(tsigd, 1);
   fst.Read(tpq, 1);
   ttime:=(((maxt shl 3) div fract +1) div tpq)*usecs  div 1000 +2000;
 end;
fst.Free;
EditBox1.Text:=int2str(fract);
EditBox2.Text:=int2str(maxt);
EditBox3.Text:=int2str(gevsno);
EditBox4.Text:=int2str(tdl)+', '+int2str(tdh)+', '+int2str(tdh2);
EditBox5.Text:=int2str(usecs);
EditBox6.Text:=int2str(tsign)+', '+int2str(tsigd)+', '+int2str(tpq);
EditBox7.Text:=int2str(ttime);
end;

end.


