function Trig_Smash_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A098')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Smash_Func006C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellAbilityUnit()) == 'h01G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Smash_Func040Func001Func001C takes nothing returns boolean 
    if(not(GetDestructableTypeId(GetEnumDestructable()) != 'DTrx')) then 
        return false 
    endif 
    if(not(GetDestructableTypeId(GetEnumDestructable()) != 'YT40')) then 
        return false 
    endif 
    if(not(GetDestructableTypeId(GetEnumDestructable()) != 'YT16')) then 
        return false 
    endif 
    if(not(GetDestructableTypeId(GetEnumDestructable()) != 'YT06')) then 
        return false 
    endif 
    if(not(GetDestructableTypeId(GetEnumDestructable()) != 'YT30')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Smash_Func040Func001C takes nothing returns boolean 
    if(not Trig_Smash_Func040Func001Func001C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Smash_Func040A takes nothing returns nothing 
    if(Trig_Smash_Func040Func001C()) then 
        call UnitDamageTarget(udg_TempUnit, GetEnumDestructable(), 1500.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
    else 
    endif 
endfunction 

function Trig_Smash_Actions takes nothing returns nothing 
    local unit a = GetSpellAbilityUnit() 
    local location b = GetSpellTargetLoc() 
    local trigger t = CreateTrigger() 
    if(Trig_Smash_Func006C()) then 
        call SetUnitTimeScalePercent(GetSpellAbilityUnit(), 5.50) 
    else 
        call SetUnitTimeScalePercent(GetSpellAbilityUnit(), 9.70) 
    endif 
    call SmashEnsureNoOrders(a) 
    call TriggerSleepAction(0.00) 
    if not(SmashCheckEnsure(a)) then 
        call SmashCheckCleanup(a) 
        set udg_TempUnit = a 
        call SetUnitTimeScalePercent(udg_TempUnit, 100.00) 
        return 
    endif 
    call SetUnitAnimation(GetSpellAbilityUnit(), "attack") 
    call TriggerSleepAction(3.50) 
    if not(SmashCheckEnsure(a)) then 
        call SmashCheckCleanup(a) 
        set udg_TempUnit = a 
        call SetUnitTimeScalePercent(udg_TempUnit, 175.00) 
        return 
    endif 
    call SetUnitTimeScalePercent(GetSpellAbilityUnit(), 0.00) 
    set udg_TempUnit = a 
    call SetUnitTimeScalePercent(udg_TempUnit, 175.00) 
    call TriggerSleepAction(0.00) 
    if not(SmashCheckEnsure(a)) then 
        call SmashCheckCleanup(a) 
        set udg_TempUnit = a 
        call SetUnitTimeScalePercent(udg_TempUnit, 175.00) 
        return 
    endif 
    call SmashCheckCleanup(a) 
    set udg_TempUnit = a 
    set udg_TempPoint2 = b 
    call SetUnitTimeScalePercent(udg_TempUnit, 100.00) 
    call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl") 
    call SFXThreadClean() 
    call DamageAreaForPlayer(GetOwningPlayer(a), 120.0, 1500, GetLocationX(udg_TempPoint2), GetLocationY(udg_TempPoint2)) 
    call EnumDestructablesInCircleBJ(120.00, udg_TempPoint2, function Trig_Smash_Func040A) 
    call RemoveLocation(udg_TempPoint2) 
endfunction 

//=========================================================================== 
function InitTrig_Smash takes nothing returns nothing 
    set gg_trg_Smash = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Smash, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Smash, Condition(function Trig_Smash_Conditions)) 
    call TriggerAddAction(gg_trg_Smash, function Trig_Smash_Actions) 
endfunction 

