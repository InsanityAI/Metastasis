function Trig_WinOn_Actions takes nothing returns nothing
    // If a person leaves before game really start, buggy things can cause instant victory. Tis terrible.
    call EnableTrigger( gg_trg_WinCheck )
       call DestroyTrigger( GetTriggeringTrigger() )
endfunction

//===========================================================================
function InitTrig_WinOn takes nothing returns nothing
    set gg_trg_WinOn = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_WinOn, 10.00 )
    call TriggerAddAction( gg_trg_WinOn, function Trig_WinOn_Actions )
endfunction

