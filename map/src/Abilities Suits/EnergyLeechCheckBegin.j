//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_EnergyLeechCheckBegin_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A07X' ) ) then
        return false
    endif
    return true
endfunction

function EnergyLeechCheck_Again takes nothing returns nothing
local timer l=GetExpiredTimer()
local unit abil=LoadUnitHandle(LS(),GetHandleId(l),StringHash("unit"))
local unit targ=LoadUnitHandle(LS(),GetHandleId(l),StringHash("unit2"))

//Target is out of mana
if GetUnitState(targ,UNIT_STATE_MANA) <= 1 then
    call IssueImmediateOrder(abil,"stop")
endif
endfunction

function Trig_EnergyLeechCheckBegin_Actions takes nothing returns nothing
    local timer l=CreateTimer()
    call SaveTimerHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("EnergyLeech_CheckTimer"),l)
    call SaveUnitHandle(LS(),GetHandleId(l),StringHash("unit"),GetSpellAbilityUnit())
    call SaveUnitHandle(LS(),GetHandleId(l),StringHash("unit2"),GetSpellTargetUnit())
    call TimerStart(l,0.1,true,function EnergyLeechCheck_Again)
endfunction

//===========================================================================
function InitTrig_EnergyLeechCheckBegin takes nothing returns nothing
    set gg_trg_EnergyLeechCheckBegin = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_EnergyLeechCheckBegin, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_EnergyLeechCheckBegin, Condition( function Trig_EnergyLeechCheckBegin_Conditions ) )
    call TriggerAddAction( gg_trg_EnergyLeechCheckBegin, function Trig_EnergyLeechCheckBegin_Actions )
endfunction

