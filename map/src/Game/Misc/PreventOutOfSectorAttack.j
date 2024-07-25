function Trig_PreventOutOfSectorAttack_Conditions takes nothing returns boolean 
    if(not(GetIssuedOrderIdBJ() == String2OrderIdBJ("attack"))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PreventOutOfSectorAttack_Func009C takes nothing returns boolean 
    if(not(udg_TempBool == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_PreventOutOfSectorAttack_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetOrderedUnit()) 
    set udg_TempInt = GetSector(udg_TempPoint) 
    call RemoveLocation(udg_TempPoint) 
    set udg_TempPoint = GetUnitLoc(GetOrderTargetUnit()) 
    set udg_TempBool = LocInSector(udg_TempPoint, udg_TempInt) 
    call RemoveLocation(udg_TempPoint) 
    if(Trig_PreventOutOfSectorAttack_Func009C()) then 
        set udg_TempPoint = GetUnitLoc(GetOrderedUnit()) 
        call IssuePointOrderLocBJ(GetOrderedUnit(), "move", udg_TempPoint) 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_PreventOutOfSectorAttack takes nothing returns nothing 
    set gg_trg_PreventOutOfSectorAttack = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_PreventOutOfSectorAttack, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER) 
    call TriggerAddCondition(gg_trg_PreventOutOfSectorAttack, Condition(function Trig_PreventOutOfSectorAttack_Conditions)) 
    call TriggerAddAction(gg_trg_PreventOutOfSectorAttack, function Trig_PreventOutOfSectorAttack_Actions) 
endfunction 

