function Trig_TaintedVendor_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A01T')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_TaintedVendor_Actions takes nothing returns nothing 
    call RemoveItemFromStockBJ('I004', GetSpellTargetUnit()) 
    call UnitAddAbilityBJ('A01U', GetSpellTargetUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_TaintedVendor takes nothing returns nothing 
    set gg_trg_TaintedVendor = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_TaintedVendor, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_TaintedVendor, Condition(function Trig_TaintedVendor_Conditions)) 
    call TriggerAddAction(gg_trg_TaintedVendor, function Trig_TaintedVendor_Actions) 
endfunction 

