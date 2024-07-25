function Trig_ST8AttackEnd_Actions takes nothing returns nothing 
    set udg_ST8_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST8) 
endfunction 

//=========================================================================== 
function InitTrig_ST8AttackEnd takes nothing returns nothing 
    set gg_trg_ST8AttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_ST8AttackEnd, udg_ST8_ResetAlarm) 
    call TriggerAddAction(gg_trg_ST8AttackEnd, function Trig_ST8AttackEnd_Actions) 
endfunction 

