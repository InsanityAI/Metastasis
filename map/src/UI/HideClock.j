library HideClock initializer init requires Timeout
    private function hideClock takes nothing returns nothing
        local framehandle thisframe = BlzFrameGetChild(BlzFrameGetChild(BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 5),0)
        call Timeout.complete()
        call BlzFrameSetVisible(thisframe, false)
        set thisframe = BlzCreateFrameByType("BACKDROP", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
        call BlzFrameSetTexture(thisframe, "UI\\Console\\Human\\HumanUITile-TimeIndicatorFrame.blp", 0, true)
        call BlzFrameSetAbsPoint( thisframe, FRAMEPOINT_TOP, 0.4, 0.6)
        call BlzFrameSetSize( thisframe, 0.128, 0.045)
    endfunction

    private function init takes nothing returns nothing
        call Timeout.start(0.00, false, function hideClock)
    endfunction
endlibrary