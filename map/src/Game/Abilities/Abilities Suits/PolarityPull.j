function Trig_PolarityPull_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A097')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PolarityPull_Actions takes nothing returns nothing 
    call UnitAddAbilityBJ('A0A4', GetTriggerUnit()) 
    call UnitRemoveAbilityBJ('A097', GetTriggerUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_PolarityPull takes nothing returns nothing 
    set gg_trg_PolarityPull = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PolarityPull, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_PolarityPull, Condition(function Trig_PolarityPull_Conditions)) 
    call TriggerAddAction(gg_trg_PolarityPull, function Trig_PolarityPull_Actions) 
endfunction 

