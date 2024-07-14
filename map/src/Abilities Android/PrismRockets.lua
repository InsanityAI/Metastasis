//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_PrismRockets_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05U' ) ) then
        return false
    endif
    return true
endfunction



function PrismRocket_Slide takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
local location a=GetUnitLoc(l)
local location b=PolarProjectionBJ(a,40.0,GetUnitFacing(l))
local real c=LoadReal(LS(), GetHandleId(l), StringHash("angle"))
local real height=LoadReal(LS(), GetHandleId(l), StringHash("height"))
local real d=LoadReal(LS(),GetHandleId(l),StringHash("zdecay"))
call SetUnitFlyHeight(l,height+d-GetLocationZ(b),0.0)
call SaveReal(LS(),GetHandleId(l),StringHash("height"),height+d)
if GetLocationZ(b) > GetLocationZ(a)+GetUnitFlyHeight(l) then
call KillUnit(l)
endif
//if IsPointPathable(GetLocationX(b), GetLocationY(b), false) == false then
//call KillUnit(l)
//endif
call SetUnitPositionLoc(l,b)
call SetUnitFacing(l,c)
call RemoveLocation(b)
call RemoveLocation(a)
if IsUnitDeadBJ(l) then
call PauseTimer(k)
call DestroyTimer(k)
endif
endfunction

function PrismRocket_Damage takes nothing returns nothing
local trigger t=GetTriggeringTrigger()
local unit a=LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit"))
if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul')==0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then
call KillUnit(a)
call DestroyTrigger(t)
endif
endfunction
function PrismRocket_Dies takes nothing returns nothing
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

function FirePrismRocket takes real x1, real y2, real z1,real zdecay, real angle returns nothing
local timer k=CreateTimer()
local trigger t=CreateTrigger()
local trigger q=CreateTrigger()
set udg_TempPoint = Location(x1,y2)
    set udg_TempPoint3=PolarProjectionBJ(udg_TempPoint,160.0,angle)
    set udg_TempBool = false
    call CreateNUnitsAtLoc( 1, 'e01M', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, angle )
 call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("angle"),angle)  
  call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("height"),z1) 
  call SetUnitFlyHeight(GetLastCreatedUnit(),z1-GetLocationZ(udg_TempPoint),0.0)
    call SaveReal(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("zdecay"),zdecay) 
   call TriggerRegisterUnitEvent(q,GetLastCreatedUnit(), EVENT_UNIT_DEATH)
   call TriggerAddAction(q,function PrismRocket_Dies)
   call SaveTriggerHandle(LS(), GetHandleId(q), StringHash("t"), t)
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
    call RemoveLocation(udg_TempPoint)
    call TimerStart(k,0.04,true,function PrismRocket_Slide)
    call TriggerRegisterUnitInRangeSimple(t,50.0, GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())   
    call TriggerAddAction(t, function PrismRocket_Damage)
    call SetUnitPathing(GetLastCreatedUnit(), false)
endfunction




function PrismRockets_Fire takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit b=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local integer port =LoadInteger(LS(),GetHandleId(t),StringHash("PrismRocket_Port"))+1
local real x=LoadReal(LS(),GetHandleId(t),StringHash("x"))
local real y=LoadReal(LS(),GetHandleId(t),StringHash("y"))
local location o=Location(x,y)
local location c=PolarProjectionBJ(o,GetRandomReal(0,200.0),GetRandomDirectionDeg())
local location m=GetUnitLoc(b)
local real omnomnom=AngleBetweenPoints(m,c)
if port > 4 then
set port=1
call SaveInteger(LS(),GetHandleId(t),StringHash("PrismRocket_Port"),1)
else
call SaveInteger(LS(),GetHandleId(t),StringHash("PrismRocket_Port"),port)
endif
if port >2 then
set port = port + 1
endif
call FirePrismRocket(GetUnitX(b)+(-128+64*(port-1))*CosBJ(omnomnom+90)+110.8*CosBJ(omnomnom),GetUnitY(b)+(-128+64*(port-1))*SinBJ(omnomnom+90)+110.8*SinBJ(omnomnom),GetLocationZ(o)+200.0,-10.0,omnomnom)
call RemoveLocation(o)
set o=null
call RemoveLocation(m)
set m=null
call RemoveLocation(c)
set c=null
endfunction

function Trig_PrismRockets_Actions takes nothing returns nothing
local timer t=CreateTimer()
local unit b=GetSpellAbilityUnit()
local location d=GetSpellTargetLoc()
local real x=GetLocationX(d)
local real y=GetLocationY(d)
call RemoveLocation(d)
set d=null
call SaveTimerHandle(LS(),GetHandleId(b),StringHash("PrismRocket_Timer"),t)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),b)
call SaveInteger(LS(),GetHandleId(t),StringHash("PrismRocket_Port"),0)
call SaveReal(LS(),GetHandleId(t),StringHash("x"),x)
call SaveReal(LS(),GetHandleId(t),StringHash("y"),y)
call TimerStart(t,0.25,true,function PrismRockets_Fire)
endfunction

//===========================================================================
function InitTrig_PrismRockets takes nothing returns nothing
    set gg_trg_PrismRockets = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PrismRockets, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
    call TriggerAddCondition( gg_trg_PrismRockets, Condition( function Trig_PrismRockets_Conditions ) )
    call TriggerAddAction( gg_trg_PrismRockets, function Trig_PrismRockets_Actions )
endfunction

