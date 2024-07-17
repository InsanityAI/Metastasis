if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Raptor5" end
OnInit.map("Raptor5", function(require)
    function Actions5()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS5))
    end

    --===========================================================================
    gg_trg_Raptor5 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Raptor5, gg_rct_SS5RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor5, gg_rct_SS5LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Raptor5, gg_rct_SS5TopDebug)
    TriggerAddAction(gg_trg_Raptor5, Actions5)
end)
if Debug then Debug.endFile() end
