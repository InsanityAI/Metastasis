library HideAllies initializer init 
    globals 
        //internal 
        private integer playerCount = GetBJMaxPlayers() 
    endglobals 

    private function HideFrame takes framehandle frame returns nothing 
        call BlzFrameSetVisible(frame, false) 
    endfunction 

    private function safe_get_frame takes string name, integer pos returns framehandle 
        local framehandle frame = BlzGetFrameByName(name, pos) 
        if frame == null then 
            call Location(0, 0) //Intentionally leak a handle because someone does not have this frame         
            //This should help prevent desyncs and replay errors         
        endif 
        return frame 
    endfunction 

    private function HideAllies takes nothing returns nothing 
        local integer index = 0 
        local framehandle parentFrame = safe_get_frame("AllianceDialog", 0) 
        local framehandle frame 
        call DestroyTimer(GetExpiredTimer()) 
        call HideFrame(safe_get_frame("AllianceTitle", 0)) 
        call HideFrame(safe_get_frame("ResourceTradingTitle", 0)) 
        call HideFrame(safe_get_frame("PlayersHeader", 0)) 
        call HideFrame(safe_get_frame("AllyHeader", 0)) 
        call HideFrame(safe_get_frame("VisionHeader", 0)) 
        call HideFrame(safe_get_frame("UnitsHeader", 0)) 
        call HideFrame(safe_get_frame("GoldHeader", 0)) 
        call HideFrame(safe_get_frame("LumberHeader", 0)) 
        loop 
            exitwhen index >= playerCount 
            call HideFrame(safe_get_frame("AllianceSlot", index)) 
            call HideFrame(safe_get_frame("ColorBackdrop", index)) 
            call HideFrame(safe_get_frame("ColorBorder", index)) 
            call HideFrame(safe_get_frame("PlayerNameLabel", index)) 
            call HideFrame(safe_get_frame("AllyCheckBox", index)) 
            call HideFrame(safe_get_frame("VisionCheckBox", index)) 
            call HideFrame(safe_get_frame("UnitsCheckBox", index)) 
            call HideFrame(safe_get_frame("GoldBackdrop", index)) 
            call HideFrame(safe_get_frame("LumberBackdrop", index)) 
            call HideFrame(safe_get_frame("GoldText", index)) 
            call HideFrame(safe_get_frame("LumberText", index)) 
            set index = index + 1 
        endloop 
        call HideFrame(safe_get_frame("AlliedVictoryCheckBox", 0)) 
        call HideFrame(safe_get_frame("AlliedVictoryLabel", 0)) 
        call HideFrame(safe_get_frame("AllianceAcceptButton", 0)) 

        // call HideFrame(safe_get_frame("UpperButtonBarAlliesButton", 0))

        set frame = safe_get_frame("AllianceCancelButton", 0) 
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