if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor3" end
OnInit.trig("Raptor3", function(require)
    function Actions3()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS3))
    end

    --===========================================================================
    gg_trg_Raptor3 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor3, gg_rct_SS3RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor3, gg_rct_SS3LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor3, gg_rct_SS3TopDebug)
    TriggerAddAction(gg_trg_Raptor3, Actions3)
end)
if Debug then Debug.endFile() end
