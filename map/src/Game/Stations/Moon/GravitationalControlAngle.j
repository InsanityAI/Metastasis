//TESH.scrollpos=50
//TESH.alwaysfold=0
function Trig_GravitationalControlTarget_Copy_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A052' ) ) then
        return false
    endif
    return true
endfunction

function GC_Move takes nothing returns nothing
local timer i=GetExpiredTimer()
local real angle=LoadReal(LS(), GetHandleId(i), StringHash("angle"))
local lightning handofgod=LoadLightningHandle(LS(), GetHandleId(i), StringHash("lightning"))
local real tforce=LoadReal(LS(), GetHandleId(i), StringHash("force"))
local unit target=LoadUnitHandle(LS(), GetHandleId(i), StringHash("target"))

set udg_TempPoint=GetUnitLoc(target)
set udg_TempPoint2=PolarProjectionBJ(udg_TempPoint,tforce,angle)
call SetUnitPositionLoc(target,udg_TempPoint2)
call RemoveLocation(udg_TempPoint)
set udg_TempPoint=GetUnitLoc(gg_unit_h03T_0209)
if RectContainsLoc(gg_rct_Space,udg_TempPoint) == true then
call MoveLightningEx(handofgod, false, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), 0.0,GetLocationX(udg_TempPoint2),GetLocationY(udg_TempPoint2),0.0)
    endif
call RemoveLocation(udg_TempPoint)
call RemoveLocation(udg_TempPoint2)
call SaveReal(LS(), GetHandleId(i),StringHash("force"),tforce+0.25)
endfunction
function Trig_GravitationalControlTarget_Copy_Actions takes nothing returns nothing
local timer i
local lightning handofgod
local real duration
if udg_GravitationalControl_Target != null then
set i = CreateTimer()
call SaveUnitHandle(LS(), GetHandleId(i), StringHash("target"),udg_GravitationalControl_Target)
set udg_TempPoint=GetUnitLoc(gg_unit_h03T_0209)
set udg_TempPoint2=GetUnitLoc(udg_GravitationalControl_Target)
set handofgod= AddLightningEx("LEAS", false, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), 0,GetLocationX(udg_TempPoint2),GetLocationY(udg_TempPoint2),0)
call SaveLightningHandle(LS(), GetHandleId(i), StringHash("lightning"), handofgod)
call SaveReal(LS(), GetHandleId(i),StringHash("force"),0)
call RemoveLocation(udg_TempPoint)
set udg_TempPoint=GetSpellTargetLoc()
call SaveReal(LS(), GetHandleId(i), StringHash("angle"), AngleBetweenPoints(udg_TempPoint2,udg_TempPoint))
set duration=4
if GetUnitTypeId(udg_GravitationalControl_Target) != 'h031' and GetUnitTypeId(udg_GravitationalControl_Target) != 'h032' then
//The point value of units in space divided by 100 is the factor by which they can be pushed. For space alien, special exception.
//Lower point values = harder to push
set duration = duration * I2R(GetUnitPointValue(udg_GravitationalControl_Target))/100.0
endif
call RemoveLocation(udg_TempPoint)
call RemoveLocation(udg_TempPoint2)
    call RemoveUnit( GetSpellAbilityUnit() )
    call DisplayTextToForce(GetPlayersAll(), "|cffFF8000GRAVITATIONAL CORRECTIONS ACTIVATED FOR " + StringCase(GetUnitName(udg_GravitationalControl_Target),true) + ".|r")
    call PlaySoundBJ( gg_snd_CharmTarget1 )
   // call PolledWait(2.0)

call TimerStart(i,0.04,true,function GC_Move)


    call PolledWait(duration)
    call FlushChildHashtable(LS(), GetHandleId(i))
    call PauseTimer(i)
    call DestroyTimer(i)
        call DestroyLightning( handofgod )
endif
endfunction

//===========================================================================
function InitTrig_GravitationalControlAngle takes nothing returns nothing
    set gg_trg_GravitationalControlAngle = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_GravitationalControlAngle, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_GravitationalControlAngle, Condition( function Trig_GravitationalControlTarget_Copy_Conditions ) )
    call TriggerAddAction( gg_trg_GravitationalControlAngle, function Trig_GravitationalControlTarget_Copy_Actions )
endfunction

