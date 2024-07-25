function Trig_SlyTentacles_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A044')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlyTentacles_Actions takes nothing returns nothing 
    set udg_TempInt = GetRandomInt(1, 6) 
    call UnitAddItemSwapped(UnitItemInSlotBJ(GetSpellTargetUnit(), udg_TempInt), GetSpellAbilityUnit()) 
endfunction 

//=========================================================================== 
function InitTrig_SlyTentacles takes nothing returns nothing 
    set gg_trg_SlyTentacles = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SlyTentacles, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_SlyTentacles, Condition(function Trig_SlyTentacles_Conditions)) 
    call TriggerAddAction(gg_trg_SlyTentacles, function Trig_SlyTentacles_Actions) 
endfunction 

