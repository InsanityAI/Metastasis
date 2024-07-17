if Debug then Debug.beginFile "Game/Spaceships/SpaceshipsOutOfRectBugfix/Hunter9" end
OnInit.trig("Hunter9", function(require)
    function Actions9()
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_SS9))
    end

    --===========================================================================
    gg_trg_Hunter9 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Hunter9, gg_rct_SS9RightDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Hunter9, gg_rct_SS9LeftDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Hunter9, gg_rct_SS9TopDebug)
    TriggerRegisterEnterRectSimple(gg_trg_Hunter9, gg_rct_SS9BottomDebug)
    TriggerAddAction(gg_trg_Hunter9, Actions9)
end)
if Debug then Debug.endFile() end
