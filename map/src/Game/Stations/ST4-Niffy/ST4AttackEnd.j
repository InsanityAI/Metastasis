function Trig_ST4AttackEnd_Actions takes nothing returns nothing
    set udg_ST4_TakingDamage = false
    call SetStackedSoundBJ( false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST4S2 )
endfunction

//===========================================================================
function InitTrig_ST4AttackEnd takes nothing returns nothing
    set gg_trg_ST4AttackEnd = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_ST4AttackEnd, udg_ST4_ResetAlarm )
    call TriggerAddAction( gg_trg_ST4AttackEnd, function Trig_ST4AttackEnd_Actions )
endfunction

