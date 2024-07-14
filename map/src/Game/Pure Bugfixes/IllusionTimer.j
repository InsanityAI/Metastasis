function Trig_IllusionTimer_Actions takes nothing returns nothing
    set udg_IllusionSuitBoolean = false
endfunction

//===========================================================================
function InitTrig_IllusionTimer takes nothing returns nothing
    set gg_trg_IllusionTimer = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_IllusionTimer, udg_IllusionSuitTimer )
    call TriggerAddAction( gg_trg_IllusionTimer, function Trig_IllusionTimer_Actions )
endfunction

