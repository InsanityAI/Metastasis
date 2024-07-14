function Trig_ST3Abilities_Func002Func004Func001Func002Func001001001 takes nothing returns boolean
    return ( GetFilterPlayer() == udg_Parasite )
endfunction

function Trig_ST3Abilities_Func002Func004Func001Func002Func002001001 takes nothing returns boolean
    return ( GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit()) )
endfunction

function Trig_ST3Abilities_Func002Func004Func001Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Abilities_Func002Func004Func001C takes nothing returns boolean
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

function Trig_ST3Abilities_Func002Func004Func002Func002Func001001001 takes nothing returns boolean
    return ( udg_Parasite == GetFilterPlayer() )
endfunction

function Trig_ST3Abilities_Func002Func004Func002Func002Func002001001 takes nothing returns boolean
    return ( GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer() )
endfunction

function Trig_ST3Abilities_Func002Func004Func002Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Abilities_Func002Func004Func002C takes nothing returns boolean
    if not (IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then
    return false
    endif
    return true
endfunction

function Trig_ST3Abilities_Func002Func004A takes nothing returns nothing
    if ( Trig_ST3Abilities_Func002Func004Func001C() ) then
        set udg_TempPoint = GetUnitLoc(GetEnumUnit())
        if ( Trig_ST3Abilities_Func002Func004Func001Func002C() ) then
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_ST3Abilities_Func002Func004Func001Func002Func002001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100 )
        else
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_ST3Abilities_Func002Func004Func001Func002Func001001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100 )
        endif
        call RemoveLocation(udg_TempPoint)
    else
    endif
    if ( Trig_ST3Abilities_Func002Func004Func002C() ) then
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
        if ( Trig_ST3Abilities_Func002Func004Func002Func002C() ) then
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_ST3Abilities_Func002Func004Func002Func002Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
        else
            call PingMinimapLocForForceEx( GetPlayersMatching(Condition(function Trig_ST3Abilities_Func002Func004Func002Func002Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00 )
        endif
        call RemoveLocation(udg_TempPoint2)
    else
    endif
endfunction

function Trig_ST3Abilities_Func002C takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A000' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST3Abilities_Actions takes nothing returns nothing
    if ( Trig_ST3Abilities_Func002C() ) then
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_167" )
        set udg_TempRect = gg_rct_ST3
        set udg_TempUnitGroup=GetUnitsInRectAll(udg_TempRect)
        call ForGroupBJ( udg_TempUnitGroup, function Trig_ST3Abilities_Func002Func004A )
            call DestroyGroup( udg_TempUnitGroup )
    else
    endif
endfunction

//===========================================================================
function InitTrig_ST3Abilities takes nothing returns nothing
    set gg_trg_ST3Abilities = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_ST3Abilities, gg_unit_h006_0026, EVENT_UNIT_SPELL_EFFECT )
    call TriggerAddAction( gg_trg_ST3Abilities, function Trig_ST3Abilities_Actions )
endfunction

