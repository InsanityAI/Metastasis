function Trig_CancelProductionGo_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTrainedUnit()) == 'e01V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_CancelProductionGo_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop") 
    call CancelProduction() 
endfunction 

//=========================================================================== 
function InitTrig_CancelProductionGo takes nothing returns nothing 
    set gg_trg_CancelProductionGo = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_CancelProductionGo, EVENT_PLAYER_UNIT_TRAIN_FINISH) 
    call TriggerAddCondition(gg_trg_CancelProductionGo, Condition(function Trig_CancelProductionGo_Conditions)) 
    call TriggerAddAction(gg_trg_CancelProductionGo, function Trig_CancelProductionGo_Actions) 
endfunction 

