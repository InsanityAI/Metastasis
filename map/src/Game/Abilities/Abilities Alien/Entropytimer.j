function Trig_Entropytimer_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A03M')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Entropytimer_Actions takes nothing returns nothing 
    call UnitApplyTimedLifeBJ(60.00, 'BTLF', GetLastCreatedUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_Entropytimer takes nothing returns nothing 
    set gg_trg_Entropytimer = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Entropytimer, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Entropytimer, Condition(function Trig_Entropytimer_Conditions)) 
    call TriggerAddAction(gg_trg_Entropytimer, function Trig_Entropytimer_Actions) 
endfunction 

