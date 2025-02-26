; AutoHotkey v2 Script to click at specified coordinates in a loop

; Should be done on this page: https://github.com/Just-Some-Plugins/AutoRepo/actions
; Currently set to deleted the 4th workflow in the list

; Press Ctrl+Delete to toggle the script on/off

; ====== User Configurable Variables ======
; Coordinates for clicks
coordOneX := 1857     ; First click (the 3 dots)
coordOneY := 604
coordTwoX := 1766     ; Second click (delete workflow)
coordTwoY := 667
coordThreeX := 1177   ; Third click (delete confirmation)
coordThreeY := 761

; Delay times (in milliseconds)
shortDelay := 500    ; 0.5 second delay between clicks
longDelay := 3000    ; 3 second delay before repeating

; ====== Internal Variables ======
isRunning := false   ; Toggle to track if the script is running
clickLoop := 0       ; Loop ID for the SetTimer

; ====== Hotkey Definition ======
^Delete::ToggleClickSequence()  ; Ctrl+Delete to toggle

; ====== Functions ======
ToggleClickSequence() {
    global isRunning, clickLoop
    
    if (isRunning) {
        ; Stop the loop
        isRunning := false
        ToolTip("Click sequence stopped")
        SetTimer(() => ToolTip(), -4000)  ; Hide tooltip after 4 seconds
    }
    else {
        ; Start the loop
        isRunning := true
        clickLoop := SetTimer(PerformClicks, 10)  ; Start immediately
        ToolTip("Click sequence started")
        SetTimer(() => ToolTip(), -4000)  ; Hide tooltip after 4 seconds
    }
}

PerformClicks() {
    global coordOneX, coordOneY
    global coordTwoX, coordTwoY
    global coordThreeX, coordThreeY
    global shortDelay, longDelay, clickLoop, isRunning

    ; Exit if the script is not running
    if (!isRunning) {
        return
    }
    
    ; First click (the 3 dots)
    Click(coordOneX, coordOneY)
    Sleep(shortDelay)
    
    ; Second click (delete workflow)
    Click(coordTwoX, coordTwoY)
    Sleep(shortDelay * 2) ; Longer delay, for the popup to appear
    
    ; Third click (delete confirmation)
    Click(coordThreeX, coordThreeY)
    Sleep(longDelay)
    
    ; Set the timer for the next cycle
    clickLoop := SetTimer(PerformClicks, 10)
}