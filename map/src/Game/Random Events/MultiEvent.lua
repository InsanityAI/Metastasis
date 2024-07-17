if Debug then Debug.beginFile "Game/RandomEvents/MultiEvent" end
OnInit.trig("MultiEvent", function(require)
    function Trig_MultiEvent_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[14] = true
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4145")
        TriggerSleepAction(GetRandomReal(15.00, 30.00))
        TriggerExecute(gg_trg_RandomEventsTimer)
        TriggerSleepAction(GetRandomReal(15.00, 30.00))
        TriggerExecute(gg_trg_RandomEventsTimer)
        TriggerSleepAction(GetRandomReal(15.00, 30.00))
        TriggerExecute(gg_trg_RandomEventsTimer)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(240.00, 600.00))
    end

    --===========================================================================
    gg_trg_MultiEvent = CreateTrigger()
    DisableTrigger(gg_trg_MultiEvent)
    TriggerAddAction(gg_trg_MultiEvent, Trig_MultiEvent_Actions)
end)
if Debug then Debug.endFile() end
