if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Albadar12" end
OnInit.map("Albadar12", function(require)
    function Actions12()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS12))
    end

    --===========================================================================
    gg_trg_Albadar12 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Albadar12, gg_rct_SS12RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Albadar12, gg_rct_SS12LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Albadar12, gg_rct_SS12TopDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Albadar12, gg_rct_SS12BottomDebug)
    TriggerAddAction(gg_trg_Albadar12, Actions12)
end)
if Debug then Debug.endFile() end
