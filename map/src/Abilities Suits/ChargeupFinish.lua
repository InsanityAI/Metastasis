//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ChargeupFinish_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A04K' ) ) then
        return false
    endif
    return true
endfunction

function ChargeupDischarge takes nothing returns nothing
    local trigger t=GetTriggeringTrigger()
    local unit a=LoadUnitHandle(LS(),GetHandleId(t),StringHash("unit"))
    local unit b
    
    if GetAttacker()==a then
        set b=GetTriggerUnit()
        call UnitRemoveAbility(a,'A093')
        call UnitDamageTarget(a,b,155.0,true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        set bj_lastCreatedEffect=AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",GetUnitX(b),GetUnitY(b))
        call SFXThreadClean()
        call FlushChildHashtable(LS(),GetHandleId(t))
        call DestroyTrigger(t)
        call PolledWait(0.4)
        call UnitRemoveAbility(a,'Alit')
    endif
endfunction

function Trig_ChargeupFinish_Actions takes nothing returns nothing
    local trigger t=CreateTrigger()
    local unit a=GetSpellAbilityUnit()
    //200 radius, 150 dmg
    call DamageAreaForPlayer(GetOwningPlayer(GetSpellAbilityUnit()),200.0,150.0,GetUnitX(GetSpellAbilityUnit()),GetUnitY(GetSpellAbilityUnit()))
    call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ATTACKED)
    call SaveUnitHandle(LS(),GetHandleId(t),StringHash("unit"),a)
    call TriggerAddAction(t,function ChargeupDischarge)
    call UnitAddAbility(a,'Alit')
    call UnitAddAbility(a,'A093')
    call PolledWait(8.0)
    call FlushChildHashtable(LS(),GetHandleId(t))
    call DestroyTrigger(t)
    call UnitRemoveAbility(a,'Alit')
    call UnitRemoveAbility(a,'A093')
endfunction

//===========================================================================
function InitTrig_ChargeupFinish takes nothing returns nothing
    set gg_trg_ChargeupFinish = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ChargeupFinish, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ChargeupFinish, Condition( function Trig_ChargeupFinish_Conditions ) )
    call TriggerAddAction( gg_trg_ChargeupFinish, function Trig_ChargeupFinish_Actions )
endfunction