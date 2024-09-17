#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input

; Check if the script is running with admin privileges
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

global mouseClickX := 1350
global mouseClickY := 780
global clickInterval := 50

global isClicking := false
global toggleStartTime := 0
global toggleDuration := 60000 ; 60 seconds

SetMouseDelay, -1
SetKeyDelay, -1

XButton1::
    isClicking := true
    SetTimer, PerformClick, %clickInterval%
return

XButton1 Up::
    isClicking := false
    SetTimer, PerformClick, Off
return

XButton2::
    isClicking := !isClicking
    if (isClicking)
    {
        toggleStartTime := A_TickCount
        SetTimer, PerformClick, %clickInterval%
        SetTimer, CheckToggleDuration, 1000 ; Check every second
    }
    else
    {
        SetTimer, PerformClick, Off
        SetTimer, CheckToggleDuration, Off
    }
return

PerformClick:
    Click, %mouseClickX%, %mouseClickY%
return

CheckToggleDuration:
    if (A_TickCount - toggleStartTime > toggleDuration)
    {
        isClicking := false
        SetTimer, PerformClick, Off
        SetTimer, CheckToggleDuration, Off
    }
return