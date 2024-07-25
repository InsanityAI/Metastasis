function Trig_SummonMetal_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSummonedUnit()) == 'h04L')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SummonMetal_Actions takes nothing returns nothing 
    call SetUnitTimeScalePercent(GetSummonedUnit(), 0.00) 
    call SetUnitOwner(GetSummonedUnit(), Player(PLAYER_NEUTRAL_PASSIVE), true) 
endfunction 

//=========================================================================== 
function InitTrig_SummonMetal takes nothing returns nothing 
    set gg_trg_SummonMetal = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SummonMetal, EVENT_PLAYER_UNIT_SUMMON) 
    call TriggerAddCondition(gg_trg_SummonMetal, Condition(function Trig_SummonMetal_Conditions)) 
    call TriggerAddAction(gg_trg_SummonMetal, function Trig_SummonMetal_Actions) 
endfunction 

