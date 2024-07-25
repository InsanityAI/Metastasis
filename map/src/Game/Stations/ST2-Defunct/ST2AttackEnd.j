function Trig_ST2AttackEnd_Actions takes nothing returns nothing 
    set udg_ST2_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST2) 
endfunction 

//===========================================================================  
function InitTrig_ST2AttackEnd takes nothing returns nothing 
    set gg_trg_ST2AttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_ST2AttackEnd, udg_ST2_ResetAlarm) 
    call TriggerAddAction(gg_trg_ST2AttackEnd, function Trig_ST2AttackEnd_Actions) 
endfunction 

