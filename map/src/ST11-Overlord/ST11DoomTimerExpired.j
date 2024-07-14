function Trig_ST11DoomTimerExpired_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call DestroyTimerDialogBJ( udg_OverlordDeath_TimerWindow )
    call TriggerExecute(gg_trg_ST11DieNatural)
endfunction

//===========================================================================
function InitTrig_ST11DoomTimerExpired takes nothing returns nothing
    set gg_trg_ST11DoomTimerExpired = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_ST11DoomTimerExpired, udg_OverlordDeath_DestructionTimer )
    call TriggerAddAction( gg_trg_ST11DoomTimerExpired, function Trig_ST11DoomTimerExpired_Actions )
endfunction

