if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Obda10" end
OnInit.trig("Obda10", function(require)
    function Actions10()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS10))
    end

    --===========================================================================
    gg_trg_Obda10 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Obda10, gg_rct_SS10RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda10, gg_rct_SS10LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda10, gg_rct_SS10TopDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda10, gg_rct_SS10BottomDebug)
    TriggerAddAction(gg_trg_Obda10, Actions10)
end)
if Debug then Debug.endFile() end
