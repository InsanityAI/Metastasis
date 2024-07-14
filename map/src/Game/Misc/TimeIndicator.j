function Trig_TimeIndicator_Func002A takes nothing returns nothing
    call AdjustPlayerStateBJ( 1, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD )
endfunction

function Trig_TimeIndicator_Actions takes nothing returns nothing
    call ForForce( GetPlayersAll(), function Trig_TimeIndicator_Func002A )
endfunction

//===========================================================================
function InitTrig_TimeIndicator takes nothing returns nothing
    set gg_trg_TimeIndicator = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_TimeIndicator, 60.00 )
    call TriggerAddAction( gg_trg_TimeIndicator, function Trig_TimeIndicator_Actions )
endfunction

