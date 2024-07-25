function Trig_ST5AttackEnd_Actions takes nothing returns nothing 
    set udg_ST5_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST5) 
endfunction 

//=========================================================================== 
function InitTrig_ST5AttackEnd takes nothing returns nothing 
    set gg_trg_ST5AttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_ST5AttackEnd, udg_ST5_ResetAlarm) 
    call TriggerAddAction(gg_trg_ST5AttackEnd, function Trig_ST5AttackEnd_Actions) 
endfunction 

