function Trig_FixHP_Actions takes nothing returns nothing
    call EnableUserUI( true )
endfunction

//===========================================================================
function InitTrig_FixHP takes nothing returns nothing
    set gg_trg_FixHP = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_FixHP, 2 )
    call TriggerAddAction( gg_trg_FixHP, function Trig_FixHP_Actions )
endfunction

