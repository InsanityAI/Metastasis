if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor6" end
OnInit.map("Raptor6", function(require)
    function Actions6()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS6))
    end

    --===========================================================================
    gg_trg_Raptor6 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor6, gg_rct_SS6RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor6, gg_rct_SS6LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor6, gg_rct_SS6BottomDebug)
    TriggerAddAction(gg_trg_Raptor6, Actions6)
end)
if Debug then Debug.endFile() end
