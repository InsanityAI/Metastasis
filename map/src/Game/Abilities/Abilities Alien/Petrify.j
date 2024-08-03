//TESH.scrollpos=75
//TESH.alwaysfold=0
function Trig_Petrify_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A045' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Petrify_Func006C takes nothing returns boolean
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Petrify_Func013C takes nothing returns boolean
    if ( not ( udg_Player_PetrifiedHero[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] == udg_TempUnit ) ) then
        return false
    endif
    return true
endfunction

function Depetrify takes unit a returns nothing
    call SetUnitTimeScalePercent( a, 100.00 )
    call PauseUnitBJ( false, a )
    call SetUnitVertexColorBJ( a, 100.00, 100.00, 100.00, 0 )
    call UnitRemoveAbilityBJ( 'Avul', a )
    call SetUnitColor( a, GetPlayerColor(GetOwningPlayer(a)) )
    set udg_TempUnit=a
    if ( Trig_Petrify_Func013C() ) then
        set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))] = a
    else
    endif
endfunction
function DepetrifyInRange takes nothing returns nothing
//local unit a=GetHandleUnit(GetTriggeringTrigger(), "unit")
local unit a=LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("unit"))
local player d=GetOwningPlayer(GetTriggerUnit())
local unit f=GetTriggerUnit()
if GetUnitPointValue(f) != 37 and IsPlayerHuman(d) and f==GetPlayerheroU(f) then
call Depetrify(a)
call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e00U',GetUnitX(a),GetUnitY(a),GetRandomDirectionDeg()) 
call DestroyTrigger(LoadTriggerHandle(LS(),GetHandleId(GetTriggeringTrigger()),StringHash("d")))
call DestroyTrigger(GetTriggeringTrigger())
endif
endfunction
function Petrify_Neutralize takes nothing returns nothing
if GetSpellTargetUnit() != GetEnumUnit() then
call SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE),false)
endif
endfunction
function Petrified_Death takes nothing returns nothing
set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))]=CreateUnit(GetOwningPlayer(GetDyingUnit()),'e000',0,0,0)
call KillUnit(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))])
call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Trig_Petrify_Actions takes nothing returns nothing
local trigger k=CreateTrigger()
local group d
local trigger q=CreateTrigger()
call TriggerRegisterUnitEvent(q,GetSpellTargetUnit(),EVENT_UNIT_DEATH)
call SaveTriggerHandle(LS(),GetHandleId(k),StringHash("d"),q)
call TriggerAddAction(q,function Petrified_Death)
call SaveUnitHandle(LS(), GetHandleId(k), StringHash("unit"), GetSpellTargetUnit())
call DisplayTextToPlayer(GetOwningPlayer(GetSpellTargetUnit()), 0,0, "|cff408080You have been petrified! You will not be able to move and cannot attack or be damaged (except by station/ship destruction). If a friendly human walks close enough to you, you will depetrify.|r")
call TriggerRegisterUnitInRangeSimple(k,100.0,GetSpellTargetUnit())
call TriggerAddAction(k,function DepetrifyInRange)
    call SetUnitTimeScalePercent( GetSpellTargetUnit(), 0.00 )
    call PauseUnitBJ( true, GetSpellTargetUnit() )
    call SetUnitVertexColorBJ( GetSpellTargetUnit(), 20.00, 20.00, 20.00, 0 )
    call UnitAddAbilityBJ( 'Avul', GetSpellTargetUnit() )
    call SetUnitColor( GetSpellTargetUnit(), ConvertPlayerColor(PLAYER_NEUTRAL_AGGRESSIVE) )
    if ( Trig_Petrify_Func006C() ) then
        set udg_Player_PetrifiedHero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = GetSpellTargetUnit()
        set udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = null
        set d=GetUnitsOfPlayerAll(GetOwningPlayer(GetSpellTargetUnit()))
        call ForGroup(d,function Petrify_Neutralize)
        call DestroyGroup(d)
        call TriggerExecute( gg_trg_WinCheck )
    else
    endif
    set udg_TempUnitType = 'e00V'
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempReal = 20.00
    call ExecuteFunc( "AlienRequirementRemove" )
    call ExecuteFunc( "AlienRequirementRestore" )
endfunction

//===========================================================================
function InitTrig_Petrify takes nothing returns nothing
    set gg_trg_Petrify = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Petrify, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Petrify, Condition( function Trig_Petrify_Conditions ) )
    call TriggerAddAction( gg_trg_Petrify, function Trig_Petrify_Actions )
endfunction

