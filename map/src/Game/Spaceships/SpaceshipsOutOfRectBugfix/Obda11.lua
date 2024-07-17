if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Obda11" end
OnInit.map("Obda11", function(require)
    function Actions11()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS11))
    end

    --===========================================================================
    gg_trg_Obda11 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Obda11, gg_rct_SS11RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda11, gg_rct_SS11LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda11, gg_rct_SS11TopDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Obda11, gg_rct_SS11BottomDebug)
    TriggerAddAction(gg_trg_Obda11, Actions11)
end)
if Debug then Debug.endFile() end
