//TESH.scrollpos=18
//TESH.alwaysfold=0
function Trig_Entropy_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03M' ) ) then
        return false
    endif
    return true
endfunction


function Entropy_Suck_Enum takes nothing returns nothing
local real r=0
local real m=0
local real q=TimerGetElapsed(udg_GameTimer)
if HaveSavedReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_SuckLeniency")) then
set r=LoadReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_SuckLeniency"))
set m=LoadReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_LastSuck"))
else
set r=0
set m=q
endif
if q-m>5 then
call SaveReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_SuckLeniency"),0)
set r=0
endif
call SaveReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_LastSuck"),q)
call SaveReal(LS(),GetHandleId(GetEnumUnit()),StringHash("Entropy_SuckLeniency"),r+(1-r)/30)
if udg_TempUnit4 != GetEnumUnit() and IsPlayerAlien(GetOwningPlayer(GetEnumUnit()))!=true then
call Push2(GetEnumUnit(),250.0*(1-r),160.0*(1-r),AngleBetweenUnits(GetEnumUnit(),udg_TempUnit4))
endif
endfunction

function Entropy_Suck takes nothing returns nothing
local timer t=GetExpiredTimer()
local unit q=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
local location om=GetUnitLoc(q)
local group g
set g=GetUnitsInRangeOfLocAll(600.0,om)
set udg_TempPoint=om
set udg_TempUnit4=q
call ForGroup(g,function Entropy_Suck_Enum)
call DestroyGroup(g)
set g=null
call RemoveLocation(om)
set om=null
endfunction
function Trig_Entropy_Actions takes nothing returns nothing
local location b=GetSpellTargetLoc()
local timer t=CreateTimer()
local unit o
call AddSpecialEffectLoc("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl",b)
    call CreateNUnitsAtLoc( 1, 'e00N', Player(bj_PLAYER_NEUTRAL_EXTRA), b, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
        call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),GetLastCreatedUnit())
        set o=GetLastCreatedUnit()
            call TimerStart(t,2,true,function Entropy_Suck)
    loop
    exitwhen 1==2
    call IssuePointOrderLocBJ( o, "blizzard", b )
call PolledWait(300)
    endloop
endfunction

//===========================================================================
function InitTrig_Entropy takes nothing returns nothing
    set gg_trg_Entropy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Entropy, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Entropy, Condition( function Trig_Entropy_Conditions ) )
    call TriggerAddAction( gg_trg_Entropy, function Trig_Entropy_Actions )
endfunction

