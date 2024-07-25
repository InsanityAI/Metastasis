function Trig_IllusionStop_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A00T')) then 
        return false 
    endif 
    if(not(udg_IllusionSuitBoolean == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_IllusionStop_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(GetTriggerUnit(), "stop") 
endfunction 

//=========================================================================== 
function InitTrig_IllusionStop takes nothing returns nothing 
    set gg_trg_IllusionStop = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_IllusionStop, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_IllusionStop, Condition(function Trig_IllusionStop_Conditions)) 
    call TriggerAddAction(gg_trg_IllusionStop, function Trig_IllusionStop_Actions) 
endfunction 

