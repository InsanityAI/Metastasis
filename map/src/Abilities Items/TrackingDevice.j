function Trig_TrackingDevice_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A01G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func002Func002Func001Func001001001 takes nothing returns boolean
    return ( udg_Parasite == GetFilterPlayer() )
endfunction

function Trig_TrackingDevice_Func006Func002Func002Func001Func002001001 takes nothing returns boolean
    return ( GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer() )
endfunction

function Trig_TrackingDevice_Func006Func002Func002Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func002Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func002C takes nothing returns boolean
    if ( not ( GetEnumUnit() != GetManipulatingUnit() ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func003Func002Func001Func001001001 takes nothing returns boolean
    return ( udg_Parasite == GetFilterPlayer() )
endfunction

function Trig_TrackingDevice_Func006Func003Func002Func001Func002001001 takes nothing returns boolean
    return ( GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer() )
endfunction

function Trig_TrackingDevice_Func006Func003Func002Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func003Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006Func003C takes nothing returns boolean
    if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
    return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func006A takes nothing returns nothing
    set udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
    if ( Trig_TrackingDevice_Func006Func002C() ) then
        set udg_TempBool=UnitInSectorLax(GetEnumUnit(), udg_TempInt)
        if ( Trig_TrackingDevice_Func006Func002Func002C() ) then
            if ( Trig_TrackingDevice_Func006Func002Func002Func001C() ) then
                call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_TrackingDevice_Func006Func002Func002Func001Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 100, 50.00 )
            else
                call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_TrackingDevice_Func006Func002Func002Func001Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 50.00, 100, 50.00 )
            endif
        else
        endif
    else
    endif
    if ( Trig_TrackingDevice_Func006Func003C() ) then
        set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
        if ( Trig_TrackingDevice_Func006Func003Func002C() ) then
            if ( Trig_TrackingDevice_Func006Func003Func002Func001C() ) then
                call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_TrackingDevice_Func006Func003Func002Func001Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
            else
                call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_TrackingDevice_Func006Func003Func002Func001Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
            endif
        else
        endif
    else
    endif
    call RemoveLocation(udg_TempPoint2)
endfunction

function Trig_TrackingDevice_Func009Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) != GetOwningPlayer(GetSpellAbilityUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TrackingDevice_Func009A takes nothing returns nothing
    if ( Trig_TrackingDevice_Func009Func001C() ) then
        call UnitRemoveAbilityBJ( 'A08D', GetEnumUnit() )
    else
    endif
endfunction

function Trig_TrackingDevice_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempUnitGroup=GetUnitsInRangeAndShips(udg_TempPoint,8000.0)
    set udg_TempInt=GetSector(udg_TempPoint)
    call ForGroupBJ( udg_TempUnitGroup, function Trig_TrackingDevice_Func006A )
        call DestroyGroup( udg_TempUnitGroup )
    set udg_TempUnitGroup=GetUnitsInRangeAndShips(udg_TempPoint,900.0)
    call ForGroupBJ( udg_TempUnitGroup, function Trig_TrackingDevice_Func009A )
        call DestroyGroup( udg_TempUnitGroup )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_TrackingDevice takes nothing returns nothing
    set gg_trg_TrackingDevice = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_TrackingDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_TrackingDevice, Condition( function Trig_TrackingDevice_Conditions ) )
    call TriggerAddAction( gg_trg_TrackingDevice, function Trig_TrackingDevice_Actions )
endfunction

