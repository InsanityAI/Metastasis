function Trig_ST1AttackEnd_Actions takes nothing returns nothing
    set udg_ST1_TakingDamage = false
    call SetStackedSoundBJ( false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST1 )
endfunction

//===========================================================================
function InitTrig_ST1AttackEnd takes nothing returns nothing
    set gg_trg_ST1AttackEnd = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_ST1AttackEnd, udg_ST1_ResetAlarm )
    call TriggerAddAction( gg_trg_ST1AttackEnd, function Trig_ST1AttackEnd_Actions )
endfunction

