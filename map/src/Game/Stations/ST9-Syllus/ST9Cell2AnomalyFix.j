function Trig_ST9Cell2AnomalyFix_Func003Func001C takes nothing returns boolean 
    if((RectContainsUnit(gg_rct_FreeAnomalyRect, GetTriggerUnit()) == false)) then 
        return true 
    endif 
    if((IsDestructableDeadBJ(gg_dest_YTab_4371) == false)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_ST9Cell2AnomalyFix_Func003C takes nothing returns boolean 
    if(not Trig_ST9Cell2AnomalyFix_Func003Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST9Cell2AnomalyFix_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'n00A')) then 
        return false 
    endif 
    if(not(IsUnitHiddenBJ(GetTriggerUnit()) == false)) then 
        return false 
    endif 
    if(not Trig_ST9Cell2AnomalyFix_Func003C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST9Cell2AnomalyFix_Actions takes nothing returns nothing 
    set udg_TempPoint = GetRectCenter(gg_rct_Cage2) 
    call SetUnitPositionLoc(GetTriggerUnit(), udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
endfunction 

//=========================================================================== 
function InitTrig_ST9Cell2AnomalyFix takes nothing returns nothing 
    set gg_trg_ST9Cell2AnomalyFix = CreateTrigger() 
    call TriggerRegisterLeaveRectSimple(gg_trg_ST9Cell2AnomalyFix, gg_rct_Cage2) 
    call TriggerAddCondition(gg_trg_ST9Cell2AnomalyFix, Condition(function Trig_ST9Cell2AnomalyFix_Conditions)) 
    call TriggerAddAction(gg_trg_ST9Cell2AnomalyFix, function Trig_ST9Cell2AnomalyFix_Actions) 
endfunction 

