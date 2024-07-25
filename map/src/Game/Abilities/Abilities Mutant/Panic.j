function Trig_Panic_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Panic_Actions takes nothing returns nothing 
    call SetUnitManaPercentBJ(GetSpellAbilityUnit(), 100) 
    call UnitRemoveAbilityBJ('A07H', GetSpellAbilityUnit()) 
    call UnitRemoveAbilityBJ('A07G', GetSpellAbilityUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_Panic takes nothing returns nothing 
    set gg_trg_Panic = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Panic, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Panic, Condition(function Trig_Panic_Conditions)) 
    call TriggerAddAction(gg_trg_Panic, function Trig_Panic_Actions) 
endfunction 

