function Trig_EnergyShift_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h04M' ) ) then
        return false
    endif
    if ( not ( GetSpellAbilityId() == 'A0A7' ) ) then
        return false
    endif
    return true
endfunction

function Trig_EnergyShift_Func005C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A07X', GetTriggerUnit()) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_EnergyShift_Actions takes nothing returns nothing
    call IssueImmediateOrderBJ( GetTriggerUnit(), "stop" )
    if ( Trig_EnergyShift_Func005C() ) then
        call UnitRemoveAbilityBJ( 'A07X', GetTriggerUnit() )
        call UnitAddAbilityBJ( 'A0A3', GetTriggerUnit() )
    else
        call UnitRemoveAbilityBJ( 'A0A3', GetTriggerUnit() )
        call UnitAddAbilityBJ( 'A07X', GetTriggerUnit() )
    endif
endfunction

//===========================================================================
function InitTrig_EnergyShift takes nothing returns nothing
    set gg_trg_EnergyShift = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_EnergyShift, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_EnergyShift, Condition( function Trig_EnergyShift_Conditions ) )
    call TriggerAddAction( gg_trg_EnergyShift, function Trig_EnergyShift_Actions )
endfunction

