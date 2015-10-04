;
; AutoHotkey Version: 3
; Language:       English
; Platform:       Win9x/NT
; Author:         Anthony Agresta <me@anthonyagresta.com>
;
; Gobine, the Legendary Blacksmith
; This script is an attempt to automate Mabinogi's smithing mini-game.
; Best used with the game client's UI skin set to "Electric Gray (Opaque)". 
; 
; Usage:
;   Compile to a standalone EXE, and run Goibne.exe as admin.
;   Open the blacksmithing window
;   Choose a finishing option
;   Add finishing materials to the window
;   Click outside the Mabinogi window and press Ctrl-Alt-M
;   Wait. Smithing should proceed perfectly! (Should.) 
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Autohotkey scope rules are stupid and I'm in a hurry
global WindowOriginX := 0
global WindowOriginY := 0
global WindowEndX := 0
global WindowEndY := 0
global TopLeftX := 0
global TopLeftY := 0
global BottomRightX := 0
global BottomRightY := 0
global FoundPointX := 0
global FountPointY := 0

^!m::main()

main() {
	InitMabiWindow()
	ClickStart()
	Sleep 4000
	FindTopLeft()
	FindBottomRight()
	Loop, 5 {
		WaitForTheBarToBeGreen()
		ClickAnX()
	}
}

InitMabiWindow() {
	SetTitleMatchMode, 2
	IfWinExist, Mabinogi
	{
		WinActivate
		WinGetPos,,,WindowEndX,WindowEndY
		Sleep 400
	}
}

FindTopLeft() {
	ImageSearch, TopLeftX, TopLeftY, WindowOriginX, WindowOriginY, WindowEndX, WindowEndY, *100 *Trans0x292929 img\topleft.bmp
	if(ErrorLevel == 2) {
		MsgBox, Couldn't Open %A_WorkingDir%\img\topleft.bmp
	} else if(ErrorLevel == 1) {
		MsgBox, Blacksmithing UI TopLeft not found.
	} else {
		MouseMove TopLeftX, TopLeftY
		Sleep 120
	}
}

FindBottomRight() {
	ImageSearch, BottomRightX, BottomRightY, TopLeftX, TopLeftY, WindowEndX, WindowEndY, *100 *Trans0x212121 img\bottomright.bmp
	if(ErrorLevel == 2) {
		MsgBox, Couldn't Open %A_WorkingDir%\img\bottomright.bmp
	} else if(ErrorLevel == 1) {
		MsgBox, Blacksmithing UI BottomRight not found.
	} else {
		BottomRightX := BottomRightX + 9
		BottomRightY := BottomRightY + 9
		MouseMove BottomRightX, BottomRightY
		Sleep 120
	}	
}

ClickAnX() {
	FoundPointX := 0
	FoundPointY := 0
	ImageSearch, FoundPointX, FoundPointY, TopLeftX, TopLeftY, BottomRightX, BottomRightY, *Trans0x000000 img\x.bmp
	if(ErrorLevel == 2) {
		MsgBox, Couldn't Open %A_WorkingDir%\img\x.bmp
	} else if(ErrorLevel == 1) {
		MsgBox, Blacksmithing UI X Mark not found.
	} else {
		FoundPointX := FoundPointX + 5
		FoundPointY := FoundPointY + 5
		MouseMove FoundPointX, FoundPointY
		Sleep 120
		Click 
		Sleep 130
		MouseMove WindowOriginX, WindowOriginY
		Sleep 500
	}
}

ClickStart() {
	FoundPointX := 0
	FoundPointY := 0
	ImageSearch, FoundPointX, FoundPointY, WindowOriginX, WindowOriginY, WindowEndX, WindowEndY, img\start.bmp
	if(ErrorLevel == 2) {
		MsgBox, Couldn't Open %A_WorkingDir%\img\start.bmp
	} else if(ErrorLevel == 1) {
		MsgBox, Blacksmithing UI Start Button not found.
	} else {
		MouseMove FoundPointX, FoundPointY
		Sleep 120
		MouseMove FoundPointX, FoundPointY
		Click 
		Sleep 130
	}	
}

WaitForTheBarToBeGreen() {
	CheckPointX := TopLeftX + 162
	CheckPointY := TopLeftY + 221
	MouseMove, CheckPointX, CheckPointY
	Sleep 100
	MouseMove, 0, 30, 2, R
	Sleep 25
	MyPixelColor = 000000
	While, MyPixelColor != 0x61790D
	{
		Sleep 25
		PixelGetColor, MyPixelColor, CheckPointX, CheckPointY, Slow RGB
	}
}
