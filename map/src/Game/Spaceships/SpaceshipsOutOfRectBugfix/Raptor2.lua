if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor2" end
OnInit.trig("Raptor2", function(require)
    function Actions2()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS2))
    end

    --===========================================================================
    gg_trg_Raptor2 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor2, gg_rct_SS2RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor2, gg_rct_SS2LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor2, gg_rct_SS2BottomDebug)
    TriggerAddAction(gg_trg_Raptor2, Actions2)
end)
if Debug then Debug.endFile() end
