//TESH.scrollpos=48
//TESH.alwaysfold=0
function Trig_Solace_Shield_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A054' ) ) then
        return false
    endif
    return true
endfunction
function CreateBarSolaceShield takes integer howmanybars, integer maximumbars, unit r returns texttag
local string text = "|c000000FF"
local integer i =0
loop
exitwhen i > howmanybars
set i=i+1
set text = text + "I"
endloop
set text = text + "|r"
set i=0
loop
exitwhen i > (maximumbars - howmanybars)
set i=i+1
set text = text + "I"
endloop
call  CreateTextTagUnitBJ(text,r,GetUnitFlyHeight(r),8,255,255,255,0)
call SetTextTagPermanent(bj_lastCreatedTextTag,false)
call SetTextTagLifespan(bj_lastCreatedTextTag,0.5)
    call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 0.00 )
return bj_lastCreatedTextTag
endfunction
function ShieldDamaged takes nothing returns nothing
call BlockDamage(GetTriggerUnit(),GetEventDamage())
set udg_ShieldHP[GetUnitAN(GetTriggerUnit())] = udg_ShieldHP[GetUnitAN(GetTriggerUnit())] - GetEventDamage()
if udg_ShieldHP[GetUnitAN(GetTriggerUnit())] <= 0.00 then
call DestroyTrigger(GetTriggeringTrigger())
call UnitRemoveBuffBJ('B00X',GetTriggerUnit())
set udg_ShieldHP[GetUnitAN(GetTriggerUnit())] = 0.00
else
call CreateBarSolaceShield(R2I(udg_ShieldHP[GetUnitAN(GetTriggerUnit())]/10),30,GetTriggerUnit())
endif
if GetUnitState(GetTriggerUnit(),UNIT_STATE_LIFE) <= 0 then
call ReviveHero(GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),false)
endif
endfunction

function SolaceShield_Disable takes nothing returns nothing
local timer k=GetExpiredTimer()
local unit x=LoadUnitHandle(LS(),GetHandleId(k),StringHash("unit"))
set udg_ShieldHP[GetUnitAN(x)] = 0
call UnitDamageTarget(x,x,0.00,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
call FlushChildHashtable(LS(),GetHandleId(k))
call DestroyTimer(k)
endfunction

function Trig_Solace_Shield_Actions takes nothing returns nothing
local trigger t
local unit x= GetSpellTargetUnit()
local timer k=LoadTimerHandle(LS(),GetHandleId(GetSpellTargetUnit()),StringHash("Solace_Shield_Disable"))
if k == null then
set k=CreateTimer()
call SaveUnitHandle(LS(),GetHandleId(k),StringHash("unit"),GetSpellTargetUnit())
endif
if udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())] != 0.00 then
return
endif
set t=CreateTrigger()
    call TriggerRegisterUnitEvent( t, GetSpellTargetUnit(), EVENT_UNIT_DAMAGED )
call TriggerAddAction(t,function ShieldDamaged)
set udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())] = 300 + udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())]
call TimerStart(k,15.0,false,function SolaceShield_Disable)
//call PolledWait(15.0)

endfunction

//===========================================================================
function InitTrig_Solace_Shield takes nothing returns nothing
    set gg_trg_Solace_Shield = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Solace_Shield, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Solace_Shield, Condition( function Trig_Solace_Shield_Conditions ) )
    call TriggerAddAction( gg_trg_Solace_Shield, function Trig_Solace_Shield_Actions )
endfunction

