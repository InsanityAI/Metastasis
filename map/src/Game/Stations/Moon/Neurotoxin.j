function Trig_Neurotoxin_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTrainedUnit()) == 'e026')) then 
        return false 
    endif 
    return true 
endfunction 

function Neurotoxin_Finish takes nothing returns nothing 
    local item v = CreateItem('I01X', 0, 0) 
    call RollOutItem(v) 
endfunction 

function Trig_Neurotoxin_Actions takes nothing returns nothing 
    call IssueImmediateOrderBJ(gg_unit_h04B_0165, "stop") 
    call CancelProduction() 
    call BeginProduction("Neurotoxin Module", 300, "Neurotoxin_Finish") 
endfunction 

//=========================================================================== 
function InitTrig_Neurotoxin takes nothing returns nothing 
    set gg_trg_Neurotoxin = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Neurotoxin, EVENT_PLAYER_UNIT_TRAIN_FINISH) 
    call TriggerAddCondition(gg_trg_Neurotoxin, Condition(function Trig_Neurotoxin_Conditions)) 
    call TriggerAddAction(gg_trg_Neurotoxin, function Trig_Neurotoxin_Actions) 
endfunction 

