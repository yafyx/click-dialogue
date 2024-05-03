#SingleInstance Force

; Check if the script is running with admin privileges
if not A_IsAdmin
    ; If not, try to rerun the script with admin privileges
    Run *RunAs "%A_ScriptFullPath%"

#MaxThreadsPerHotkey, 2
SetDefaultMouseSpeed, 0
SetBatchLines, -1

; Define constants for mouse click coordinates and sleep duration
mouseClickX := 1350
mouseClickY := 780
sleepDuration := 10

; Function to get the current time
GetCurrentTime() {
    return A_TickCount
}

XButton1::
    ; Loop while XButton1 is pressed
    while GetKeyState("XButton1", "P")
    {
        ; Perform a left mouse click at the specified coordinates
        MouseClick, left, mouseClickX, mouseClickY
        ; Pause execution for a short duration
        sleep, sleepDuration
    }
return

XButton2::
    ; Toggle the state of isButtonPressed
    isButtonPressed := !isButtonPressed
    startTime := GetCurrentTime()
    ; Loop while isButtonPressed is true and less than 60 seconds have passed
    while (isButtonPressed && GetCurrentTime() - startTime <= 60000)
    {
        MouseClick, left, mouseClickX, mouseClickY
        sleep, sleepDuration
    }
    ; Reset the state of isButtonPressed
    isButtonPressed := false
return