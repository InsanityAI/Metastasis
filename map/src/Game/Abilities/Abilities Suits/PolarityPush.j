function Trig_PolarityPush_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A0A4')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PolarityPush_Actions takes nothing returns nothing 
    call UnitAddAbilityBJ('A097', GetTriggerUnit()) 
    call UnitRemoveAbilityBJ('A0A4', GetTriggerUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_PolarityPush takes nothing returns nothing 
    set gg_trg_PolarityPush = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PolarityPush, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_PolarityPush, Condition(function Trig_PolarityPush_Conditions)) 
    call TriggerAddAction(gg_trg_PolarityPush, function Trig_PolarityPush_Actions) 
endfunction 

