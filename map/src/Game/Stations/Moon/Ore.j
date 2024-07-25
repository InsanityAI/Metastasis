function Trig_Ore_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTrainedUnit()) == 'e025')) then 
        return false 
    endif 
    return true 
endfunction 

function Ore_Finish takes nothing returns nothing 
    local item v = CreateItem('I01W', 0, 0) 
    call RollOutItem(v) 
endfunction 

function Trig_Ore_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop") 
    call CancelProduction() 
    call BeginProduction("Refined Ore", 70, "Ore_Finish") 
endfunction 

//=========================================================================== 
function InitTrig_Ore takes nothing returns nothing 
    set gg_trg_Ore = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Ore, EVENT_PLAYER_UNIT_TRAIN_FINISH) 
    call TriggerAddCondition(gg_trg_Ore, Condition(function Trig_Ore_Conditions)) 
    call TriggerAddAction(gg_trg_Ore, function Trig_Ore_Actions) 
endfunction 

