if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor8" end
OnInit.map("Raptor8", function(require)
    function Actions8()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS8))
    end

    --===========================================================================
    gg_trg_Raptor8 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor8, gg_rct_SS8RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor8, gg_rct_SS8LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor8, gg_rct_SS8BottomDebug)
    TriggerAddAction(gg_trg_Raptor8, Actions8)
end)
if Debug then Debug.endFile() end
