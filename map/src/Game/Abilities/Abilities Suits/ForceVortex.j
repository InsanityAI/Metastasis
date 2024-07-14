//TESH.scrollpos=71
//TESH.alwaysfold=0
function Trig_ForceVortex_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06A' ) ) then
        return false
    endif
    return true
endfunction


function ForceVortex_PushBack takes nothing returns nothing
local location b=GetUnitLoc(GetEnumUnit())
if GetUnitPointValue(GetEnumUnit())!=37 and GetUnitAbilityLevel(GetEnumUnit(),'Aloc')!=1 then
call Push2(GetEnumUnit(),800.0,400.0,AngleBetweenPoints(udg_TempPoint,b))
endif
call RemoveLocation(b)
set b=null
endfunction

function ForceVortex_Slide takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
local real zvelocity=LoadReal(LS(),GetHandleId(k),StringHash("zvelocity"))
local real c=LoadReal(LS(), GetHandleId(k), StringHash("angle"))
local real height=LoadReal(LS(),GetHandleId(k),StringHash("height"))
local real zforce=LoadReal(LS(),GetHandleId(k),StringHash("force"))
local location a=GetUnitLoc(l)
local location b=PolarProjectionBJ(a,zforce,c)
call SetUnitFlyHeight(l,height-GetLocationZ(a),0)
if GetLocationZ(b) > height then
//If the collision is a result of the projectile falling then...
if GetLocationZ(a) == GetLocationZ(b) then
set height=GetLocationZ(b)
set zvelocity=-0.5*zvelocity
else
if GetTerrainCliffLevelBJ(b)>GetTerrainCliffLevelBJ(a) then
call KillUnit(l)
endif
endif
endif
call SetUnitPositionLoc(l,b)
call SetUnitFacing(l,c)
call RemoveLocation(b)
call RemoveLocation(a)
if IsUnitDeadBJ(l) then
call PauseTimer(k)
call DestroyTimer(k)
set udg_TempUnit=l
set udg_TempPoint=GetUnitLoc(l)
set udg_TempUnitGroup=GetUnitsInRangeOfLocAll(220.0,udg_TempPoint)
call ForGroup(udg_TempUnitGroup,function ForceVortex_PushBack)
call RemoveLocation(udg_TempPoint)
call DestroyGroup(udg_TempUnitGroup)
call CreateScaledEffect("war3mapImported\\IceSparks.mdx",1,6.0,GetUnitX(l),GetUnitY(l))
call SetSoundPosition(gg_snd_BlueFireBurst,GetUnitX(l),GetUnitY(l),0)
call PlaySoundBJ(gg_snd_BlueFireBurst)
endif
call SaveReal(LS(),GetHandleId(k),StringHash("height"),height+zvelocity/25.0)
call SaveReal(LS(),GetHandleId(k),StringHash("zvelocity"),zvelocity-40)
call SaveReal(LS(),GetHandleId(k),StringHash("angle"),c)
endfunction


function Trig_ForceVortex_Actions takes nothing returns nothing
local timer k=CreateTimer()
local real r
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2 = GetSpellTargetLoc()
    set r=DistanceBetweenPoints(udg_TempPoint,udg_TempPoint2)
    if r > 900.0 then
    set r=900.0
    endif
    call SetUnitAnimation(GetSpellAbilityUnit(),"spell throw")
        call SaveReal(LS(),GetHandleId(k),StringHash("height"),GetLocationZ(udg_TempPoint))
            call SaveReal(LS(),GetHandleId(k),StringHash("force"),r/900.0*450/25.0)
    set udg_TempBool = false
    call CreateNUnitsAtLoc( 1, 'e01S', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
    call TimerStart(k,0.04,true,function ForceVortex_Slide)
    call SaveReal(LS(),GetHandleId(k),StringHash("angle"),GetUnitFacing(GetLastCreatedUnit()))
    call SaveReal(LS(),GetHandleId(k),StringHash("zvelocity"),600.0)


endfunction

//===========================================================================
function InitTrig_ForceVortex takes nothing returns nothing
    set gg_trg_ForceVortex = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ForceVortex, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ForceVortex, Condition( function Trig_ForceVortex_Conditions ) )
    call TriggerAddAction( gg_trg_ForceVortex, function Trig_ForceVortex_Actions )
endfunction

