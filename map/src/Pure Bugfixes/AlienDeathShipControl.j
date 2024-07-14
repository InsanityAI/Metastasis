function Trig_AlienDeathShipControl_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == udg_Parasite ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienDeathShipControl_Func004Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == udg_Parasite ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    if not (IsUnitExplorer(GetEnumUnit())) then
    return false
    endif
    return true
endfunction

function Trig_AlienDeathShipControl_Func004A takes nothing returns nothing
    if ( Trig_AlienDeathShipControl_Func004Func001C() ) then
        call SetUnitOwner( GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false )
    else
    endif
endfunction

function Trig_AlienDeathShipControl_Actions takes nothing returns nothing
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Space), function Trig_AlienDeathShipControl_Func004A )
endfunction

//===========================================================================
function InitTrig_AlienDeathShipControl takes nothing returns nothing
    set gg_trg_AlienDeathShipControl = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AlienDeathShipControl, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_AlienDeathShipControl, Condition( function Trig_AlienDeathShipControl_Conditions ) )
    call TriggerAddAction( gg_trg_AlienDeathShipControl, function Trig_AlienDeathShipControl_Actions )
endfunction

