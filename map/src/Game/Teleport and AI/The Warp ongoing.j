function Trig_The_Warp_ongoing_Actions takes nothing returns nothing 
    set udg_Warp7 = 1 
    loop 
        exitwhen udg_Warp7 > 7 
        set udg_Warp_Effect = GetRandomLocInRect(gg_rct_Warp) 
        call AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl") 
        call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
        call AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl") 
        call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
        call AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl") 
        call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
        call RemoveLocation(udg_Warp_Effect) 
        set udg_Warp7 = udg_Warp7 + 1 
    endloop 
endfunction 

//=========================================================================== 
function InitTrig_The_Warp_ongoing takes nothing returns nothing 
    set gg_trg_The_Warp_ongoing = CreateTrigger() 
    call DisableTrigger(gg_trg_The_Warp_ongoing) 
    call TriggerRegisterTimerEventPeriodic(gg_trg_The_Warp_ongoing, 0.50) 
    call TriggerAddAction(gg_trg_The_Warp_ongoing, function Trig_The_Warp_ongoing_Actions) 
endfunction 

