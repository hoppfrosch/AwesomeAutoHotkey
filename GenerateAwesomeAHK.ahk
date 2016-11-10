;
; AutoHotkey Version: 1.1.24.00
; Dev Platform:   Windows 7 Ultimate x64
; Author:         hoppfrosch  | hoppfrosch@ahkscript.org
; Date:           2016/06/16
; Description: Generate awesomeAHK-list from INI-Files
#NoEnv
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
;<<<<<<<<  HEADER END  >>>>>>>>>

#include <AwesomeJSON>
#include <ObjTree>

; To create an ini object,
aE := new AwesomeJSON( A_ScriptDir "\JSONRepo\LongHotkeys.json", 1)

WinWaitClose % "ahk_id " ObjTree(aE, "Current JSON")
