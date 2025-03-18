; AutoHotkey v2 Script to click at specified coordinates in a loop

; Should be done on this page: https://github.com/Just-Some-Plugins/AutoRepo/actions
; Currently set to deleted the 2nd workflow in the list
; If you manually close the "deleted successfully" banner, reload the page, it breaks the Y

; Press Ctrl+Delete to toggle the script on/off

; ====== User Configurable Variables ======
; Coordinates for clicks
coordOneX := 1888    ; First click (the 3 dots)
coordOneY := 388
coordTwoX := 1869    ; Second click (delete workflow)
coordTwoY := 450
coordThreeX := 1431  ; Third click (delete confirmation)
coordThreeY := 762

; Delay times (in milliseconds)
shortDelay := 300    ; sub-second delay between clicks
longDelay := 2500    ; multi-second delay before repeating

; Height of the "deleted successfully" banner
bannerHeight := 60   ; Height of the banner in pixels

; Cloudflare settings to delete Pages Deployments (3rd one in the list)
; https://autorepo.justsome.site/pages
; coordOneX := 1926    ; First click (the 3 dots)
; coordOneY := 674
; coordTwoX := 1890    ; Second click (delete workflow)
; coordTwoY := 748
; coordThreeX := 1448  ; Third click (delete confirmation)
; coordThreeY := 833
; bannerHeight := 75   ; Height of the banner in pixels

; ====== Internal Variables ======
bannerAdded := false ; Flag to track if the banner has been accounted for
firstLoop := true    ; Flag to track the first loop
isRunning := false   ; Toggle to track if the script is running
clickLoop := 0       ; Loop ID for the SetTimer

; ====== Hotkey Definition ======
^Delete:: ToggleClickSequence()  ; Ctrl+Delete to toggle

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
    global bannerHeight, bannerAdded
    global shortDelay, longDelay
    global clickLoop, isRunning, firstLoop

    ; Exit if the script is not running
    if (!isRunning) {
        return
    }

    ; Add the "deleted successfully" banner into the Y coordinates
    if (!firstLoop && !bannerAdded) {
        coordOneY += bannerHeight
        coordTwoY += bannerHeight
        bannerAdded := true
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

    ; Manage the first-loop flag
    if (firstLoop) {
        firstLoop := false
    }
    ; Set the timer for the next cycle
    clickLoop := SetTimer(PerformClicks, 10)
}
