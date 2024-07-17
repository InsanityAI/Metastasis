if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor4" end
OnInit.trig("Raptor4", function(require)
    function Actions4()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS4))
    end

    --===========================================================================
    gg_trg_Raptor4 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor4, gg_rct_SS4RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor4, gg_rct_SS4LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor4, gg_rct_SS4BottomDebug)
    TriggerAddAction(gg_trg_Raptor4, Actions4)
end)
if Debug then Debug.endFile() end
