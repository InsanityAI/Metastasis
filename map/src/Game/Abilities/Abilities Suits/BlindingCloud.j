function Trig_BlindingCloud_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_BlindingCloud_Actions takes nothing returns nothing
    set udg_TempPoint2 = GetSpellTargetLoc()
    call CreateNUnitsAtLoc( 1, 'e013', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call IssuePointOrderLocBJ( GetLastCreatedUnit(), "cloudoffog", udg_TempPoint2 )
    call RemoveLocation(udg_TempPoint2)
endfunction

//===========================================================================
function InitTrig_BlindingCloud takes nothing returns nothing
    set gg_trg_BlindingCloud = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_BlindingCloud, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_BlindingCloud, Condition( function Trig_BlindingCloud_Conditions ) )
    call TriggerAddAction( gg_trg_BlindingCloud, function Trig_BlindingCloud_Actions )
endfunction

