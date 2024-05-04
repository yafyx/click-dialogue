#SingleInstance Force

; Check if the script is running with admin privileges
if not A_IsAdmin
    ; If not, try to rerun the script with admin privileges
    Run *RunAs "%A_ScriptFullPath%"

SetDefaultMouseSpeed, 0
SetBatchLines, -1

; Define constants for mouse click coordinates and sleep duration
mouseClickX := 1350
mouseClickY := 780
sleepDuration := 50

; Function to get the current time
GetCurrentTime() {
    return A_TickCount
}

XButton1::
    ; Start clicking when XButton1 is pressed
    SetTimer, ClickLoop, %sleepDuration%
return

XButton1 Up::
    ; Stop clicking when XButton1 is released
    SetTimer, ClickLoop, Off
return

ClickLoop:
    ; Perform a left mouse click at the specified coordinates
    MouseClick, left, mouseClickX, mouseClickY
return

XButton2::
    ; Toggle the state of isButtonPressed
    isButtonPressed := !isButtonPressed
    startTime := GetCurrentTime()
    ; Start clicking when XButton2 is pressed and less than 60 seconds have passed
    if (isButtonPressed && GetCurrentTime() - startTime <= 60000)
        SetTimer, ClickLoop, %sleepDuration%
    else
        SetTimer, ClickLoop, Off
return