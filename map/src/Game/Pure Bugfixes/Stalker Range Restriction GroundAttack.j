function Trig_Stalker_Range_Restriction_GroundAttack_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'h01D')) then 
        return false 
    endif 
    if(not(GetIssuedOrderIdBJ() == String2OrderIdBJ("attackground"))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Stalker_Range_Restriction_GroundAttack_Actions takes nothing returns nothing 
    set udg_StalkerAttackLocation = GetOrderPointLoc() 
    set udg_StalkerUnitLocation = GetUnitLoc(GetTriggerUnit()) 
    set udg_StalkerUnit = GetTriggerUnit() 
    call StartTimerBJ(udg_StalkerAttackTimer, false, 0.00) 
endfunction 

//=========================================================================== 
function InitTrig_Stalker_Range_Restriction_GroundAttack takes nothing returns nothing 
    set gg_trg_Stalker_Range_Restriction_GroundAttack = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Stalker_Range_Restriction_GroundAttack, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER) 
    call TriggerAddCondition(gg_trg_Stalker_Range_Restriction_GroundAttack, Condition(function Trig_Stalker_Range_Restriction_GroundAttack_Conditions)) 
    call TriggerAddAction(gg_trg_Stalker_Range_Restriction_GroundAttack, function Trig_Stalker_Range_Restriction_GroundAttack_Actions) 
endfunction 

