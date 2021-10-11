{midi info by http://www.keygenmusic.net/}
{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit Unit1;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, ShellAPI, KOL {$IFNDEF KOL_MCK}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,
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
    Label4: TKOLLabel;
    Label5: TKOLLabel;
    EditBox4: TKOLEditBox;
    Label6: TKOLLabel;
    EditBox5: TKOLEditBox;
    Label7: TKOLLabel;
    EditBox6: TKOLEditBox;
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure Button1Click(Sender: PObj);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TEventData = packed record    // ** nb takes 5 bytes
  case status : byte of
    0 : (b2, b3 : byte);
    1 : (sysex : PChar)
  end;
  PEventData = ^TEventData;

//---------------------------------------------------------------------------
// Midi event
  PMidiEventData = ^TMidiEventData;
  TMidiEventData = packed record // ** nb takes 11 bytes
    pos : LongInt;               // Position in ticks from start of song.
    sysexSize : word;            // Size of sysex or meta message
    data : TEventData;           // Event data
    OnOffEvent : PMidiEventData;
  end;
  TTrack = 0..255;
  TChannel = 0..15;
  TNote = 0..127;
  TController = 0..127;
  TPatchNo = 0..127;
  TBankNo = 0..127;
  TControllerValue = 0..127;

const
  midiNoteOff 	        = $80;
  midiNoteOn            = $90;
  midiKeyAftertouch 	= $a0;
  midiController 	= $b0;
  midiProgramChange 	= $c0;
  midiChannelAftertouch = $d0;
  midiPitchBend 	= $e0;
  midiSysex       	= $f0;
  midiSysexCont		= $f7;
  midiMeta		= $ff;

  midiStatusMask	= $f0;
  midiStatus		= $80;
  midiChannelMask	= $0f;

  metaSeqno		= $00;
  metaText		= $01;
  metaCopyright		= $02;
  metaTrackName		= $03;
  metaInstrumentName	= $04;
  metaLyric		= $05;
  metaMarker		= $06;
  metaCuePoint		= $07;
  metaMiscText0		= $08;
  metaMiscText1		= $09;
  metaMiscText2		= $0a;
  metaMiscText3		= $0b;
  metaMiscText4		= $0c;
  metaMiscText5		= $0d;
  metaMiscText6		= $0e;
  metaMiscText7		= $0f;
  metaTrackStart	= $21;
  metaTrackEnd		= $2f;
  metaTempoChange	= $51;
  metaSMPTE		= $54;
  metaTimeSig		= $58;
  metaKeySig		= $59;
  metaSequencer		= $7f;
  chanType : array [0..15] of integer = (0, 0, 0, 0, 0, 0, 0, 0,
                                         2, 2, 2, 2, 1, 1, 2, 0);

var
  Form1 {$IFDEF KOL_MCK} : PForm1 {$ELSE} : TForm1 {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$ENDIF}
function FastSwap(Value: LongWord): LongWord; register; overload;
function FastSwap16(Value: Word): Word; register; overload;

implementation

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I Unit1_1.inc}
{$ENDIF}

procedure TForm1.KOLForm1FormCreate(Sender: PObj);
begin
  OpenSaveDialog1.InitialDir:=GetStartDir;
  label4.Caption:='Tempo changes'+#13#10+'(uSecs/quarternote,'+#13#10+
       'default=125000):'+#13#10+'Track:'+#09+'tempo';
end;

function FastSwap(Value: LongWord): LongWord; register; overload;
asm
  bswap eax
end;

function FastSwap16(Value: Word): Word; register; overload;
asm
  xchg ah,al
end;


procedure TForm1.Button1Click(Sender: PObj);
var trk,Tracks,Ticks:word;
  trackSize:cardinal;
  SMFType:byte;
  tmpin:dword;
  divi : Integer;
  fst, buffer:PStream;
  fPatch: TPatchNo;
  fChannel: TChannel;
  fTrackName : PMidiEventData;
  gotEndOfTrack : boolean;
  curticks,tticks,qtrns, curtempo, curtime, ttime:dword;

function DoPass (pass2 : boolean) : Integer;
  var
    sysexFlag : boolean;
    l, pos : Integer;
    c, c1, status, runningStatus, mess : byte;
    events : PMidiEventData;
    notGotPatch, notGotChannel, newStatus : boolean;
    eventCount, tmptick: Integer;

  //-----------------------------------------------------------------------
  //  function GetFVariNum : Integer;
  //
  //  Get a variable length integer from the SMF data.  The first byte is
  // the most significant.  Use onlu the lower 7 bits of each bytes - the
  // eigth is set if there are more bytes.

    function GetFVariNum : Integer;
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
    end;

  begin
    events := buffer.Memory;
    eventCount := 0;
    runningStatus := 0;              // Clear 'running status'
    divi := 0;                       // Current position (in ticks) is zero
    newStatus := False;
    pos := 0;                        // Start at the beginning of the buffer
    sysexFlag := False;              // Clear flag - we're not in the middle of
                                     // a sysex message

    notGotChannel := True;
    notGotPatch := True;
    tmptick:=0;
    curtime:=0;
    while pos < trackSize do
    begin
      Inc (divi, GetFVariNum);       // Get event position
      c := GetFChar;                 // Get first byte of event status if it's >= $80

                                     // If we're in the middle of a sysex msg, this
                                     // must be a sysex continuation event
     { if sysexFlag and (c <> midiSysexCont) then
        raise EMidiTrackStream.Create ('Error in Sysex'); }

      if (c and midiStatus) <> 0 then
      begin                          // It's a 'status' byte
        status := c;
        newStatus := True;           // Get the first data byte
      end
      else
      begin
        status := runningStatus;
       { if status = 0 then
                                     // byte indicates 'running status' but we don't
                                     // know the status
          raise EMidiTrackStream.Create ('Error in Running Status')   }
      end;

   {   if pass2 then
      begin
        events^.pos := divi;
        events^.data.status := status
      end;  }

      if status < midiSysex then           // Is it a 'channel' message
      begin
        if NewStatus then
        begin
          c := GetFChar;
          NewStatus := False;
          runningStatus := status
        end;

        mess := (status shr 4);      // the top four bits of the status
                                     // Get the second data byte if there is one.
        if chanType [mess] > 1 then c1 := GetFChar else c1 := 0;

        if not pass2 then
        begin
          if notGotPatch and (mess = $c) then
          begin                         // It's  the first 'patch change' message
            notGotPatch := False;
            fPatch := c
          end;

          if notGotChannel then
          begin                         // It's the first 'channel' message
            notGotChannel := False;
            fChannel := status and midiChannelMask;
          end
        end
        else
          with events^ do
          begin
            data.b2 := c;              // Save the data bytes
            data.b3 := c1
          end
      end
      else
      begin                          // It's a meta event or sysex.
        newStatus := False;
        case status of
          midiMeta :                      // Meta event
            begin
              c1 := GetFChar;        // Get meta type  *********** tempohandle
              l := GetFVariNum;      // Get data len

                                     // Allocate space for message (including meta type)
              if pass2 then
              begin
         {       events^.sysexSize := l + 1;
                GetMem (events^.data.sysex, events^.sysexSize);

                events^.data.sysex [0] := char (c1);
                Move (pointer (Integer (buffer.Memory) + pos)^, events^.data.sysex [1], l);
                case c1 of             // Save 'track name' event
                  metaTrackName :
                    fTrackName := events;
                  metaText : if fTrackName = Nil then fTrackName := events;

                end }
              end
              else
                if (c1 = metaTempoChange) and (l=3)  then begin
                 tmptick:=divi-tmptick;
                 inc (curtime, trunc((tmptick/120)*curtempo) );
                 curtempo:=(256*GetFChar+GetFChar)*256+GetFChar;
                     label4.Caption:=label4.Caption+#13#10+int2str(Tracks)+
                    ':'+#09+int2str(curtempo);
                end;
                if c1 = metaTrackEnd then
                  if not gotEndOfTrack then
                    gotEndOfTrack := True;

              Inc (pos, l);

            end;

          midiSysex, midiSysexCont:  // Sysex event
            begin
              l := GetFVariNum;     // Get length of sysex data

          {    if pass2 then
              begin
                                    // Allocate a buffer, and copy it in.
                events^.sysexSize := l;
                GetMem (events^.data.sysex, l);
                Move (pointer (Integer (buffer.Memory) + pos)^, events^.data.sysex [0], l);
              end;   }
              Inc (pos, l);
                                    // Set flag if the message doesn't end with f7
              sysexFlag := PChar (Integer (buffer.Memory) + pos - 1)^ <> char (midiSysexCont);
            end
        end
      end;
      Inc (eventCount);
      Inc (events);
    end;
    result := eventCount;
    curticks:=divi;
    tmptick:=divi-tmptick;
    inc(curtime, trunc((tmptick/Ticks)*curtempo) );

  end;

begin
Ticks:=0;
Tracks:=0;
//curtime:=0;
ttime:=0;
curtempo:=125000;
label4.Caption:='Tempo changes'+#13#10+'(uSecs/quarternote,'+#13#10+
       'default=125000):'+#13#10+'Track:'+#09+'tempo';
 if OpenSaveDialog1.Execute=true then begin
   fst:=NewReadFileStream(OpenSaveDialog1.Filename);
   try
   fst.Seek(4, spBegin);     //'MThd'
   fst.Read(tmpin, 4);
   fst.Seek(1, spCurrent);
   fst.Read(SMFType, 1);
   fst.Seek(1, spCurrent);
   fst.Read(Tracks, 1);
   fst.Read(Ticks, 2);
   Ticks:=FastSwap16(Ticks);
   tticks:=0;
   curticks:=0;
   finally
   for trk := 1 to Tracks do            //to Tracks
  begin
    if fst.ReadStrLen(4)<>'MTrk' then  break;
    fst.Read(trackSize, 4);
    trackSize:=fastswap(trackSize);
    buffer:=NewMemoryStream;
    Stream2Stream(buffer, fst, trackSize);
    DoPass(false);
    if curticks>tticks then tticks:=curticks;
    if curtime>ttime then ttime:=curtime;
    buffer.Free;
  end;
   end;

fst.Free;
ttime:=ttime div 1000;
if ticks>0 then
 qtrns:=tticks div ticks;
EditBox1.Text:=Format('%d',[SMFType]);
EditBox2.Text:=int2str(Tracks);
EditBox3.Text:=int2str(Ticks);
EditBox4.Text:=int2str(tticks);
EditBox5.Text:=int2str(qtrns);
EditBox6.Text:=int2str(ttime);
end;
 end;
end.


