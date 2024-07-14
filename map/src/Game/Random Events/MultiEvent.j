function Trig_MultiEvent_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[14] = true
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4145" )
    call TriggerSleepAction( GetRandomReal(15.00, 30.00) )
    call TriggerExecute( gg_trg_RandomEventsTimer )
    call TriggerSleepAction( GetRandomReal(15.00, 30.00) )
    call TriggerExecute( gg_trg_RandomEventsTimer )
    call TriggerSleepAction( GetRandomReal(15.00, 30.00) )
    call TriggerExecute( gg_trg_RandomEventsTimer )
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(240.00, 600.00) )
endfunction

//===========================================================================
function InitTrig_MultiEvent takes nothing returns nothing
    set gg_trg_MultiEvent = CreateTrigger(  )
    call DisableTrigger( gg_trg_MultiEvent )
    call TriggerAddAction( gg_trg_MultiEvent, function Trig_MultiEvent_Actions )
endfunction

