//TESH.scrollpos=1
//TESH.alwaysfold=0
function Trig_Shockwave_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A08U' ) ) then
        return false
    endif
    return true
endfunction

function Shockwave_Slide takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit l=LoadUnitHandle(LS(), GetHandleId(k), StringHash("slide"))
local location a=GetUnitLoc(l)
local location b=PolarProjectionBJ(a,35.0,GetUnitFacing(l))
call RemoveLocation(a)
if IsPointPathable(GetLocationX(b),GetLocationY(b),false) then
call SetUnitPositionLoc(l,b)
else
call KillUnit(l)
endif
call RemoveLocation(b)
if IsUnitDeadBJ(l) then
call DestroyTrigger(LoadTriggerHandle(LS(),GetHandleId(k),StringHash("trig")))
call PauseTimer(k)
call DestroyTimer(k)

endif
endfunction

function Shockwave_Damage takes nothing returns nothing
local trigger t=GetTriggeringTrigger()
local unit a=LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit"))
local unit b=GetTriggerUnit()
if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul')==0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then
call UnitDamageTarget(a,GetTriggerUnit(), 75,false,false,ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
call Push2(b,300.0,200.0,GetUnitFacing(a))
set bj_lastCreatedEffect=AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",b,"origin")
call SFXThreadClean()
endif
endfunction

function Trig_Shockwave_Actions takes nothing returns nothing
local timer k=CreateTimer()
local trigger t=CreateTrigger()
local location b=GetUnitLoc(GetSpellAbilityUnit())
call PlaySound3D("Abilities\\Spells\\Orc\\Shockwave\\Shockwave.wav",GetLocationX(b),GetLocationY(b))
    set udg_TempPoint2 = GetSpellTargetLoc()
    set udg_TempPoint = PolarProjectionBJ(b,85.0,AngleBetweenPoints(b,udg_TempPoint2))
    call RemoveLocation(b)
    set udg_TempBool = false
    call CreateNUnitsAtLoc( 1, 'e035', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call RemoveLocation( udg_TempPoint3 )
    call SaveUnitHandle(LS(), GetHandleId(k), StringHash("slide"), GetLastCreatedUnit())
    call TimerStart(k,0.04,true,function Shockwave_Slide)
    call SaveTriggerHandle(LS(),GetHandleId(k),StringHash("trig"),t)
    call TriggerRegisterUnitInRangeSimple(t,100.0, GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), GetLastCreatedUnit())
    call SaveUnitHandle(LS(), GetHandleId(t), StringHash("caster"), GetSpellAbilityUnit())   
    call TriggerAddAction(t, function Shockwave_Damage)
endfunction

//===========================================================================
function InitTrig_Shockwave takes nothing returns nothing
    set gg_trg_Shockwave = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Shockwave, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Shockwave, Condition( function Trig_Shockwave_Conditions ) )
    call TriggerAddAction( gg_trg_Shockwave, function Trig_Shockwave_Actions )
endfunction

