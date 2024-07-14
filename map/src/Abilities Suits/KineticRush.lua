//TESH.scrollpos=0
//TESH.alwaysfold=0
function KineticRush_Condition takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05T' or GetSpellAbilityId() == 'A08X') ) then
        return false
    endif
    return true
endfunction

function KineticRush_PushAway takes nothing returns nothing
local trigger t=GetTriggeringTrigger()
local unit a=LoadUnitHandle(LS(), GetHandleId(t), StringHash("t"))
if GetUnitAbilityLevel(GetTriggerUnit(), 'Avul')==0 and IsUnitAliveBJ(GetTriggerUnit()) and GetUnitPointValue(GetTriggerUnit()) != 37 and LoadUnitHandle(LS(), GetHandleId(t), StringHash("caster")) != GetTriggerUnit() then
call UnitDamageTarget(a,GetTriggerUnit(),60.0,true,true,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call Push2(GetTriggerUnit(),500.0,230.0,AngleBetweenUnits(a,GetTriggerUnit()))
endif

endfunction


function Trig_KineticRush_Actions takes nothing returns nothing
local trigger t=CreateTrigger()
local unit a=GetSpellAbilityUnit()
local location b=GetSpellTargetLoc()
call PolledWait(0.01)
call TriggerRegisterUnitInRange(t,a,90.0,null)
call TriggerAddAction(t,function KineticRush_PushAway)
call SaveUnitHandle(LS(),GetHandleId(t),StringHash("t"),a)
    set udg_TempPoint = GetUnitLoc(a)
    set udg_TempPoint2 = b
    call Push2(a,800.0,250.0,AngleBetweenPoints(udg_TempPoint,udg_TempPoint2))
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
    call PolledWait(4.0)
    call FlushChildHashtable(LS(),GetHandleId(t))
    call DestroyTrigger(t)
    set t=null
endfunction

//===========================================================================
function InitTrig_KineticRush takes nothing returns nothing
    set gg_trg_KineticRush = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_KineticRush, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddAction( gg_trg_KineticRush, function Trig_KineticRush_Actions )
    call TriggerAddCondition(gg_trg_KineticRush,Condition(function KineticRush_Condition))
endfunction

