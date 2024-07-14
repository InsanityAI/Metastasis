//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Overheat_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Overheat_Actions takes nothing returns nothing
local unit a=GetSpellAbilityUnit()
local unit d
    call PolledWait( 4.00 )
    set udg_TempPoint=GetUnitLoc(a)
    call CreateNUnitsAtLoc( 1, 'e00F', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
    set d=GetLastCreatedUnit()
    call RemoveLocation(udg_TempPoint)
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "slow", a )

    call PolledWait(0.5)
    call RemoveUnit(d)
endfunction

//===========================================================================
function InitTrig_Overheat takes nothing returns nothing
    set gg_trg_Overheat = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Overheat, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Overheat, Condition( function Trig_Overheat_Conditions ) )
    call TriggerAddAction( gg_trg_Overheat, function Trig_Overheat_Actions )
endfunction

