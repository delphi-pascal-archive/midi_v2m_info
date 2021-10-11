{ KOL MCK } // Do not remove this line!
type TOpenSaveDialog_ = object(TOpenSaveDialog) end;
const Sizeof_TForm1 = Sizeof(TForm1);
type TControl_ = object( TControl ) end;
type TObj_ = object( TObj ) end;
type _TObj_ = object( _TObj ) end;

{$IFDEF Pcode}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$IFDEF Psource}
 PROC(2)
 Load4 ####@@formvmt L(0)
 TObj.Create<2> RESULT
 SetSELF
 DUP C2 Store
 LoadAnsiStr 'MIDI info' #0
 C4 
 NewForm<2> RESULT
 DUP C3 AddByte_Store #TForm1.Form
 L(113) L(192) C2 TControl.SetPosition<3> L(278) L(396) C2 TControl.SetClientSize<3>
 DUP StoreVar ####Applet
 LoadSELF C1 
 TControl.Add2AutoFree<2>
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Form1' #0
 C2 TObj.SetName<2>
 DelAnsiStr
 ENDIF
 DUP TControl_.GetFont<1> RESULT
 L($20000000)
 C1 TGraphTool.SetColor<2>
 DEL // Font
 L(1540)  LoadAnsiStr  #0 C2R  LoadAnsiStr  #0 C2R  NewOpenSaveDialog<3> RESULT DUP LoadSELF AddWord_Store ##TForm1.OpenSaveDialog1 L(2) R2CN DelAnsiStr DelAnsiStr
 LoadAnsiStr 'midi|*.mid' #0 C2 AddByte_Store #TOpenSaveDialog_.FFilter DEL
 LoadSELF C1 
 TControl.Add2AutoFree<2>
 //P_AssignEvents for OpenSaveDialog1
 DEL //OpenSaveDialog1
 LoadAnsiStr 'MIDI format' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(88) L(32) C2 TControl.SetPosition<3> L(0) L(73) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label1
 LoadAnsiStr 'tracks' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(120) L(56) C2 TControl.SetPosition<3> L(0) L(49) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label2
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label2' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label2
 LoadAnsiStr 'Ticks/Quarternotes' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(152) L(0) C2 TControl.SetPosition<3> L(0) L(113) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label3
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label3' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label3
 LoadAnsiStr 'Tempo:0,0:125000' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(24) L(224) C2 TControl.SetPosition<3> L(241) L(161) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label4
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label4' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label4
 LoadAnsiStr 'Total ticks' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(180) L(40) C2 TControl.SetPosition<3> L(0) L(65) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label5
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label5' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label5
 LoadAnsiStr 'Quarternotes' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(212) L(24) C2 TControl.SetPosition<3> L(0) L(81) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label6
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label6' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label6
 LoadAnsiStr 'Length mSec' #0 C2
 NewLabel<2>
 RESULT
 xySwap DelAnsiStr L(244) L(24) C2 TControl.SetPosition<3> L(0) L(81) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.Label7
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Label7' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Label7
 LoadAnsiStr 'Open' #0
 C2
 NewButton<2>
 RESULT
L(8) L(8) C2 TControl.SetPosition<3> xySwap DelAnsiStr
 DUP LoadSELF AddWord_Store ##TForm1.Button1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'Button1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 DEL //Button1
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(88) L(115) C2 TControl.SetPosition<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox1
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox1' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox1
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(120) L(115) C2 TControl.SetPosition<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox2
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox2' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox2
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(152) L(115) C2 TControl.SetPosition<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox3
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox3' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox3
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(180) L(115) C2 TControl.SetPosition<3> L(24) L(0) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox4
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox4' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox4
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(212) L(115) C2 TControl.SetPosition<3> L(24) L(0) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox5
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox5' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox5
 L(0) 
 LoadSELF AddWord_LoadRef ##TForm1.Form
 NewEditBox<2>
 RESULT
L(244) L(115) C2 TControl.SetPosition<3> L(24) L(0) C2 TControl.SetSize<3>
 DUP LoadSELF AddWord_Store ##TForm1.EditBox6
 IFDEF(USE_NAMES)
 LoadAnsiStr 'EditBox6' #0
 C2 TObj_.SetName<2>
 DelAnsiStr
 ENDIF
 L($FF000005)
 C1 TControl_.SetCtlColor<2>
 DEL //EditBox6
 LoadSELF AddByte_LoadRef #TForm1.Form TControl.GetWindowHandle<1> RESULT LoadSELF AddWord_LoadRef ##TForm1.OpenSaveDialog1 AddWord_Store ##TOpenSaveDialog_.fWnd
 LoadSELF AddWord_LoadRef ##TForm1.Button1
 Load4 ####TForm1.Button1Click
 C1 AddWord_Store ##TControl_.fOnClick
 LoadSELF C1 AddWord_Store ##(4+TControl_.fOnClick)
 DEL //Button1
 LoadSELF DUP TForm1.KOLForm1FormCreate<2>
 DEL DelAnsiStr DEL(3) EXIT
           ####Sizeof_TForm1
           ####0
@@formvmt: ####_TObj_.Init
           ####TObj.Destroy
 ENDP
{$ENDIF Psource}
{$ELSE OldCode}
procedure NewForm1( var Result: PForm1; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PForm1.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewForm( AParent, 'MIDI info' ).SetPosition( 192, 113 ){No MainMenu!}.SetClientSize( 396, 278 );
  Applet :=  Result.Form;
  Result.Form.Add2AutoFree( Result );
   {$IFDEF USE_NAMES}
    Result.Form.Name := 'Form1';
   {$ENDIF}
    Result.Form.Font.Color := clDefault;

    Result.OpenSaveDialog1 := NewOpenSaveDialog( '', '', [ OSFileMustExist, OSOverwritePrompt, OSPathMustExist ] );
      Result.OpenSaveDialog1.Filter := 'midi|*.mid';
  Result.Form.Add2AutoFree( Result.OpenSaveDialog1 );
    // Result.Label1.TabOrder = -1
    Result.Label1 := NewLabel( Result.Form, 'MIDI format' ).SetPosition( 32, 88 ).SetSize( 73, 0 );
   {$IFDEF USE_NAMES}
    Result.Label1.Name := 'Label1';
   {$ENDIF}
    // Result.Label2.TabOrder = -1
    Result.Label2 := NewLabel( Result.Form, 'tracks' ).SetPosition( 56, 120 ).SetSize( 49, 0 );
   {$IFDEF USE_NAMES}
    Result.Label2.Name := 'Label2';
   {$ENDIF}
    // Result.Label3.TabOrder = -1
    Result.Label3 := NewLabel( Result.Form, 'Ticks/Quarternotes' ).SetPosition( 0, 152 ).SetSize( 113, 0 );
   {$IFDEF USE_NAMES}
    Result.Label3.Name := 'Label3';
   {$ENDIF}
    // Result.Label4.TabOrder = -1
    Result.Label4 := NewLabel( Result.Form, 'Tempo:0,0:125000' ).SetPosition( 224, 24 ).SetSize( 161, 241 );
   {$IFDEF USE_NAMES}
    Result.Label4.Name := 'Label4';
   {$ENDIF}
    // Result.Label5.TabOrder = -1
    Result.Label5 := NewLabel( Result.Form, 'Total ticks' ).SetPosition( 40, 180 ).SetSize( 65, 0 );
   {$IFDEF USE_NAMES}
    Result.Label5.Name := 'Label5';
   {$ENDIF}
    // Result.Label6.TabOrder = -1
    Result.Label6 := NewLabel( Result.Form, 'Quarternotes' ).SetPosition( 24, 212 ).SetSize( 81, 0 );
   {$IFDEF USE_NAMES}
    Result.Label6.Name := 'Label6';
   {$ENDIF}
    // Result.Label7.TabOrder = -1
    Result.Label7 := NewLabel( Result.Form, 'Length mSec' ).SetPosition( 24, 244 ).SetSize( 81, 0 );
   {$IFDEF USE_NAMES}
    Result.Label7.Name := 'Label7';
   {$ENDIF}
    // Result.Button1.TabOrder = 0
    Result.Button1 := NewButton( Result.Form, 'Open' ).SetPosition( 8, 8 );
   {$IFDEF USE_NAMES}
    Result.Button1.Name := 'Button1';
   {$ENDIF}
    // Result.EditBox1.TabOrder = 1
    Result.EditBox1 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 88 );
   {$IFDEF USE_NAMES}
    Result.EditBox1.Name := 'EditBox1';
   {$ENDIF}
    // Result.EditBox2.TabOrder = 1
    Result.EditBox2 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 120 );
   {$IFDEF USE_NAMES}
    Result.EditBox2.Name := 'EditBox2';
   {$ENDIF}
    // Result.EditBox3.TabOrder = 1
    Result.EditBox3 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 152 );
   {$IFDEF USE_NAMES}
    Result.EditBox3.Name := 'EditBox3';
   {$ENDIF}
    // Result.EditBox4.TabOrder = 1
    Result.EditBox4 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 180 ).SetSize( 0, 24 );
   {$IFDEF USE_NAMES}
    Result.EditBox4.Name := 'EditBox4';
   {$ENDIF}
    // Result.EditBox5.TabOrder = 1
    Result.EditBox5 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 212 ).SetSize( 0, 24 );
   {$IFDEF USE_NAMES}
    Result.EditBox5.Name := 'EditBox5';
   {$ENDIF}
    // Result.EditBox6.TabOrder = 1
    Result.EditBox6 := NewEditBox( Result.Form, [  ] ).SetPosition( 115, 244 ).SetSize( 0, 24 );
   {$IFDEF USE_NAMES}
    Result.EditBox6.Name := 'EditBox6';
   {$ENDIF}
      Result.OpenSaveDialog1.WndOwner := Result.Form.GetWindowHandle;
      Result.Button1.OnClick := Result.Button1Click;
    Result.EditBox1.Color := clWindow;
    Result.EditBox2.Color := clWindow;
    Result.EditBox3.Color := clWindow;
    Result.EditBox4.Color := clWindow;
    Result.EditBox5.Color := clWindow;
    Result.EditBox6.Color := clWindow;
    Result.KOLForm1FormCreate( Result );

end;
{$ENDIF OldCode}

