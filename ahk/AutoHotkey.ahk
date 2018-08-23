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

;#Persistent
;  DMS_Init() ; IME状態表示の初期化
;return

;#Include, disp_ime_status.ahk

;#t::
;id := WinExist("A")
;MsgBox % id
;return


;#z::Run www.autohotkey.com
;#e::
;IfWinActive ahk_class CabinetWClass
;  Send ^h
;else
;  Send #1
;return

<#Tab::AltTab

#Space::sc029
<!Space::sc029
sc07B & Space::Send, {sc029}

;Esc押下時はIME解除（Vimモード用）
$Esc::
  Send,{Esc}
  Sleep 1
  IME_SET(0)
  Return

$^[::
  Send,{^[]}
  Sleep 1
  IME_SET(0)
  Return

;#~#RCtrl::Send {CapsLock}
;#CapsLock::Send {Ctrl}
;~Pause::IME_SET(0)

;~LButton::       
;  DMS_Click() ; クリックフック
;return


;^F8::
;  DMS_Reload() ; Ctrl+F8で、iniファイルのリロード
;return


^!n::
IfWinExist Untitled - Notepad
  WinActivate
else
  Run Notepad
return


;;;クリップボード履歴;;;
;Ctrl 2回でクリップボード履歴を呼び出し
;~Ctrl::
;KeyWait, Ctrl, T0.200;放されるのを待つ。好みに合わせて適当に変える。
;DetectHiddenWindows,On
;If ErrorLevel = 0
;{
;  KeyWait, Ctrl, D T0.200;押されるのを待つ。好みに合わせて適当に変える。
;  If ErrorLevel = 0
;  {
;    PostMessage 786,0,0,,ahk_class WindowsForms10.Window.8.app.0.378734a ;WM_HOTKEYをポストの方がいい。
;    KeyWait, Ctrl
;    return
;  }
;}
;return

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

;無変換/変換+hjkl
#h::
sc07B & h::
sc079 & h::
Send {left}
Return

#j::
sc07B & j::
sc079 & j::
Send {down}
Return

#k::
sc07B & k::
sc079 & k::
Send {up}
Return

#l::
sc07B & l::
sc079 & l::
Send {right}
Return


;;;選択文字列の行頭に引用符を追加/削除;;;
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


#UseHook

;; ひらカタ、無変換殺す
;vkF2sc070::
;vk1Dsc07B::
;  return
;; 変換:space
;sc079::SPACE

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; 1段目
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VKF4::Send,{``}    ;         半角/全角     -> `
; +VKF4::Send,{~}    ; Shift + 半角/全角     -> ~
; +2::Send,{@}       ; Shift + 2         ["] -> @
; +6::Send,{^}       ; Shift + 6         [&] -> ^
; +7::Send,{&}       ; Shift + 7         ['] -> &
; +8::Send,{*}       ; Shift + 8         [(] -> *
; +9::Send,{(}       ; Shift + 9         [)] -> (
; +0::Send,{)}       ; Shift + 0         [ ] -> )
; +-::Send,{_}       ; Shift + -         [=] -> _
; ^::Send,{=}        ;                   [^] -> =
; +^::Send,{+}       ; Shift + ^         [~] -> +
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; 2段目
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; @::[              ;                   [@] -> [
; +@::{             ; Shift + @         [`] -> {
; [::]              ;                   [[] -> ]
; +[::Send,{}}      ; Shift + [         [{] -> }
;;ENTER::\
;;+ENTER::|
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; 3段目
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; +;::Send,{:}      ; Shift + ;         [+] -> ;
; :::Send,{'}       ;                   [:] -> '
; *::Send,{"}       ; Shift + :         [*] -> "
; ]::ENTER          ;                   []] -> ENTER


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if    (WinActive(WinTitle))    {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;    DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}