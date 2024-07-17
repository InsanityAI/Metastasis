if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor1" end
OnInit.trig("Raptor1", function(require)
    function Actions1()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS1))
    end

    --===========================================================================
    gg_trg_Raptor1 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor1, gg_rct_SS1RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor1, gg_rct_SS1LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor1, gg_rct_SS1TopDebug)
    TriggerAddAction(gg_trg_Raptor1, Actions1)
end)
if Debug then Debug.endFile() end
