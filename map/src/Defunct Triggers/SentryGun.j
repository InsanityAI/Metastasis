//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_SentryGun_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A024' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SentryGun_Func007Func002C takes nothing returns boolean
    if ( ( udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 1 ) ) then
        return true
    endif
    if ( ( udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 2 ) ) then
        return true
    endif
    if ( ( udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 11 ) ) then
        return true
    endif
    return false
endfunction

function Trig_SentryGun_Func007C takes nothing returns boolean
    if ( not Trig_SentryGun_Func007Func002C() ) then
        return false
    endif
    if ( not ( udg_Researcher_PhD[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == 3 ) ) then
        return false
    endif
    return true
endfunction
function SentryGunProximity takes nothing returns nothing
if GetUnitTypeId(GetEnumUnit()) == 'h01Z' or GetUnitTypeId(GetEnumUnit()) == 'h03L' and IsUnitAliveBJ(GetEnumUnit()) then
set udg_TempBool=true
endif
endfunction
function Trig_SentryGun_Actions takes nothing returns nothing
local unit a
    set udg_TempPoint = GetSpellTargetLoc()
    if RectContainsLoc(gg_rct_NoOutpostRect, udg_TempPoint) then
    call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()),0,0,"|cffffcc00Sentry gun may not be placed here due to local instability.|r")
    call CreateItemLoc('I00V',udg_TempPoint)
    call RemoveLocation(udg_TempPoint)
    return
    endif
    set udg_TempUnitGroup=GetUnitsInRangeOfLocAll(200.0, udg_TempPoint)
    set udg_TempBool=false
    call ForGroup(udg_TempUnitGroup, function SentryGunProximity)
    call DestroyGroup(udg_TempUnitGroup)
    if udg_TempBool then
    call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()),0,0,"|cffffcc00Sentry gun may not be placed here; too close to another sentry gun.|r")
    call CreateItemLoc('I00V',udg_TempPoint)
    call RemoveLocation(udg_TempPoint)
    endif
    call CreateNUnitsAtLoc( 1, 'h01Z', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    call NewUnitRegister(GetLastCreatedUnit())
    call RemoveLocation( udg_TempPoint )
    set udg_SentryGun_OrigOwner[GetUnitUserData(GetLastCreatedUnit())] = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempUnit = GetLastCreatedUnit()
    if ( Trig_SentryGun_Func007C() ) then
        call UnitAddAbilityBJ( 'A02I', GetLastCreatedUnit() )
    else
    endif
    call PauseUnitBJ( true, GetLastCreatedUnit() )
    set udg_CountUpBarColor = "|cff800080"
    set a=GetLastCreatedUnit()
    call CountUpBar(udg_TempUnit, 10, 0.5, "DoNothing")
    set udg_TempUnit=a
    call ExecuteFunc( "SentryGunAI" )
    call PauseUnitBJ( false, a )
    set a=null
endfunction

//===========================================================================
function InitTrig_SentryGun takes nothing returns nothing
    set gg_trg_SentryGun = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SentryGun, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_SentryGun, Condition( function Trig_SentryGun_Conditions ) )
    call TriggerAddAction( gg_trg_SentryGun, function Trig_SentryGun_Actions )
endfunction

