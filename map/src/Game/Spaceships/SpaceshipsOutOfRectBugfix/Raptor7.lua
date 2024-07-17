if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor7" end
OnInit.trig("Raptor7", function(require)
    function Actions7()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS7))
    end

    --===========================================================================
    gg_trg_Raptor7 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor7, gg_rct_SS7RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor7, gg_rct_SS7LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor7, gg_rct_SS7TopDebug)
    TriggerAddAction(gg_trg_Raptor7, Actions7)
end)
if Debug then Debug.endFile() end
