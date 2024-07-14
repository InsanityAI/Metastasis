function Trig_ST3AttackEnd_Actions takes nothing returns nothing
    set udg_ST3_TakingDamage = false
    call SetStackedSoundBJ( false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST3 )
endfunction

//===========================================================================
function InitTrig_ST3AttackEnd takes nothing returns nothing
    set gg_trg_ST3AttackEnd = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_ST3AttackEnd, udg_ST3_ResetAlarm )
    call TriggerAddAction( gg_trg_ST3AttackEnd, function Trig_ST3AttackEnd_Actions )
endfunction

