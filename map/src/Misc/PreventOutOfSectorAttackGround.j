function Trig_PreventOutOfSectorAttackGround_Conditions takes nothing returns boolean
    if ( not ( GetIssuedOrderIdBJ() == String2OrderIdBJ("attackground") ) ) then
        return false
    endif
    return true
endfunction

function Trig_PreventOutOfSectorAttackGround_Func009C takes nothing returns boolean
    if ( not ( udg_TempBool == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_PreventOutOfSectorAttackGround_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetOrderedUnit())
    set udg_TempInt=GetSector(udg_TempPoint)
    call RemoveLocation(udg_TempPoint)
    set udg_TempPoint = GetOrderPointLoc()
    set udg_TempBool=LocInSector(udg_TempPoint, udg_TempInt)
    call RemoveLocation(udg_TempPoint)
    if ( Trig_PreventOutOfSectorAttackGround_Func009C() ) then
        set udg_TempPoint = GetUnitLoc(GetOrderedUnit())
        call IssuePointOrderLocBJ( GetOrderedUnit(), "move", udg_TempPoint )
        call RemoveLocation(udg_TempPoint)
    else
    endif
endfunction

//===========================================================================
function InitTrig_PreventOutOfSectorAttackGround takes nothing returns nothing
    set gg_trg_PreventOutOfSectorAttackGround = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PreventOutOfSectorAttackGround, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerAddCondition( gg_trg_PreventOutOfSectorAttackGround, Condition( function Trig_PreventOutOfSectorAttackGround_Conditions ) )
    call TriggerAddAction( gg_trg_PreventOutOfSectorAttackGround, function Trig_PreventOutOfSectorAttackGround_Actions )
endfunction

