; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.


#t::
id := WinExist("A")
MsgBox % id
return

;<#Tab::AltTab

;IME旙り替え
#Space::!`
<!Space::!`

;IME.ahkからコピペ
IME_SET(setSts, WinTitle="")
;-----------------------------------------------------------
; IMEの暎態をセット
;    対旱戳 AHK v1.0.34以捫
;   SetSts  : 1:ON 0:OFF
;   WinTitle: 対旱Window (敲略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
{
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_SETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x006,setSts,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

sc079:: IME_SET(0) ;変換   -> IME OFF

sc07B up:: IME_SET(1) ;無変換 -> IME ON
;sc07B:: ;muhenkan
;  KeyWait, sc07B, U
;  KeyWait, sc07B, D T0.2 ;wait 0.2sec
;  If (ErrorLevel <> 0)
;  {
;    Send, {sc07B}
;  }
;  else
;  {
;    IME_SET(1)
;  }
;  Return

sc07B & h:: Send, {Left}
sc07B & j:: Send, {Down}
sc07B & k:: Send, {Up}
sc07B & l:: Send, {Right}

;CapsLock
sc03A & a:: Send ^{a}
sc03A & b:: Send {BS}
sc03A & c:: Send ^{c}
sc03A & d:: Send {Del}
sc03A & e:: Send {End}
sc03A & f:: Send ^{f}
sc03A & g:: Send ^{g}
sc03A & h:: Send, {Left}
sc03A & i:: Send, ^{i}
sc03A & j:: Send, {Down}
sc03A & k:: Send, {Up}
sc03A & l:: Send, {Right}
sc03A & m:: Send, ^{m}
sc03A & n:: Send, ^{n}
sc03A & o:: Send, ^{j}
sc03A & p:: Send, ^{p}
sc03A & q:: Send, ^{q}
sc03A & r:: Send, ^{r}
sc03A & s:: Send, ^{s}
sc03A & t:: Send, ^{t}
sc03A & u:: Send, ^{u}
sc03A & v:: Send, ^{v}
sc03A & w:: Send, ^{w}
sc03A & x:: Send, ^{x}
sc03A & y:: Send, ^{y}
sc03A & z:: Send, ^{z}
sc03A & 0:: Send, {Home}
sc03A & ':: Send, ^{'}
;sc03A & Space:: !`

;JIS->英語配列化対応
 sc07D:: \
+sc07d:: |
 sc073:: \ 
+sc073:: _


;Kill Ins
 Ins:: Return
!Ins:: Send, {Ins} ;Use with Alt

;Kill F1 on Excel
#IfWinActive ahk_exe EXCEL.EXE
   F1:: Return
  +F1:: Send, {F1} ;Use with Shift
#IfWinActive


;Like vim key binding
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.378734a
  ^n::
    Send {Down}
  return

  ^p::
    Send {Up}
  return

  ^k::
    Send {Enter}
  return
#IfWinActive

;Add/Remove indent mark
^>::
  Send,^c
  Clipwait,2
  Clipboard := RegExReplace(Clipboard, "m)^>", ">>")
  Clipboard := RegExReplace(Clipboard, "m)^(?!>)", "> ")
  lines := StrSplit(Clipboard, "`r`n")
  numOfLines := lines.MaxIndex() - 1
  Send ^v
  ;SetKeyDelay, 0
  Send {Up %numOfLines%}
  Send +{Down %numOfLines%}
  lines :=
return

^<::
  Send,^c
  Clipwait,2
  Clipboard := RegExReplace(Clipboard, "m)^>\s?(.*)", "$1")
  lines := StrSplit(Clipboard, "`r`n")
  numOfLines := lines.MaxIndex() - 1
  Send ^v
  ;SetKeyDelay, 0
  Send {Up %numOfLines%}
  Send +{Down %numOfLines%}
  lines :=
return

;hotstring
;yyyymmdd
::`\ymd::
IfEqual, A_EndChar, `n
  Clipboard = %A_YYYY%%A_MM%%A_DD%
Else
  Clipboard = %A_YYYY%%A_EndChar%%A_MM%%A_EndChar%%A_DD%
Send,^v
return

::`\ym::
IfEqual, A_EndChar, `n
  Clipboard = %A_YYYY%%A_MM%
Else
  Clipboard = %A_YYYY%%A_EndChar%%A_MM%
Send,^v
return

; mail address
::`\mail::m_shishima@cec-ltd.co.jp

; 矢印
::zh::←
::zj::↓
::zk::↑
::zl::→

; チャタリング対策
; Enter::
;   Input, outkey, I T0.01 L1, {Enter}
;   ; OutputDebug, % ErrorLevel
;   If(ErrorLevel == "EndKey:Enter"){
;     OutputDebug, Canceled!
;   }
;   Send, {Enter}
;   return 

;; This script runs Explorer++ on Win+E.
;; The Explorer++ executable must be in the same directory as this script file.
;
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#SingleInstance force ; Only one copy of this script should run at a time.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;
;#e::
;try {
;    Run %A_ScriptDir%\Explorer++.exe
;} catch e {
;    MsgBox Couldn't run Explorer++.`nPlease make sure it's in the same directory as this script (%A_ScriptDir%).
;}
;return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

