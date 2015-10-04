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
CoordMode, Mouse, Client

;Autohotkey scope rules are stupid and I'm in a hurry
global WindowOriginX := 0
global WindowOriginY := 0
global WindowEndX := 0
global WindowEndY := 0
global TopLeftX := 0
global TopLeftY := 0
global BottomRightX := 0
global BottomRightY := 0

^!m::main()

main() {
	InitMabiWindow()
	FindTopLeft()

}

InitMabiWindow() {
	SetTitleMatchMode, 2
	IfWinExist, Mabinogi
	{
		WinActivate
		WinGetPos,WindowOriginX,WindowOriginY,WindowEndX,WindowEndY
	}
}


FindTopLeft() {
	ImageSearch, TopLeftX, TopLeftY, WindowOriginX, WindowOriginY, WindowEndX, WindowEndY, *50 *Trans0x292929 img\topleft.bmp
	if(ErrorLevel == 2) {
		MsgBox, Couldn't Open %A_WorkingDir%\img\topleft.bmp
	} else if(ErrorLevel == 1) {
		MsgBox, Blacksmithing UI not found.
	} else {
		MouseMove TopLeftX, TopLeftY
		Sleep 120
		Click 
		MsgBox, Found at (%TopLeftX% %TopLeftY%)
	}
}
