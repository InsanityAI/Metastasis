function Trig_Gargoyle_Actions takes nothing returns nothing
    call PauseUnitBJ( true, gg_unit_u000_0150 )
endfunction

//===========================================================================
function InitTrig_Gargoyle takes nothing returns nothing
    set gg_trg_Gargoyle = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Gargoyle, 0.00 )
    call TriggerAddAction( gg_trg_Gargoyle, function Trig_Gargoyle_Actions )
endfunction

