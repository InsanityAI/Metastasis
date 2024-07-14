function Trig_EscapePodDies_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'h02P' ) ) then
        return false
    endif
    return true
endfunction

function Trig_EscapePodDies_Actions takes nothing returns nothing
    set udg_TempPlayer = udg_EscapePod_Owner[GetUnitUserData(GetDyingUnit())]
    set udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    call SetUnitPositionLoc( udg_TempUnit, udg_TempPoint )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit )
    call UnitAddAbilityBJ( 'A02T', udg_TempUnit )
    call UnitRemoveAbilityBJ( 'A04T', udg_TempUnit )
    call UnitRemoveAbilityBJ( 'A04U', udg_TempUnit )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem( UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call MoogleKillUnit(udg_TempUnit, GetKillingUnit())
endfunction

//===========================================================================
function InitTrig_EscapePodDies takes nothing returns nothing
    set gg_trg_EscapePodDies = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_EscapePodDies, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_EscapePodDies, Condition( function Trig_EscapePodDies_Conditions ) )
    call TriggerAddAction( gg_trg_EscapePodDies, function Trig_EscapePodDies_Actions )
endfunction

