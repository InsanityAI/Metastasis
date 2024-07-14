function Trig_HarbringerDeathShipControl_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'h01T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_HarbringerDeathShipControl_Func003Func001Func004C takes nothing returns boolean
    if ( ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == true ) ) then
        return true
    endif
    if ( ( GetOwningPlayer(GetEnumUnit()) == udg_Mutant ) ) then
        return true
    endif
    return false
endfunction

function Trig_HarbringerDeathShipControl_Func003Func001C takes nothing returns boolean
    if not (IsUnitExplorer(GetEnumUnit())) then
    return false
    endif
    if ( not Trig_HarbringerDeathShipControl_Func003Func001Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_HarbringerDeathShipControl_Func003A takes nothing returns nothing
    if ( Trig_HarbringerDeathShipControl_Func003Func001C() ) then
        call SetUnitOwner( GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false )
    else
    endif
endfunction

function Trig_HarbringerDeathShipControl_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Space), function Trig_HarbringerDeathShipControl_Func003A )
endfunction

//===========================================================================
function InitTrig_HarbringerDeathShipControl takes nothing returns nothing
    set gg_trg_HarbringerDeathShipControl = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_HarbringerDeathShipControl, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_HarbringerDeathShipControl, Condition( function Trig_HarbringerDeathShipControl_Conditions ) )
    call TriggerAddAction( gg_trg_HarbringerDeathShipControl, function Trig_HarbringerDeathShipControl_Actions )
endfunction

