if Debug then Debug.beginFile "Game/Misc/RemindTKBad" end
OnInit.trigg("RemindTKBad", function(require)
    function Trig_RemindTKBad_Actions()
        DisplayTextToForce(GetPlayersAll(), ("|cff008040Never forget, TeamKilling favours the Mutant and Alien!"))
        DestroyTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_RemindTKBad = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_RemindTKBad, 60.00)
    TriggerAddAction(gg_trg_RemindTKBad, Trig_RemindTKBad_Actions)
end)
if Debug then Debug.endFile() end
