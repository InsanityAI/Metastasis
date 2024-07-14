function Trig_MagneticSaw_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A061' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MagneticSaw_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call CreateNUnitsAtLoc( 1, 'h03N', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING )
    call SetUnitTimeScalePercent( GetLastCreatedUnit(), 200.00 )
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "attack", GetSpellTargetUnit() )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_MagneticSaw takes nothing returns nothing
    set gg_trg_MagneticSaw = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_MagneticSaw, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_MagneticSaw, Condition( function Trig_MagneticSaw_Conditions ) )
    call TriggerAddAction( gg_trg_MagneticSaw, function Trig_MagneticSaw_Actions )
endfunction

