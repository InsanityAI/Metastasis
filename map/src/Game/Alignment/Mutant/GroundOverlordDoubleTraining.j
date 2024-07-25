function Trig_GroundOverlordDoubleTraining_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'h04W')) then 
        return false 
    endif 
    if(not(GetUnitTypeId(GetTrainedUnit()) != 'h01T')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_GroundOverlordDoubleTraining_Actions takes nothing returns nothing 
    call CreateNUnitsAtLoc(1, GetUnitTypeId(GetTrainedUnit()), udg_Mutant, GetUnitLoc(GetTrainedUnit()), bj_UNIT_FACING) 
    call IssuePointOrderLocBJ(GetLastCreatedUnit(), "move", GetUnitRallyPoint(GetTriggerUnit())) 
endfunction 

//=========================================================================== 
function InitTrig_GroundOverlordDoubleTraining takes nothing returns nothing 
    set gg_trg_GroundOverlordDoubleTraining = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_GroundOverlordDoubleTraining, EVENT_PLAYER_UNIT_TRAIN_FINISH) 
    call TriggerAddCondition(gg_trg_GroundOverlordDoubleTraining, Condition(function Trig_GroundOverlordDoubleTraining_Conditions)) 
    call TriggerAddAction(gg_trg_GroundOverlordDoubleTraining, function Trig_GroundOverlordDoubleTraining_Actions) 
endfunction 
