function Trig_ApocalypseSpawn_Actions takes nothing returns nothing
    // 50% for each endgame
    set udg_TempInt = GetRandomInt(1, 2)
    call TriggerExecute( udg_Apocalypse_Trigger[udg_TempInt] )
    // Disable random events (you can imagine why -_-)
    call DestroyTrigger(gg_trg_RandomEventsTimer)
endfunction

//===========================================================================
function InitTrig_ApocalypseSpawn takes nothing returns nothing
    set gg_trg_ApocalypseSpawn = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_ApocalypseSpawn, GetRandomReal(2520.00, 2640.00) )
    call TriggerAddAction( gg_trg_ApocalypseSpawn, function Trig_ApocalypseSpawn_Actions )
endfunction

