if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor13" end
OnInit.trig("Raptor13", function(require)
    function Actions13()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS13))
    end

    --===========================================================================
    gg_trg_Raptor13 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor13, gg_rct_SS13RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor13, gg_rct_SS13LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor13, gg_rct_SS13TopDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor13, gg_rct_SS13BottomDebug)
    TriggerAddAction(gg_trg_Raptor13, Actions13)
end)
if Debug then Debug.endFile() end
