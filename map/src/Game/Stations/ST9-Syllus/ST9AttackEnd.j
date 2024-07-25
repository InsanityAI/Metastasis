function Trig_ST9AttackEnd_Actions takes nothing returns nothing 
    set udg_ST9_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST9) 
endfunction 

//=========================================================================== 
function InitTrig_ST9AttackEnd takes nothing returns nothing 
    set gg_trg_ST9AttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_ST9AttackEnd, udg_ST9_ResetAlarm) 
    call TriggerAddAction(gg_trg_ST9AttackEnd, function Trig_ST9AttackEnd_Actions) 
endfunction 

