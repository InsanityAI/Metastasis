library HideAllies initializer init
    globals
        //internal
        private integer playerCount = GetBJMaxPlayers()
    endglobals

    private function HideFrame takes framehandle frame returns nothing
        call BlzFrameSetVisible(frame, false)
    endfunction

    private function HideAllies takes nothing returns nothing
        local integer index = 0
        local framehandle parentFrame = BlzGetFrameByName("AllianceDialog", 0)
        local framehandle frame

        call DestroyTimer(GetExpiredTimer())

        call BJDebugMsg("Got parent")
        call HideFrame(BlzGetFrameByName("AllianceTitle", 0))
        call HideFrame(BlzGetFrameByName("ResourceTradingTitle", 0))
        call HideFrame(BlzGetFrameByName("PlayersHeader", 0))
        call HideFrame(BlzGetFrameByName("AllyHeader", 0))
        call HideFrame(BlzGetFrameByName("VisionHeader", 0))
        call HideFrame(BlzGetFrameByName("UnitsHeader", 0))
        call HideFrame(BlzGetFrameByName("GoldHeader", 0))
        call HideFrame(BlzGetFrameByName("LumberHeader", 0))
        call BJDebugMsg("Got Headers")

        loop
            call BJDebugMsg("Loop " + I2S(index))
            exitwhen index >= playerCount
            call HideFrame(BlzGetFrameByName("AllianceSlot", index))
            call HideFrame(BlzGetFrameByName("ColorBackdrop", index))
            call HideFrame(BlzGetFrameByName("ColorBorder", index))
            call HideFrame(BlzGetFrameByName("PlayerNameLabel", index))
            call HideFrame(BlzGetFrameByName("AllyCheckBox", index))
            call HideFrame(BlzGetFrameByName("VisionCheckBox", index))
            call HideFrame(BlzGetFrameByName("UnitsCheckBox", index))
            call HideFrame(BlzGetFrameByName("GoldBackdrop", index))
            call HideFrame(BlzGetFrameByName("LumberBackdrop", index))
            call HideFrame(BlzGetFrameByName("GoldText", index))
            call HideFrame(BlzGetFrameByName("LumberText", index))
            set index = index + 1
        endloop

        call BJDebugMsg("Looped all players")
        call HideFrame(BlzGetFrameByName("AlliedVictoryCheckBox", 0))
        call HideFrame(BlzGetFrameByName("AlliedVictoryLabel", 0))
        call HideFrame(BlzGetFrameByName("AllianceAcceptButton", 0))
        
        call BJDebugMsg("Got bottom elements")
        set frame = BlzGetFrameByName("AllianceCancelButton", 0)
        call BlzFrameClearAllPoints(frame)
        call BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOM, parentFrame, FRAMEPOINT_BOTTOM, 0.00, 0.03)
        call BlzFrameSetText(frame, "Close")

        set frame = BlzCreateFrameByType("TEXT", "", parentFrame, "", 0)
        call BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, parentFrame, FRAMEPOINT_CENTER, 0.00, 0.00)
        call BlzFrameSetText(frame, "You tried")
        call BlzFrameSetTextAlignment(frame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetSize(frame, 0.10, 0.05)
        call BlzFrameSetScale(frame, 4)
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 0.00, false, function HideAllies)
    endfunction
endlibrary