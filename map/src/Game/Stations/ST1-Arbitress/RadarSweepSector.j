function Trig_RadarSweepSector_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetSoldItem()) == 'I00T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RadarSweepSector_Func005Func001Func002Func001001001 takes nothing returns boolean
    return ( GetFilterPlayer() == udg_Parasite )
endfunction

function Trig_RadarSweepSector_Func005Func001Func002Func002001001 takes nothing returns boolean
    return ( GetFilterPlayer() == GetOwningPlayer(GetBuyingUnit()) )
endfunction

function Trig_RadarSweepSector_Func005Func001Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetBuyingUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_RadarSweepSector_Func005Func001C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(gg_rct_Space, GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_RadarSweepSector_Func005Func002Func002Func001001001 takes nothing returns boolean
    return ( udg_Parasite == GetFilterPlayer() )
endfunction

function Trig_RadarSweepSector_Func005Func002Func002Func002001001 takes nothing returns boolean
    return ( GetOwningPlayer(GetBuyingUnit()) == GetFilterPlayer() )
endfunction

function Trig_RadarSweepSector_Func005Func002Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetBuyingUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_RadarSweepSector_Func005Func002C takes nothing returns boolean
    if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
    return false
    endif
    if ( not ( RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_RadarSweepSector_Func005A takes nothing returns nothing
    if ( Trig_RadarSweepSector_Func005Func001C() ) then
        set udg_TempPoint = GetUnitLoc(GetEnumUnit())
        if ( Trig_RadarSweepSector_Func005Func001Func002C() ) then
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_RadarSweepSector_Func005Func001Func002Func002001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100 )
        else
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_RadarSweepSector_Func005Func001Func002Func001001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100 )
        endif
        call RemoveLocation(udg_TempPoint)
    else
    endif
    if ( Trig_RadarSweepSector_Func005Func002C() ) then
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
        if ( Trig_RadarSweepSector_Func005Func002Func002C() ) then
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_RadarSweepSector_Func005Func002Func002Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
        else
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_RadarSweepSector_Func005Func002Func002Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
        endif
        call RemoveLocation(udg_TempPoint2)
    else
    endif
endfunction

function Trig_RadarSweepSector_Actions takes nothing returns nothing
    call RemoveItem( GetSoldItem() )
    call DisplayTextToPlayer( GetOwningPlayer(GetBuyingUnit()), 0, 0, "TRIGSTR_5331" )
    call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), function Trig_RadarSweepSector_Func005A )
endfunction

//===========================================================================
function InitTrig_RadarSweepSector takes nothing returns nothing
    set gg_trg_RadarSweepSector = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_RadarSweepSector, gg_unit_h019_0155, EVENT_UNIT_SELL_ITEM )
    call TriggerAddCondition( gg_trg_RadarSweepSector, Condition( function Trig_RadarSweepSector_Conditions ) )
    call TriggerAddAction( gg_trg_RadarSweepSector, function Trig_RadarSweepSector_Actions )
endfunction

