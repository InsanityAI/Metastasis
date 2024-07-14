//TESH.scrollpos=30
//TESH.alwaysfold=0
function Trig_Vector_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05J' ) ) then
        return false
    endif
    return true
endfunction
function Vector_Slide takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
local location a=GetUnitLoc(l)
local location i=GetUnitLoc(LoadUnitHandle(LS(), GetHandleId(k), StringHash("target")))
local real q=AngleBetweenPoints(a,i)
local location b=PolarProjectionBJ(a,15.0,GetUnitFacing(l))
if GetLocationZ(b) > GetLocationZ(a)+60.0 then
call KillUnit(l)
endif
if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then
call KillUnit(l)
endif
call SetUnitPositionLoc(l,b)
call SetUnitFacingTimed(l,q,0.75)
call RemoveLocation(b)
call RemoveLocation(a)
call RemoveLocation(i)
if IsUnitDeadBJ(l) then
call PauseTimer(k)
call DestroyTimer(k)
endif
endfunction

function Vector_Damage takes nothing returns nothing
local trigger t=GetTriggeringTrigger()
local integer i=0
local unit a=LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit"))
local unit b=GetTriggerUnit()
if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul')==0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]==false then
call KillUnit(a)
call DestroyTrigger(t)
loop
exitwhen i>9
call PauseUnit(b,true)
call SetUnitAnimation(b,"death")
call PolledWait(0.3)
call PauseUnit(b,false)
call PolledWait((2+i)/2)
set i=i+1
endloop
endif
endfunction

function Vector_Dies takes nothing returns nothing
local trigger q=GetTriggeringTrigger()
local trigger t=LoadTriggerHandle(LS(), GetHandleId(q), StringHash("t"))
local trigger o=LoadTriggerHandle(LS(), GetHandleId(q), StringHash("o"))
call FlushChildHashtable(LS(), GetHandleId(GetTriggerUnit()))
call FlushChildHashtable(LS(), GetHandleId(q))
call FlushChildHashtable(LS(), GetHandleId(t))
call FlushChildHashtable(LS(), GetHandleId(o))
call DestroyTrigger(q)
call DestroyTrigger(t)
call DestroyTrigger(o)
endfunction

function Trig_Vector_Actions takes nothing returns nothing
local timer k=CreateTimer()
local trigger t=CreateTrigger()
local trigger q=CreateTrigger()

    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())
    set udg_TempPoint3=PolarProjectionBJ(udg_TempPoint,160.0,AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))
    set udg_TempBool = false
    call CreateNUnitsAtLoc( 1, 'e01G', Player(15), udg_TempPoint3, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
 call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),AngleBetweenPoints(udg_TempPoint, udg_TempPoint2))  
   call TriggerRegisterUnitEvent(q,GetLastCreatedUnit(), EVENT_UNIT_DEATH)
   call TriggerAddAction(q,function Vector_Dies)
   call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
   call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
    call TimerStart(k,0.04,true,function Vector_Slide)
    call TriggerRegisterUnitInRangeSimple(t,50.0, GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("target"), GetSpellTargetUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())   
    call TriggerAddAction(t, function Vector_Damage)
    call SetUnitPathing(GetLastCreatedUnit(), false)
endfunction

//===========================================================================
function InitTrig_Vector takes nothing returns nothing
    set gg_trg_Vector = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Vector, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Vector, Condition( function Trig_Vector_Conditions ) )
    call TriggerAddAction( gg_trg_Vector, function Trig_Vector_Actions )
endfunction

