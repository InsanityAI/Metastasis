function Trig_RUMAcquire_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RUMAcquire_Func003Func002C takes nothing returns boolean 
    if(not(GetUnitAbilityLevelSwapped('A06W', udg_TempUnit) == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RUMAcquire_Func003C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetSpellTargetUnit()) == 'h001')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_RUMAcquire_Actions takes nothing returns nothing 
    if(Trig_RUMAcquire_Func003C()) then 
        set udg_TempUnit = udg_SS_Space[GetUnitUserData(GetSpellTargetUnit())] 
        if(Trig_RUMAcquire_Func003Func002C()) then 
            call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "This raptor has already been upgraded!") 
            return 
        else 
        endif 
        set udg_TempUnit2 = GetSpellTargetUnit() 
        set udg_TempPoint = GetUnitLoc(GetSpellTargetUnit()) 
        call RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01U')) 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl") 
        call SFXThreadClean() 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Other\\Awaken\\Awaken.mdl") 
        call SFXThreadClean() 
        call RemoveLocation(udg_TempPoint) 
        call SetUnitAbilityLevelSwapped('A003', udg_TempUnit, 2) 
        call SetUnitVertexColorBJ(udg_TempUnit2, 100.00, 60.00, 40.00, 0) 
        call SetUnitAbilityLevelSwapped('A002', udg_TempUnit, 2) 
        call SetUnitVertexColorBJ(udg_TempUnit, 100.00, 50.00, 40.00, 0) 
        call UnitAddAbilityBJ('A06W', udg_TempUnit) 
        call UnitAddAbilityBJ('A06X', udg_TempUnit) 
        call UnitAddAbilityBJ('A06Y', udg_TempUnit) 
        call UnitAddAbilityBJ('A06Z', udg_TempUnit) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_RUMAcquire takes nothing returns nothing 
    set gg_trg_RUMAcquire = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_RUMAcquire, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_RUMAcquire, Condition(function Trig_RUMAcquire_Conditions)) 
    call TriggerAddAction(gg_trg_RUMAcquire, function Trig_RUMAcquire_Actions) 
endfunction 

