//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Stalker_Range_Restriction_Attack_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h01D' ) ) then
        return false
    endif
    if ( not ( GetIssuedOrderIdBJ() == String2OrderIdBJ("attack") ) ) then
        return false
    endif
    return true
endfunction

function Trig_Stalker_Range_Restriction_Attack_Actions takes nothing returns nothing
    set udg_StalkerAttackLocation = GetUnitLoc(GetOrderTargetUnit())
    set udg_StalkerUnitLocation = GetUnitLoc(GetTriggerUnit())
    set udg_StalkerUnit = GetTriggerUnit()
    call StartTimerBJ( udg_StalkerAttackTimer, false, 0.00 )
endfunction

//===========================================================================
function InitTrig_Stalker_Range_Restriction_Attack takes nothing returns nothing
    set gg_trg_Stalker_Range_Restriction_Attack = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Stalker_Range_Restriction_Attack, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
    call TriggerAddCondition( gg_trg_Stalker_Range_Restriction_Attack, Condition( function Trig_Stalker_Range_Restriction_Attack_Conditions ) )
    call TriggerAddAction( gg_trg_Stalker_Range_Restriction_Attack, function Trig_Stalker_Range_Restriction_Attack_Actions )
endfunction

