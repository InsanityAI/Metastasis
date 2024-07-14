function Trig_Force_Dock_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Force_Dock_Func003Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02Q' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02H' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02L' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h002' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h03J' ) ) then
        return true
    endif
    return false
endfunction

function Trig_Force_Dock_Func003C takes nothing returns boolean
    if ( not Trig_Force_Dock_Func003Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_Force_Dock_Actions takes nothing returns nothing
    if ( Trig_Force_Dock_Func003C() ) then
        call IssueTargetOrderBJ( GetSpellTargetUnit(), "acidbomb", gg_unit_h009_0029 )
    else
        call IssueImmediateOrderBJ( GetSpellAbilityUnit(), "stop" )
    endif
endfunction

//===========================================================================
function InitTrig_Force_Dock takes nothing returns nothing
    set gg_trg_Force_Dock = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Force_Dock, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Force_Dock, Condition( function Trig_Force_Dock_Conditions ) )
    call TriggerAddAction( gg_trg_Force_Dock, function Trig_Force_Dock_Actions )
endfunction

