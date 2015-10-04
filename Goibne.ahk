;
; AutoHotkey Version: 3
; Language:       English
; Platform:       Win9x/NT
; Author:         Anthony Agresta <me@anthonyagresta.com>
;
; Gobine, the Legendary Blacksmith
; This script is an attempt to automate Mabinogi's smithing mini-game.
; 
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, Pixel, Client

TopLeftX := 0
TopLeftY := 0
BottomRightX := 0
BottomRightY := 0

^!m::main()

main() {
	SetTitleMatchMode, 2
	IfWinExist, Mabinogi
	{
		WinActivate
	} Else{
		MsgBox, Nope
	}
}