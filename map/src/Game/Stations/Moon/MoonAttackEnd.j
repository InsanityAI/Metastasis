function Trig_MoonAttackEnd_Actions takes nothing returns nothing 
    set udg_Moon_TakingDamage = false 
    call SetStackedSoundBJ(false, gg_snd_WWII_submarine_dive_klaxon, gg_rct_MoonRect) 
endfunction 

//=========================================================================== 
function InitTrig_MoonAttackEnd takes nothing returns nothing 
    set gg_trg_MoonAttackEnd = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_MoonAttackEnd, udg_Moon_ResetAlarm) 
    call TriggerAddAction(gg_trg_MoonAttackEnd, function Trig_MoonAttackEnd_Actions) 
endfunction 

