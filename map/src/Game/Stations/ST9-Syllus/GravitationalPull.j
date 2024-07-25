function Trig_GravitationalPull_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07Z')) then 
        return false 
    endif 
    if(not(GetUnitAbilityLevelSwapped('A079', GetSpellTargetUnit()) == 0)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GravitationalPull_Actions takes nothing returns nothing 
    call Push2(GetSpellTargetUnit(), 250.0, 300.0, AngleBetweenUnits(GetSpellTargetUnit(), GetSpellAbilityUnit())) 
endfunction 

//=========================================================================== 
function InitTrig_GravitationalPull takes nothing returns nothing 
    set gg_trg_GravitationalPull = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalPull, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_GravitationalPull, Condition(function Trig_GravitationalPull_Conditions)) 
    call TriggerAddAction(gg_trg_GravitationalPull, function Trig_GravitationalPull_Actions) 
endfunction 

