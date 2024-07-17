if Debug then Debug.beginFile "Game/ApocalypseSys/ApocalypseSpawn" end
OnInit.map("ApocalypseSpawn", function(require)
    function Trig_ApocalypseSpawn_Actions()
        -- 50% for each endgame
        udg_TempInt = GetRandomInt(1, 2)
        TriggerExecute(udg_Apocalypse_Trigger[udg_TempInt])
        -- Disable random events (you can imagine why -_-)
        DestroyTrigger(gg_trg_RandomEventsTimer)
    end

    --===========================================================================
    gg_trg_ApocalypseSpawn = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_ApocalypseSpawn, GetRandomReal(2520.00, 2640.00))
    TriggerAddAction(gg_trg_ApocalypseSpawn, Trig_ApocalypseSpawn_Actions)
end)
if Debug then Debug.endFile() end
