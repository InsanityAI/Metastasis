function Trig_ST10AttackEnd_Actions takes nothing returns nothing 
    set udg_ST10_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_ST10) 
endfunction 

//=========================================================================== 
function InitTrig_ST10AttackEnd takes nothing returns nothing 
    set gg_trg_ST10AttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_ST10AttackEnd, udg_ST10_ResetAlarm) 
    call TriggerAddAction(gg_trg_ST10AttackEnd, function Trig_ST10AttackEnd_Actions) 
endfunction 

