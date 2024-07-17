if Debug then Debug.beginFile "Game/RandomEvents/SolarIntensify" end
OnInit.map("SolarIntensify", function(require)
    function Trig_SolarIntensity_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[10] = true
        RemoveLocation(udg_TempPoint)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
        SetTimeOfDay(12)
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2567")
        udg_SunDamage = 6.00
    end

    --===========================================================================
    gg_trg_SolarIntensity = CreateTrigger()
    DisableTrigger(gg_trg_SolarIntensity)
    TriggerAddAction(gg_trg_SolarIntensity, Trig_SolarIntensity_Actions)
end)
if Debug then Debug.endFile() end
