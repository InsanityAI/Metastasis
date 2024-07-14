function Trig_ST11DieNatural_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetDyingUnit()) == 'h04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST11DieNatural_Func006Func002Func001Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h002' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h02L' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h02H' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h02Q' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetEnumUnit()) == 'h03J' ) ) then
        return true
    endif
    return false
endfunction

function Trig_ST11DieNatural_Func006Func002Func001C takes nothing returns boolean
    if ( not Trig_ST11DieNatural_Func006Func002Func001Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_ST11DieNatural_Func006Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST11DieNatural_Func006A takes nothing returns nothing
    // If not equal to space overlord unit, then change ownership
    if ( Trig_ST11DieNatural_Func006Func002C() ) then
        if ( Trig_ST11DieNatural_Func006Func002Func001C() ) then
            call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false)
        else
            call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), false)
        endif
    else
    endif
endfunction

function Trig_ST11DieNatural_Func011A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_OverlordRect )
endfunction

function Trig_ST11DieNatural_Func012A takes nothing returns nothing
    call UnitAddAbilityBJ( 'A02T', GetEnumUnit() )
    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04T', GetEnumUnit() )
    call UnitRemoveAbilityBJ( 'A04U', GetEnumUnit() )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call RemoveItem( UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
endfunction

function Trig_ST11DieNatural_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    // NewStuff
    set udg_TempUnitGroup = GetUnitsOfPlayerAll(udg_Mutant)
    call ForGroupBJ( udg_TempUnitGroup, function Trig_ST11DieNatural_Func006A )
    call DestroyGroup(udg_TempUnitGroup)
    call SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], udg_Mutant, false)
    // NewStuff
    call KillUnit( udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] )
    call ForForce( GetPlayersAll(), function Trig_ST11DieNatural_Func011A )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_OverlordRect), function Trig_ST11DieNatural_Func012A )
    call RectOfDoom(gg_rct_OverlordRect)
endfunction

//===========================================================================
function InitTrig_ST11DieNatural takes nothing returns nothing
    set gg_trg_ST11DieNatural = CreateTrigger(  )
    call DisableTrigger( gg_trg_ST11DieNatural )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ST11DieNatural, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_ST11DieNatural, Condition( function Trig_ST11DieNatural_Conditions ) )
    call TriggerAddAction( gg_trg_ST11DieNatural, function Trig_ST11DieNatural_Actions )
endfunction

